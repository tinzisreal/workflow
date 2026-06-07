# Stop the brainstorm server and clean up on Windows
# Usage: stop-server.ps1 <session_dir>

param (
    [string]$SessionDir = ""
)

if (-not $SessionDir) {
    if ($args.Count -gt 0) {
        $SessionDir = $args[0]
    }
}

if (-not $SessionDir) {
    Write-Output '{"error": "Usage: stop-server.ps1 <session_dir>"}'
    exit 1
}

# Normalize paths for cross-platform compatibility
$SessionDir = $SessionDir.Replace('\', '/')
$StateDir = (Join-Path $SessionDir "state").Replace('\', '/')
$PidFile = (Join-Path $StateDir "server.pid").Replace('\', '/')

if (Test-Path $PidFile) {
    $TargetPid = [int](Get-Content $PidFile -Raw).Trim()
    
    # Try to stop gracefully
    try {
        Stop-Process -Id $TargetPid -ErrorAction SilentlyContinue
    } catch {}
    
    # Wait for graceful shutdown (up to 2s)
    $Stopped = $false
    for ($i = 1; $i -le 20; $i++) {
        $Proc = Get-Process -Id $TargetPid -ErrorAction SilentlyContinue
        if (-not $Proc -or $Proc.HasExited) {
            $Stopped = $true
            break
        }
        Start-Sleep -Milliseconds 100
    }
    
    # If still running, escalate to Force
    if (-not $Stopped) {
        try {
            Stop-Process -Id $TargetPid -Force -ErrorAction SilentlyContinue
        } catch {}
        Start-Sleep -Milliseconds 100
    }
    
    # Verify process is dead
    $Proc = Get-Process -Id $TargetPid -ErrorAction SilentlyContinue
    if ($Proc -and -not $Proc.HasExited) {
        Write-Output '{"status": "failed", "error": "process still running"}'
        exit 1
    }
    
    Remove-Item $PidFile -Force -ErrorAction SilentlyContinue
    Remove-Item (Join-Path $StateDir "server.log") -Force -ErrorAction SilentlyContinue
    Remove-Item (Join-Path $StateDir "server.err.log") -Force -ErrorAction SilentlyContinue
    
    # Only delete ephemeral temp directories
    $TempDir = $env:TEMP.Replace('\', '/')
    if ($SessionDir -like "*$TempDir*" -or $SessionDir -like "*/tmp/*") {
        Remove-Item $SessionDir -Recurse -Force -ErrorAction SilentlyContinue
    }
    
    Write-Output '{"status": "stopped"}'
} else {
    Write-Output '{"status": "not_running"}'
}
