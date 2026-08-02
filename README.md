# Gold Standard Dev

An operating system for Claude Code. Load this repo. It tells Claude how to build software with zero drift.

## What This Repo Contains

23 markdown files. No code. No dependencies of its own. It is a set of instructions that Claude Code loads on startup.

| Directory | Contains | Loaded when |
|---|---|---|
| `CLAUDE.md` | CTO persona + delegation tree | Every Claude Code session |
| `agents/` | 8 specialist agent definitions | CTO delegates via `Task(agent="...")` |
| `standards/` | 4 anti-drift rule files | Loaded by agents before writing code |
| `skills/` | 4 skill stubs (install instructions) | Read once during `install.sh` |
| `workflows/` | 4 workflow definitions | Read when CTO routes a task type |
| `install.sh` | One-command setup script | Run once on first use |
| `MEMORY.md` | Three-layer memory architecture | Read during `/gsd-onboard` |

## Skills (Bundled)

Four skills ship with this repo. No external install needed.

| Skill | Files | What it does |
|---|---|---|
| `caveman/` | `SKILL.md` | Ultra-compressed communication |
| `frontend-design/` | `SKILL.md`, `LICENSE.txt` | Bold, distinctive web design. Source: `anthropics/skills` |
| `ui-ux-pro-max/` | `SKILL.md`, `data/` (19 CSVs), `scripts/` | 50 styles, 21 palettes, 50 font pairings, 20 charts, 8 stacks. Source: `binjuhor/shadcn-lar` |
| `agent-browser/` | `SKILL.md` | Browser automation for testing/QA. Source: `vercel-labs/agent-browser` |

## External Tools Required

`install.sh` installs these. None are bundled.

| Tool | What it does | Install command |
|---|---|---|
| **GSD Core** | Phase loop + 35 subagents | `npx @opengsd/gsd-core@latest` |
| **Graphify** | Codebase knowledge graph | `pip install graphifyy` |
| **Agent Browser** | Browser automation CLI (used by QA agent) | `npm i -g agent-browser && agent-browser install` |

## One-Command Install

```bash
curl -sL https://raw.githubusercontent.com/sadman-shourov/gold-standard-dev/main/install.sh | bash
```

What this does:
1. Clones this repo to `~/.claude-gold/`
2. Symlinks every file into `~/.claude/`
3. Installs GSD Core, Graphify, Claude Code skills, Agent Browser
4. Claude Code now loads `~/.claude/CLAUDE.md` on every session

## First Time on a Project

```
/gsd-onboard
```

What happens:
1. GSD Core indexes the codebase, creates `.planning/`
2. Graphify builds a knowledge graph in `graphify-out/`
3. PM agent extracts tech stack, design system, conventions, patterns
4. CONTEXT.md and STATE.md are created
5. CTO reviews ROADMAP.md, picks first milestone

This takes 3-10 minutes depending on repo size. Run it once per project.

## Daily Use

Start Claude Code in any repo that has been onboarded:

```bash
claude
```

Claude loads `~/.claude/CLAUDE.md` and becomes the CTO. It reads `STATE.md` from the project. You describe what you want. The CTO delegates.

Examples:
```
"Add a revenue chart to the dashboard"
"Fix the login redirect loop"
"Review the auth module for security issues"
"Ship phase 3"
```

The CTO routes each request through the appropriate workflow. You do not need to specify agents. You do not need to reference standards. The framework enforces them.

## File Structure After Install

```
~/.claude-gold/               ← this repo (source of truth)
~/.claude/
├── CLAUDE.md                 → ~/.claude-gold/CLAUDE.md (symlink)
├── agents/                   → ~/.claude-gold/agents/ (symlinked)
├── standards/                → ~/.claude-gold/standards/ (symlinked)
├── skills/                   → ~/.claude-gold/skills/ (symlinked)
├── workflows/                → ~/.claude-gold/workflows/ (symlinked)
└── MEMORY.md                 → ~/.claude-gold/MEMORY.md (symlink)

Your project/
├── .planning/                ← created by /gsd-onboard
│   ├── STATE.md
│   ├── CONTEXT.md
│   ├── ROADMAP.md
│   └── phases/
└── graphify-out/             ← created by Graphify
    ├── graph.json
    ├── GRAPH_REPORT.md
    └── graph.html
```

## Updating

```bash
cd ~/.claude-gold && git pull
```

Symlinks auto-resolve to updated files. No reinstall needed.

## Memory (Optional)

Three-layer architecture documented in `MEMORY.md`:
1. **Graphify** — codebase structure graph (free, one build)
2. **GSD** — project state + context (free, markdown files)
3. **TencentDB** — cross-session conversation memory (requires Docker + LLM key)

Layers 1+2 are enough for most projects. Add Layer 3 when you find yourself repeating context across sessions.

## Guarantee

If Claude violates a standard (hand-rolls a component, uses raw hex values, skips the verify gate), that is a bug in this framework. Fix the standard. Do not accept drift.
