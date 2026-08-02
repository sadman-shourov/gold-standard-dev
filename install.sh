#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/sadman-shourov/gold-standard-dev.git"
INSTALL_DIR="$HOME/.claude-gold"
CLAUDE_DIR="$HOME/.claude"

echo "=== Gold Standard Dev Installer ==="

if [ -d "$INSTALL_DIR" ]; then
    echo "Updating existing install..."
    cd "$INSTALL_DIR"
    git pull --ff-only
else
    echo "Cloning gold-standard-dev..."
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

mkdir -p "$CLAUDE_DIR"/{agents,standards,skills,workflows}

echo "Linking into ~/.claude/..."

# CLAUDE.md
ln -sf "$INSTALL_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"

# Agents (flat .md files)
for agent in "$INSTALL_DIR"/agents/*.md; do
    [ -f "$agent" ] || continue
    name=$(basename "$agent")
    ln -sf "$agent" "$CLAUDE_DIR/agents/$name"
done

# Standards (flat .md files)
for std in "$INSTALL_DIR"/standards/*.md; do
    [ -f "$std" ] || continue
    name=$(basename "$std")
    ln -sf "$std" "$CLAUDE_DIR/standards/$name"
done

# Skills (subdirectories with SKILL.md + data)
for skill_dir in "$INSTALL_DIR"/skills/*/; do
    skill_name=$(basename "$skill_dir")
    target="$CLAUDE_DIR/skills/$skill_name"
    rm -rf "$target"
    ln -sf "$skill_dir" "$target"
done

# Workflows (flat .md files)
for wf in "$INSTALL_DIR"/workflows/*.md; do
    [ -f "$wf" ] || continue
    name=$(basename "$wf")
    ln -sf "$wf" "$CLAUDE_DIR/workflows/$name"
done

# MEMORY.md
ln -sf "$INSTALL_DIR/MEMORY.md" "$CLAUDE_DIR/MEMORY.md"

# Tools
echo ""
echo "=== Installing tools ==="

if ! command -v gsd-tools &>/dev/null; then
    echo "Installing GSD Core..."
    npx @opengsd/gsd-core@latest
fi

if ! command -v graphify &>/dev/null; then
    echo "Installing Graphify..."
    if command -v uv &>/dev/null; then
        uv tool install graphifyy
    else
        pip install graphifyy
    fi
fi

if ! command -v agent-browser &>/dev/null; then
    echo "Installing agent-browser..."
    npm i -g agent-browser && agent-browser install
fi

echo ""
echo "=== Done ==="
echo "Installed to: $INSTALL_DIR"
echo "Symlinked to: $CLAUDE_DIR"
echo ""
echo "Skills included (no npx skills add needed):"
echo "  caveman/           — efficient communication"
echo "  frontend-design/   — bold, distinctive UI"
echo "  ui-ux-pro-max/     — 50 styles, 21 palettes, 50 fonts"
echo "  agent-browser/     — browser automation for testing"
echo ""
echo "To update: cd $INSTALL_DIR && git pull"
echo "To onboard a project: /gsd-onboard"
