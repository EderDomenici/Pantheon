# Installation script for Pantheon Framework (Windows/PowerShell)
$ErrorActionPreference = "Stop"

$ClaudeDir = Join-Path $HOME ".claude"
$CodexDir  = Join-Path $HOME ".codex"
$InstalledAny = $false
$Errors = 0

Write-Host "Installing Pantheon Framework..." -ForegroundColor Cyan

# Detect Claude Code
if (Test-Path $ClaudeDir) {
    Write-Host "Claude Code detected at $ClaudeDir"
    $ClaudePantheonTarget = Join-Path $ClaudeDir "commands\pantheon"
    $ClaudeSpawnTarget    = Join-Path $ClaudeDir "commands\spawn"
    $ClaudeSkillsTarget   = Join-Path $ClaudeDir "commands\pantheon-skills"

    New-Item -ItemType Directory -Force -Path $ClaudePantheonTarget | Out-Null
    New-Item -ItemType Directory -Force -Path $ClaudeSpawnTarget    | Out-Null
    New-Item -ItemType Directory -Force -Path $ClaudeSkillsTarget   | Out-Null

    Write-Host "Copying pantheon commands..."
    Copy-Item -Path "commands\pantheon\*" -Destination $ClaudePantheonTarget -Recurse -Force

    Write-Host "Copying spawn commands..."
    Copy-Item -Path "commands\spawn\*" -Destination $ClaudeSpawnTarget -Recurse -Force

    Write-Host "Copying skills..."
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

$HomeDir = [System.Environment]::GetFolderPath('UserProfile')
New-Item -ItemType Directory -Force -Path "$HomeDir\.pantheon\scripts" | Out-Null
if (Test-Path "scripts\*") {
    Copy-Item -Path "scripts\*" -Destination "$HomeDir\.pantheon\scripts" -Recurse -Force
}

if (-not $InstalledAny) {
    Write-Warning "Neither Claude Code nor Codex directories were detected."
    Write-Host "Creating local config layout in user home for reference..."
    $BackupPantheon = Join-Path $HOME ".pantheon\commands\pantheon"
    $BackupSpawn    = Join-Path $HOME ".pantheon\commands\spawn"
    $BackupSkills   = Join-Path $HOME ".pantheon\skills"

    New-Item -ItemType Directory -Force -Path $BackupPantheon | Out-Null
    New-Item -ItemType Directory -Force -Path $BackupSpawn    | Out-Null
    New-Item -ItemType Directory -Force -Path $BackupSkills   | Out-Null

    Copy-Item -Path "commands\pantheon\*" -Destination $BackupPantheon -Recurse -Force
    Copy-Item -Path "commands\spawn\*"    -Destination $BackupSpawn    -Recurse -Force
    Copy-Item -Path "skills\*"            -Destination $BackupSkills   -Recurse -Force

    Write-Host "Files copied to $(Join-Path $HOME '.pantheon') as backup." -ForegroundColor Yellow
}

# Validate installation
Write-Host ""
Write-Host "Validating installation..."

$BaseDir = if (Test-Path $ClaudeDir) { $ClaudeDir } else { Join-Path $HOME ".pantheon" }
$CmdDir  = Join-Path $BaseDir "commands"

function Assert-File {
    param([string]$Path, [string]$Label)
    if (Test-Path $Path) {
        Write-Host "  [OK] $Label" -ForegroundColor Green
    } else {
        Write-Host "  [MISSING] $Label — expected at $Path" -ForegroundColor Red
        $script:Errors++
    }
}

Assert-File (Join-Path $CmdDir "pantheon\init.md")      "/pantheon:init"
Assert-File (Join-Path $CmdDir "pantheon\discuss.md")   "/pantheon:discuss"
Assert-File (Join-Path $CmdDir "pantheon\plan.md")      "/pantheon:plan"
Assert-File (Join-Path $CmdDir "pantheon\audit.md")     "/pantheon:audit"
Assert-File (Join-Path $CmdDir "pantheon\execute.md")   "/pantheon:execute"
Assert-File (Join-Path $CmdDir "pantheon\verify.md")    "/pantheon:verify"
Assert-File (Join-Path $CmdDir "pantheon\status.md")    "/pantheon:status"
Assert-File (Join-Path $CmdDir "pantheon\resume.md")    "/pantheon:resume"
Assert-File (Join-Path $CmdDir "pantheon\fast.md")      "/pantheon:fast"
Assert-File (Join-Path $CmdDir "pantheon\jump.md")      "/pantheon:jump"
Assert-File (Join-Path $CmdDir "pantheon\checkpoint.md") "/pantheon:checkpoint"
Assert-File (Join-Path $CmdDir "pantheon\learn.md")     "/pantheon:learn"
Assert-File (Join-Path $CmdDir "pantheon\metrics.md")   "/pantheon:metrics"
Assert-File (Join-Path $CmdDir "spawn\zeus.md")         "/spawn:zeus"
Assert-File (Join-Path $CmdDir "spawn\athena.md")       "/spawn:athena"
Assert-File (Join-Path $CmdDir "spawn\hephaestus.md")   "/spawn:hephaestus"
Assert-File (Join-Path $CmdDir "spawn\hermes.md")       "/spawn:hermes"
Assert-File (Join-Path $CmdDir "spawn\apollo.md")       "/spawn:apollo"
Assert-File (Join-Path $CmdDir "spawn\themis.md")       "/spawn:themis"

Write-Host ""
if ($Errors -eq 0) {
    Write-Host "Pantheon Framework successfully installed. All files verified." -ForegroundColor Green
} else {
    Write-Host "Installation completed with $Errors missing file(s). Check output above." -ForegroundColor Red
    exit 1
}
