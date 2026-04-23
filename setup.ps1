# WezTerm Config セットアップスクリプト
# 管理者権限の PowerShell で実行してください
#
# 使い方:
#   cd ~\repos\wezterm-config
#   .\setup.ps1

$ErrorActionPreference = "Stop"

$repoDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$sourceDir = Join-Path $repoDir "wezterm"
$targetDir = Join-Path $env:USERPROFILE ".config\wezterm"

Write-Host "=== WezTerm Config Setup ===" -ForegroundColor Cyan
Write-Host "Source: $sourceDir"
Write-Host "Target: $targetDir"
Write-Host ""

# 既存の .wezterm.lua をバックアップ
$oldConfig = Join-Path $env:USERPROFILE ".wezterm.lua"
if (Test-Path $oldConfig) {
    $backup = "$oldConfig.backup"
    Write-Host "Backup .wezterm.lua -> $backup" -ForegroundColor Yellow
    Copy-Item $oldConfig $backup -Force
}

# ターゲットが既に存在する場合は削除またはバックアップ
if (Test-Path $targetDir) {
    $item = Get-Item $targetDir
    if ($item.LinkType -eq "SymbolicLink") {
        Write-Host "Removing existing symlink" -ForegroundColor Yellow
        $item.Delete()
    }
    else {
        $backup = "$targetDir.backup"
        Write-Host "Backup existing config -> $backup" -ForegroundColor Yellow
        if (Test-Path $backup) {
            Remove-Item $backup -Recurse -Force
        }
        Move-Item $targetDir $backup
    }
}

# 親ディレクトリを作成
$parentDir = Split-Path -Parent $targetDir
if (-not (Test-Path $parentDir)) {
    New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
}

# シンボリックリンクを作成
New-Item -ItemType SymbolicLink -Path $targetDir -Target $sourceDir | Out-Null

Write-Host ""
Write-Host "Setup complete!" -ForegroundColor Green
Write-Host "Symlink: $targetDir -> $sourceDir"
Write-Host ""
Write-Host "Restart WezTerm or press CTRL+SHIFT+R to reload config."
