# Gold Standard Dev

Operating system for Claude Code. One command. Zero drift. Everything inbuilt.

## Architecture

```
CLAUDE.md          → Orchestrator. Routes every task through GSD phase loop.
standards/         → 4 anti-drift rules. Injected into GSD agents via patches.
skills/            → 4 bundled skills. Loaded by agents on demand.
vendor/gsd-core/   → GSD Core (71 commands + 34 agents + CLI). Patched with our standards.
```

## How It Works

```
User: "Build a dashboard"
  │
CLAUDE.md: "Feature. Route to /gsd:plan-phase."
  │
  ▼
gsd-planner spawns with:
  - @standards/architecture.md
  - graphify query for codebase context
  → Produces PLAN.md
  │
  ▼
gsd-executor spawns with:
  - @standards/component-discipline.md (no hand-rolled, theme tokens only)
  - @standards/code-consistency.md (consistent patterns)
  - @standards/page-layout.md (layout discipline)
  - @standards/architecture.md (separation of concerns)
  - @skills/frontend-design, @skills/ui-ux-pro-max (if UI)
  → Produces working code, commits
  │
  ▼
gsd-verifier checks against standards + plan
gsd-code-reviewer hunts bugs, flags standard violations
  │
  ▼
/gsd:ship — PR, deploy
gsd-mempalace-curator — archives learnings to CONTEXT.md
```

## What's Inbuilt

| Layer | Contents | Wired to |
|---|---|---|
| Orchestrator | `CLAUDE.md` — routes to GSD commands | Every session |
| Standards | 4 files — component-discipline, code-consistency, page-layout, architecture | gsd-executor, gsd-code-reviewer, gsd-verifier, gsd-ui-checker |
| Skills | caveman (comms), frontend-design + ui-ux-pro-max (design), agent-browser (testing) | Orchestrator, gsd-ui-researcher, gsd-executor, gsd-verifier |
| Framework | GSD Core — 71 slash commands + 34 agents + CLI | Entire pipeline |
| DNA | 57 patterns extracted per project into CONTEXT.md | All agents during execution |
| Memory | GSD mempalace (decisions → CONTEXT.md) + Graphify (code graph) | Post-milestone, on-demand |

## What's External

| Tool | Why |
|---|---|
| Graphify | Python package. Builds codebase knowledge graph. |
| Agent Browser | Rust CLI. Browser automation for QA testing. |

## Install

```bash
curl -sL https://raw.githubusercontent.com/sadman-shourov/gold-standard-dev/main/install.sh | bash
```

## First Time on a Project

```
/gsd:onboard
```

What happens: GSD indexes codebase → Graphify builds knowledge graph → STATE.md + CONTEXT.md created → CTO reviews ROADMAP.md.

## Daily Use

Describe what you want. Claude routes it.

```
"Add a revenue chart to the dashboard"
"Fix the login redirect bug"
"Review auth module for security"
"Ship phase 3"
```

## Zero Drift Guarantee

Standards are injected into every GSD agent that writes or reviews code. The verifier and code reviewer flag standard violations. Drift cannot survive the pipeline.

If a standard is violated, it means the standard wasn't clear enough. Fix the standard. The system enforces it from then on.
