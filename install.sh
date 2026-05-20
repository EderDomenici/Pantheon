#!/bin/bash
# Installation script for Pantheon Framework (POSIX)

set -e

CLAUDE_DIR="$HOME/.claude"
CODEX_DIR="$HOME/.codex"
INSTALLED_ANY=false
ERRORS=0

echo "Installing Pantheon Framework..."

# Detect Claude Code
if [ -d "$CLAUDE_DIR" ]; then
    echo "Claude Code detected at $CLAUDE_DIR"
    mkdir -p "$CLAUDE_DIR/commands/pantheon"
    mkdir -p "$CLAUDE_DIR/commands/spawn"
    mkdir -p "$CLAUDE_DIR/commands/pantheon-skills"

    echo "Copying pantheon commands..."
    cp -R commands/pantheon/* "$CLAUDE_DIR/commands/pantheon/"

    echo "Copying spawn commands..."
    cp -R commands/spawn/* "$CLAUDE_DIR/commands/spawn/"

    echo "Copying skills..."
    cp -R skills/* "$CLAUDE_DIR/commands/pantheon-skills/"

    INSTALLED_ANY=true
fi

# Detect Codex
if [ -d "$CODEX_DIR" ]; then
    echo "Codex detected at $CODEX_DIR"
    mkdir -p "$CODEX_DIR/skills/pantheon"

    echo "Copying skills to Codex..."
    cp -R skills/* "$CODEX_DIR/skills/pantheon/"

    INSTALLED_ANY=true
fi

if [ "$INSTALLED_ANY" = false ]; then
    echo "Warning: Neither Claude Code nor Codex directories were detected."
    echo "Creating local config layout in user home for reference..."
    mkdir -p "$HOME/.pantheon/commands/pantheon"
    mkdir -p "$HOME/.pantheon/commands/spawn"
    mkdir -p "$HOME/.pantheon/skills"
    cp -R commands/pantheon/* "$HOME/.pantheon/commands/pantheon/"
    cp -R commands/spawn/*    "$HOME/.pantheon/commands/spawn/"
    cp -R skills/*            "$HOME/.pantheon/skills/"
    echo "Files copied to $HOME/.pantheon/ as backup."
fi

# Validate installation
echo ""
echo "Validating installation..."
VALIDATE_DIR="${CLAUDE_DIR:-$HOME/.pantheon}"
CLAUDE_COMMANDS="$VALIDATE_DIR/commands"

check() {
    if [ -f "$1" ]; then
        echo "  [OK] $2"
    else
        echo "  [MISSING] $2 — expected at $1"
        ERRORS=$((ERRORS + 1))
    fi
}

check "$CLAUDE_COMMANDS/pantheon/init.md"      "/pantheon:init"
check "$CLAUDE_COMMANDS/pantheon/discuss.md"   "/pantheon:discuss"
check "$CLAUDE_COMMANDS/pantheon/plan.md"      "/pantheon:plan"
check "$CLAUDE_COMMANDS/pantheon/audit.md"     "/pantheon:audit"
check "$CLAUDE_COMMANDS/pantheon/execute.md"   "/pantheon:execute"
check "$CLAUDE_COMMANDS/pantheon/verify.md"    "/pantheon:verify"
check "$CLAUDE_COMMANDS/pantheon/status.md"    "/pantheon:status"
check "$CLAUDE_COMMANDS/pantheon/resume.md"    "/pantheon:resume"
check "$CLAUDE_COMMANDS/spawn/zeus.md"         "/spawn:zeus"
check "$CLAUDE_COMMANDS/spawn/athena.md"       "/spawn:athena"
check "$CLAUDE_COMMANDS/spawn/hephaestus.md"   "/spawn:hephaestus"
check "$CLAUDE_COMMANDS/spawn/hermes.md"       "/spawn:hermes"
check "$CLAUDE_COMMANDS/spawn/apollo.md"       "/spawn:apollo"
check "$CLAUDE_COMMANDS/spawn/themis.md"       "/spawn:themis"

echo ""
if [ "$ERRORS" -eq 0 ]; then
    echo "Pantheon Framework successfully installed. All files verified."
else
    echo "Installation completed with $ERRORS missing file(s). Check output above."
    exit 1
fi
