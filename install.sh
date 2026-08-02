#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/sadman-shourov/prime-dev.git"
INSTALL_DIR="$HOME/.claude-prime"
CLAUDE_DIR="$HOME/.claude"

echo "=== Gold Standard Dev Installer ==="

if [ -d "$INSTALL_DIR" ]; then
    echo "Updating existing install..."
    cd "$INSTALL_DIR"
    git pull --ff-only
else
    echo "Cloning prime-dev..."
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

mkdir -p "$CLAUDE_DIR"/{standards,skills,commands/gsd}

echo "Linking into ~/.claude/..."

# CLAUDE.md — the orchestrator
ln -sf "$INSTALL_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"

# Standards — injected into GSD agents
for std in "$INSTALL_DIR"/standards/*.md; do
    [ -f "$std" ] || continue
    name=$(basename "$std")
    ln -sf "$std" "$CLAUDE_DIR/standards/$name"
done

# Skills — loadable by any agent
for skill_dir in "$INSTALL_DIR"/skills/*/; do
    skill_name=$(basename "$skill_dir")
    target="$CLAUDE_DIR/skills/$skill_name"
    rm -rf "$target"
    ln -sf "$skill_dir" "$target"
done

# MEMORY.md
ln -sf "$INSTALL_DIR/MEMORY.md" "$CLAUDE_DIR/MEMORY.md"

# --- Vendored GSD Core ---

GSD_VENDOR="$INSTALL_DIR/vendor/gsd-core"

# GSD commands (71 slash commands)
for cmd in "$GSD_VENDOR"/commands/gsd/*.md; do
    [ -f "$cmd" ] || continue
    name=$(basename "$cmd")
    ln -sf "$cmd" "$CLAUDE_DIR/commands/gsd/$name"
done

# GSD agents (34 specialized, patched with our standards)
for agent in "$GSD_VENDOR"/agents/*.md; do
    [ -f "$agent" ] || continue
    name=$(basename "$agent")
    ln -sf "$agent" "$CLAUDE_DIR/agents/$name"
done

# GSD CLI tools
rm -rf "$CLAUDE_DIR/gsd-core"
ln -sf "$GSD_VENDOR/gsd-core" "$CLAUDE_DIR/gsd-core"

# GSD skills
for skill_dir in "$GSD_VENDOR"/skills/*/; do
    skill_name=$(basename "$skill_dir")
    target="$CLAUDE_DIR/skills/$skill_name"
    rm -rf "$target"
    ln -sf "$skill_dir" "$target"
done

# --- External tools (binaries, not bundled) ---

echo ""
echo "=== External tools ==="

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
echo ""
echo "Inbuilt (this repo):"
echo "  CLAUDE.md        — orchestrator (routes to GSD commands)"
echo "  standards/       — 4 anti-drift rules (injected into all GSD agents)"
echo "  skills/          — caveman, frontend-design, ui-ux-pro-max, agent-browser, self-heal"
echo "  vendor/gsd-core/ — 71 commands + 34 agents + CLI (patched with standards)"
echo ""
echo "External (binaries):"
echo "  Graphify         — codebase knowledge graph"
echo "  Agent Browser    — browser automation for QA"
echo ""
echo "To update: cd $INSTALL_DIR && git pull"
echo "To onboard a project: /gsd-onboard"
