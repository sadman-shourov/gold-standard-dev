#!/usr/bin/env bash
set -euo pipefail

# Gold Standard Dev — Installer
# Clones repo → installs dependencies → symlinks into ~/.claude/
# One command: curl -sL https://raw.githubusercontent.com/sadman-shourov/gold-standard-dev/main/install.sh | bash

REPO_URL="https://github.com/sadman-shourov/gold-standard-dev.git"
INSTALL_DIR="$HOME/.claude-gold"
CLAUDE_DIR="$HOME/.claude"

echo "=== Gold Standard Dev Installer ==="

# Clone or update
if [ -d "$INSTALL_DIR" ]; then
    echo "Updating existing install..."
    cd "$INSTALL_DIR"
    git pull --ff-only
else
    echo "Cloning gold-standard-dev..."
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

# Ensure ~/.claude/ exists
mkdir -p "$CLAUDE_DIR"/{agents,standards,skills,workflows}

# Symlink everything
echo "Linking into ~/.claude/..."

# CLAUDE.md
ln -sf "$INSTALL_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"

# Agents
for agent in "$INSTALL_DIR"/agents/*.md; do
    name=$(basename "$agent")
    ln -sf "$agent" "$CLAUDE_DIR/agents/$name"
done

# Standards
for std in "$INSTALL_DIR"/standards/*.md; do
    name=$(basename "$std")
    ln -sf "$std" "$CLAUDE_DIR/standards/$name"
done

# Skills
for skill in "$INSTALL_DIR"/skills/*.md; do
    name=$(basename "$skill")
    ln -sf "$skill" "$CLAUDE_DIR/skills/$name"
done

# Workflows
for wf in "$INSTALL_DIR"/workflows/*.md; do
    name=$(basename "$wf")
    ln -sf "$wf" "$CLAUDE_DIR/workflows/$name"
done

# MEMORY.md
ln -sf "$INSTALL_DIR/MEMORY.md" "$CLAUDE_DIR/MEMORY.md"

# Install tools
echo ""
echo "=== Installing tools ==="

# GSD Core
if ! command -v gsd-tools &>/dev/null; then
    echo "Installing GSD Core..."
    npx @opengsd/gsd-core@latest
fi

# Graphify
if ! command -v graphify &>/dev/null; then
    echo "Installing Graphify..."
    if command -v uv &>/dev/null; then
        uv tool install graphifyy
    else
        pip install graphifyy
    fi
fi

# Skills
echo "Installing Claude Code skills..."
npx skills add anthropics/skills --skill frontend-design --agent claude-code 2>/dev/null || echo "  frontend-design already installed"
npx skills add binjuhor/shadcn-lar --skill ui-ux-pro-max 2>/dev/null || echo "  ui-ux-pro-max already installed"

# Agent Browser
if ! command -v agent-browser &>/dev/null; then
    echo "Installing agent-browser..."
    npm i -g agent-browser && agent-browser install
fi

echo ""
echo "=== Done ==="
echo "Gold Standard Dev installed to: $INSTALL_DIR"
echo "CLAUDE.md symlinked to:    $CLAUDE_DIR/CLAUDE.md"
echo ""
echo "To update: cd $INSTALL_DIR && git pull"
echo "To start a new project:  /gsd-onboard"
echo "To update this install:  curl -sL https://raw.githubusercontent.com/sadman-shourov/gold-standard-dev/main/install.sh | bash"
