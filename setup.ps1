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

# 既存の設定をバックアップ
$oldConfig = Join-Path $env:USERPROFILE ".wezterm.lua"
if (Test-Path $oldConfig) {
    $backup = "$oldConfig.backup"
    Write-Host "既存の .wezterm.lua をバックアップ: $backup" -ForegroundColor Yellow
    Copy-Item $oldConfig $backup -Force
}

# ターゲットディレクトリが既に存在する場合
if (Test-Path $targetDir) {
    $isLink = (Get-Item $targetDir).Attributes -band [System.IO.FileAttributes]::ReparsePoint
    if ($isLink) {
        Write-Host "既存のシンボリックリンクを削除します" -ForegroundColor Yellow
        Remove-Item $targetDir -Force
    } else {
        $backup = "$targetDir.backup"
        Write-Host "既存の設定ディレクトリをバックアップ: $backup" -ForegroundColor Yellow
        if (Test-Path $backup) { Remove-Item $backup -Recurse -Force }
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
Write-Host "セットアップ完了!" -ForegroundColor Green
Write-Host "シンボリックリンク: $targetDir -> $sourceDir"
Write-Host ""
Write-Host "WezTerm を再起動するか CTRL+SHIFT+R で設定をリロードしてください。"
