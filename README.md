# 🏗️ Gold Standard Dev

> *One command. Zero drift. Claude Code on steroids.*
>
> Never write "please fix the styling" again. Never find `#FF0000` where a token should be. Never open a PR only to see someone hand-rolled a button you already have.

<br>

```
                    ┌──────────────────────────┐
                    │   YOU: "Build dashboard" │
                    └───────────┬──────────────┘
                                │
                    ┌───────────▼──────────────┐
                    │   CLAUDE.md (CTO)         │
                    │   Routes to GSD commands  │
                    └───────────┬──────────────┘
                                │
        ┌───────────────────────┼───────────────────────┐
        │                       │                       │
        ▼                       ▼                       ▼
┌───────────────┐     ┌───────────────┐     ┌───────────────┐
│  gsd-planner  │     │ gsd-executor  │     │ gsd-verifier  │
│  + standards  │     │ + standards   │     │ + standards   │
│  + DNA        │     │ + DNA         │     │ + DNA         │
│  + graphify   │     │ + design skills│    │ + self-heal   │
│               │     │               │     │ + agent-browser│
└───────────────┘     └───────────────┘     └───────────────┘
        │                       │                       │
        ▼                       ▼                       ▼
    PLAN.md               WORKING CODE           DRIFT FIXED
                          COMMITTED              VERIFIED
```

<br>

---

## ⚡ Install

```bash
curl -sL https://raw.githubusercontent.com/sadman-shourov/gold-standard-dev/main/install.sh | bash
```

That's it. 500+ files. Everything Claude Code needs to build software properly.

---

## 🧠 How It Works

### First Run — The Onboarding

```
/graphify .          ← builds knowledge graph of your entire codebase
/gsd:onboard         ← GSD maps structure, creates project files
                     ← Then Claude extracts 57 patterns into CONTEXT.md
```

**It learns your project's DNA:**

```
✔ API: RESTful, /api/resource/:id, Zod validation, JWT auth
✔ State: React Query for server, Zustand for client
✔ Design: MUI v5, red #E31E24, Titillium Web, 24px grid
✔ Auth: NextAuth, useRole(), requireRole() middleware
✔ Pages: PageShell → PageHeader → Grid → Cards
✔ Forms: React Hook Form + Zod, inline errors
✔ ...52 more patterns
```

### Every Session After That

```
You: "Add revenue chart to dashboard"

Claude: /gsd:plan-phase  →  /gsd:execute-phase  →  /gsd:verify-work  →  /gsd:ship

        Every agent loads:              And produces:
        ├── Your standards              ├── Code matching YOUR patterns
        ├── Your project DNA            ├── No hand-rolled components
        ├── Your design tokens          ├── No raw hex values
        └── Your API conventions        └── No drift. Ever.
```

---

## 🛡️ The Anti-Drift Stack

| Layer | What | Who loads it |
|---|---|---|
| **Standards** | No hand-rolled, theme tokens only, layout discipline, architecture rules | `gsd-executor`, `gsd-code-reviewer`, `gsd-verifier`, `gsd-ui-checker` |
| **DNA** | 57 project-specific patterns (API, auth, design, forms, everything) | All agents |
| **Skills** | caveman · frontend-design · ui-ux-pro-max · agent-browser · **self-heal** | Orchestrator + design/UI/testing agents |
| **Graphify** | Codebase knowledge graph — every agent queries before touching code | On-demand per agent |
| **Self-heal** | Finds drift → fixes it → updates CONTEXT.md → never happens again | `gsd-code-reviewer`, `gsd-verifier` |

---

## 🔧 Skills — All Wired

| Skill | Source | Does |
|---|---|---|
| `caveman` | Ours | Ultra-efficient communication. No fluff. |
| `frontend-design` | Anthropic | Bold, distinctive UI. Never looks AI-generated. |
| `ui-ux-pro-max` | binjuhor | 50 styles · 21 palettes · 57 fonts · 20 charts · 8 stacks. Data-driven design. |
| `agent-browser` | Vercel | Browser automation for QA. Screenshots, form testing, responsive checks. |
| `self-heal` | Ours | Finds drift. Fixes it. Learns from it. Updates CONTEXT.md. |

---

## 🔁 Self-Healing Loop

```
gsd-executor writes code  →  gsd-code-reviewer finds a raw px value
                                    │
                                    ▼
                            Replaces with theme.spacing()
                            Commits: fix(drift): auto-corrected spacing
                                    │
                                    ▼
                            gsd-verifier re-checks  →  PASSES
                                    │
                                    ▼
                            Pattern added to CONTEXT.md
                            Never happens again
```

---

## 📦 What You Get

```
~/.claude/
├── CLAUDE.md              ← orchestrator (routes everything)
├── commands/gsd/          ← 71 slash commands
├── agents/                ← 34 GSD agents (patched with our layers)
├── standards/             ← 4 anti-drift rules
├── skills/                ← 5 bundled skills
│   ├── caveman/
│   ├── frontend-design/
│   ├── ui-ux-pro-max/     (19 CSVs + scripts)
│   ├── agent-browser/
│   └── self-heal/
├── gsd-core/              ← CLI tools
└── MEMORY.md              ← 3-layer memory architecture
```

---

## 🚀 Use It

```bash
# First time on a project
/gsd:onboard

# Build stuff
"Add revenue chart to dashboard"
"Fix the login redirect loop"
"Review auth module for security"
"Ship phase 3"

# The CTO routes it. GSD agents build it. Self-heal fixes drift.
# You just talk. It just works.
```

---

## 🔒 Zero Drift Guarantee

If a standard is violated, self-heal catches it and fixes it before the phase ships. If a new pattern is discovered, it's added to CONTEXT.md so every future agent knows about it.

**Drift cannot survive the pipeline.**

---

<p align="center">
  <sub>Built once. Works everywhere. Never tweak again.</sub>
</p>
