# Start the brainstorm server and output connection info on Windows
# Usage: start-server.ps1 [--project-dir <path>] [--host <bind-host>] [--url-host <display-host>] [--foreground] [--background]

# Parse arguments
$ProjectDir = ""
$ForegroundMode = $false
$BackgroundMode = $false
$BindHost = "127.0.0.1"
$UrlHost = ""

for ($i = 0; $i -lt $args.Count; $i++) {
    switch ($args[$i]) {
        "--project-dir" {
            $ProjectDir = $args[++$i]
        }
        "--host" {
            $BindHost = $args[++$i]
        }
        "--url-host" {
            $UrlHost = $args[++$i]
        }
        "--foreground" {
            $ForegroundMode = $true
        }
        "--no-daemon" {
            $ForegroundMode = $true
        }
        "--background" {
            $BackgroundMode = $true
        }
        "--daemon" {
            $BackgroundMode = $true
        }
        default {
            Write-Error "Unknown argument: $($args[$i])"
            exit 1
        }
    }
}

if (-not $UrlHost) {
    if ($BindHost -eq "127.0.0.1" -or $BindHost -eq "localhost") {
        $UrlHost = "localhost"
    } else {
        $UrlHost = $BindHost
    }
}

# Auto-foreground under CODEX_CI
$Foreground = $ForegroundMode
if ($env:CODEX_CI -and -not $ForegroundMode -and -not $BackgroundMode) {
    $Foreground = $true
}

# Generate unique session directory
$Epoch = [int]([DateTimeOffset]::Now.ToUnixTimeSeconds())
$SessionId = "${PID}-${Epoch}"

if ($ProjectDir) {
    $SessionDir = Join-Path $ProjectDir ".superpowers/brainstorm/${SessionId}"
} else {
    $SessionDir = Join-Path $env:TEMP "brainstorm-${SessionId}"
}

# Normalize paths for cross-platform node compatibility
$SessionDir = $SessionDir.Replace('\', '/')
$StateDir = (Join-Path $SessionDir "state").Replace('\', '/')
$PidFile = (Join-Path $StateDir "server.pid").Replace('\', '/')
$LogFile = (Join-Path $StateDir "server.log").Replace('\', '/')
$ErrLogFile = (Join-Path $StateDir "server.err.log").Replace('\', '/')

# Create fresh session directory with content and state peers
New-Item -ItemType Directory -Force -Path (Join-Path $SessionDir "content") | Out-Null
New-Item -ItemType Directory -Force -Path $StateDir | Out-Null

# Kill any existing server
if (Test-Path $PidFile) {
    try {
        $OldPid = [int](Get-Content $PidFile -Raw -ErrorAction SilentlyContinue).Trim()
        Stop-Process -Id $OldPid -Force -ErrorAction SilentlyContinue
    } catch {}
    Remove-Item $PidFile -Force -ErrorAction SilentlyContinue
}

# Resolve the owner PID (parent of the current process)
$OwnerPid = $PID
try {
    if (Get-Command Get-CimInstance -ErrorAction SilentlyContinue) {
        $OwnerPid = (Get-CimInstance Win32_Process -Filter "ProcessId = $PID").ParentProcessId
    } elseif (Get-Command Get-WmiObject -ErrorAction SilentlyContinue) {
        $OwnerPid = (Get-WmiObject Win32_Process -Filter "ProcessId = $PID").ParentProcessId
    }
} catch {}

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Push-Location $ScriptDir

# Set environment variables for the node server
$env:BRAINSTORM_DIR = $SessionDir
$env:BRAINSTORM_HOST = $BindHost
$env:BRAINSTORM_URL_HOST = $UrlHost
$env:BRAINSTORM_OWNER_PID = $OwnerPid

if ($Foreground) {
    [System.IO.File]::WriteAllText($PidFile, $PID.ToString())
    node server.cjs
    $ExitCode = $LASTEXITCODE
    Pop-Location
    exit $ExitCode
}

# Background execution using Start-Process
$Process = Start-Process node -ArgumentList "server.cjs" -NoNewWindow -PassThru -RedirectStandardOutput $LogFile -RedirectStandardError $ErrLogFile
$ServerPid = $Process.Id
[System.IO.File]::WriteAllText($PidFile, $ServerPid.ToString())

# Wait for server-started message (check log file)
$Found = $false
for ($i = 1; $i -le 50; $i++) {
    if (Test-Path $LogFile) {
        $Content = Get-Content $LogFile -Raw -ErrorAction SilentlyContinue
        if ($Content -match "server-started") {
            # Verify server is still alive after a short window
            $Alive = $true
            for ($j = 1; $j -le 20; $j++) {
                $Proc = Get-Process -Id $ServerPid -ErrorAction SilentlyContinue
                if (-not $Proc -or $Proc.HasExited) {
                    $Alive = $false
                    break
                }
                Start-Sleep -Milliseconds 100
            }
            if (-not $Alive) {
                Write-Error "{\"error\": \"Server started but was killed. Retry in a persistent terminal with foreground mode.\"}"
                Pop-Location
                exit 1
            }
            # Print the server-started line
            $Content -split "`n" | Where-Object { $_ -match "server-started" } | Select-Object -First 1 | Write-Output
            $Found = $true
            break
        }
    }
    Start-Sleep -Milliseconds 100
}

if (-not $Found) {
    Write-Output '{"error": "Server failed to start within 5 seconds"}'
    Pop-Location
    exit 1
}

Pop-Location
exit 0
