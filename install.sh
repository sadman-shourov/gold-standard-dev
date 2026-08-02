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

mkdir -p "$CLAUDE_DIR"/{agents,standards,skills,workflows,commands/gsd}

echo "Linking into ~/.claude/..."

# --- Our files ---

# CLAUDE.md
ln -sf "$INSTALL_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"

# Our agents (flat .md files)
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

# Our skills (subdirectories)
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

# --- Vendored GSD Core ---

GSD_VENDOR="$INSTALL_DIR/vendor/gsd-core"

# GSD commands (71 slash commands: /gsd:plan-phase, /gsd:execute-phase, etc.)
for cmd in "$GSD_VENDOR"/commands/gsd/*.md; do
    [ -f "$cmd" ] || continue
    name=$(basename "$cmd")
    ln -sf "$cmd" "$CLAUDE_DIR/commands/gsd/$name"
done

# GSD agents (34 specialized agents)
for agent in "$GSD_VENDOR"/agents/*.md; do
    [ -f "$agent" ] || continue
    name=$(basename "$agent")
    ln -sf "$agent" "$CLAUDE_DIR/agents/$name"
done

# GSD CLI tools (gsd-tools.cjs, gsd_run, etc.)
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
echo "Installed to: $INSTALL_DIR"
echo ""
echo "Inbuilt (vendored, no network):"
echo "  GSD Core         — 71 commands + 34 agents + CLI tools"
echo "  caveman          — efficient communication"
echo "  frontend-design  — bold, distinctive UI (from anthropics/skills)"
echo "  ui-ux-pro-max    — 50 styles, 21 palettes, 50 fonts, 8 stacks"
echo "  agent-browser    — browser automation skill"
echo "  9 agents         — pm, memory, uiux, frontend, backend, qa, security, devops"
echo "  4 standards      — component discipline, code consistency, page layout, architecture"
echo "  4 workflows      — onboard, new-feature, bug-fix, ship"
echo ""
echo "External (binaries, installed above):"
echo "  Graphify         — codebase knowledge graph"
echo "  Agent Browser    — browser automation CLI"
echo ""
echo "To update: cd $INSTALL_DIR && git pull"
echo "To onboard a project: /gsd-onboard"
