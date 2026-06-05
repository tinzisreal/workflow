# Active verification of requirements
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "Initializing Unified AI Agent Workspace" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan

# 1. Check Node.js
if (Get-Command node -ErrorAction SilentlyContinue) {
    $nodeVersion = node -v
    Write-Host "[OK] Node.js is installed ($nodeVersion)" -ForegroundColor Green
} else {
    Write-Host "[ERROR] Node.js is required to run OpenClaw and GitNexus. Please install Node.js (v22.16+)." -ForegroundColor Red
    Exit
}

# 2. Install dependencies globally
Write-Host "Installing/Updating GitNexus..." -ForegroundColor Yellow
npm install -g gitnexus

Write-Host "Installing/Updating OpenClaw..." -ForegroundColor Yellow
npm install -g openclaw

Write-Host "Installing TencentDB Agent Memory Plugin..." -ForegroundColor Yellow
openclaw plugins install @tencentdb-agent-memory/memory-tencentdb

# 2.1 Check Python & Install MarkItDown
if (Get-Command python -ErrorAction SilentlyContinue) {
    Write-Host "Installing/Updating Microsoft MarkItDown..." -ForegroundColor Yellow
    python -m pip install --upgrade markitdown
    Write-Host "[OK] Microsoft MarkItDown is installed." -ForegroundColor Green
} else {
    Write-Host "[WARNING] Python is not installed. Microsoft MarkItDown (/read-doc skill) will not work until Python is installed." -ForegroundColor Yellow
}


# 3. Create OpenClaw config directory if not exists
$openclawDir = Join-Path $env:USERPROFILE ".openclaw"
if (!(Test-Path $openclawDir)) {
    New-Item -ItemType Directory -Path $openclawDir -Force | Out-Null
}

# Write OpenClaw Configuration
$configPath = Join-Path $openclawDir "openclaw.json"
$configContent = @{
    "memory-tencentdb" = @{
        "enabled" = $true
    }
} | ConvertTo-Json -Depth 5
Set-Content -Path $configPath -Value $configContent
Write-Host "[OK] OpenClaw Configuration updated at $configPath" -ForegroundColor Green

# 4. Launch services in new PowerShell sessions
Write-Host "Launching GitNexus service in a separate window..." -ForegroundColor Green
Start-Process powershell -ArgumentList "-NoExit", "-Command", "gitnexus start"

Write-Host "Launching OpenClaw Gateway (TencentDB Memory Server) in a separate window..." -ForegroundColor Green
Start-Process powershell -ArgumentList "-NoExit", "-Command", "openclaw gateway start"

Write-Host "=============================================" -ForegroundColor Green
Write-Host "Workspace Setup Complete! Your agent stack is live." -ForegroundColor Green
Write-Host "Add .mcp-registry.json to your agent clients to connect." -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Green
