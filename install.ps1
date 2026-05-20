# Installation script for Pantheon Framework (Windows/PowerShell)
$ErrorActionPreference = "Stop"

$ClaudeDir = Join-Path $HOME ".claude"
$CodexDir = Join-Path $HOME ".codex"
$InstalledAny = $false

Write-Host "Installing Pantheon Framework..." -ForegroundColor Cyan

# Detect Claude Code
if (Test-Path $ClaudeDir) {
    Write-Host "Claude Code detected at $ClaudeDir"
    $ClaudeCommandsTarget = Join-Path $ClaudeDir "commands\pantheon"
    $ClaudeSkillsTarget = Join-Path $ClaudeDir "commands\pantheon-skills"
    
    New-Item -ItemType Directory -Force -Path $ClaudeCommandsTarget | Out-Null
    New-Item -ItemType Directory -Force -Path $ClaudeSkillsTarget | Out-Null
    
    Write-Host "Copying commands to Claude Code..."
    Copy-Item -Path "commands\pantheon\*" -Destination $ClaudeCommandsTarget -Recurse -Force
    
    Write-Host "Copying skills to Claude Code..."
    Copy-Item -Path "skills\*" -Destination $ClaudeSkillsTarget -Recurse -Force
    
    $InstalledAny = $true
}

# Detect Codex
if (Test-Path $CodexDir) {
    Write-Host "Codex detected at $CodexDir"
    $CodexSkillsTarget = Join-Path $CodexDir "skills\pantheon"
    
    New-Item -ItemType Directory -Force -Path $CodexSkillsTarget | Out-Null
    
    Write-Host "Copying skills to Codex..."
    Copy-Item -Path "skills\*" -Destination $CodexSkillsTarget -Recurse -Force
    
    $InstalledAny = $true
}

if ($InstalledAny) {
    Write-Host "Pantheon Framework successfully installed!" -ForegroundColor Green
} else {
    Write-Warning "Neither Claude Code nor Codex directories were detected."
    Write-Host "Creating local config layout in user home for reference..."
    $BackupCommands = Join-Path $HOME ".pantheon\commands"
    $BackupSkills = Join-Path $HOME ".pantheon\skills"
    
    New-Item -ItemType Directory -Force -Path $BackupCommands | Out-Null
    New-Item -ItemType Directory -Force -Path $BackupSkills | Out-Null
    
    Copy-Item -Path "commands\pantheon\*" -Destination $BackupCommands -Recurse -Force
    Copy-Item -Path "skills\*" -Destination $BackupSkills -Recurse -Force
    
    Write-Host "Files copied to $(Join-Path $HOME '.pantheon') as backup." -ForegroundColor Yellow
}
