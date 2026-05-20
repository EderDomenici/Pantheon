#!/bin/bash
# Installation script for Pantheon Framework (POSIX)

set -e

CLAUDE_DIR="$HOME/.claude"
CODEX_DIR="$HOME/.codex"
INSTALLED_ANY=false

echo "Installing Pantheon Framework..."

# Detect Claude Code
if [ -d "$CLAUDE_DIR" ]; then
    echo "Claude Code detected at $CLAUDE_DIR"
    mkdir -p "$CLAUDE_DIR/commands/pantheon"
    mkdir -p "$CLAUDE_DIR/commands/pantheon-skills"
    
    echo "Copying commands to Claude Code..."
    cp -R commands/pantheon/* "$CLAUDE_DIR/commands/pantheon/"
    
    echo "Copying skills to Claude Code..."
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

if [ "$INSTALLED_ANY" = true ]; then
    echo "Pantheon Framework successfully installed!"
else
    echo "Warning: Neither Claude Code nor Codex directories were detected."
    echo "Creating local config layout in user home for reference..."
    mkdir -p "$HOME/.pantheon/commands"
    mkdir -p "$HOME/.pantheon/skills"
    cp -R commands/pantheon/* "$HOME/.pantheon/commands/"
    cp -R skills/* "$HOME/.pantheon/skills/"
    echo "Files copied to $HOME/.pantheon/ as backup."
fi
