# Memory Architecture

Gold Standard Dev uses three memory layers. Each layer serves a distinct purpose. Together they form a complete persistence system.

## Layer 1: Graphify — Codebase Knowledge Graph

**What it stores:** Code structure, file relationships, call graphs, architecture map.

**How it works:**
- `/graphify .` builds a knowledge graph from the codebase
- `graphify query "..."` answers architecture questions
- `graphify --update` refreshes on code changes
- Output: `graphify-out/graph.json`, `GRAPH_REPORT.md`, `graph.html`

**When it runs:**
- Full build: during `/gsd-onboard`
- Incremental: memory agent runs `graphify --update` after milestones
- On-demand: any agent can query the graph

## Layer 2: GSD — Project State & Context

**What it stores:** Current phase, plan, decisions, context, roadmap.

**How it works:**
- `.planning/STATE.md` — current project state (phase, status, blockers)
- `.planning/CONTEXT.md` — domain knowledge, decisions, patterns, conventions
- `.planning/ROADMAP.md` — milestone plan with phases
- `.planning/phases/` — per-phase artifacts (PLAN, SUMMARY, VERIFICATION)

**When it runs:**
- STATE.md: updated at every phase transition
- CONTEXT.md: updated by memory agent after milestones
- ROADMAP.md: created during onboard, updated by PM agent

## Layer 3: TencentDB — Cross-Session Conversation Memory (Optional)

**What it stores:** Conversation history, user preferences, past decisions, extracted facts.

**Setup:**
```bash
git clone https://github.com/TencentCloud/TencentDB-Agent-Memory.git
cd TencentDB-Agent-Memory/deploy/global-images
cp .env.example .env
# Fill in LLM keys
./start-all.sh
```

Then point Claude Code at the proxy:
```bash
export ANTHROPIC_BASE_URL=http://127.0.0.1:8096/claude-code/default
export ANTHROPIC_AUTH_TOKEN=$(cat .admin-key)
```

**What it adds:**
- L0: Raw conversation capture — what was discussed
- L1: Extracted facts — decisions, constraints, preferences
- L2: Scenario blocks — project-specific context snapshots
- L3: Persona — long-term user profile

**Cost:** Additional LLM calls for extraction pipeline. ~$2-5/month with cheap model.

## Memory Agent Responsibilities

The memory agent bridges all three layers:
1. After milestones: updates CONTEXT.md (Layer 2), runs graphify --update (Layer 1)
2. Patterns discovered: adds to patterns catalog, updates CONTEXT.md
3. Context queries: "what did we decide about X?" → checks TencentDB (Layer 3) if available, then CONTEXT.md (Layer 2), then graphify (Layer 1)

## Retrieval Priority

When an agent needs to remember something:
```
1. STATE.md          → "What phase are we in?"
2. CONTEXT.md         → "What conventions do we follow?"
3. Graphify query     → "How does the auth module work?"
4. TencentDB recall   → "What did we discuss about auth last Tuesday?"
5. Patterns catalog   → "What's the canonical modal pattern?"
```

## Without TencentDB

Layers 1 + 2 provide 80% of memory needs. TencentDB adds the remaining 20% — cross-session conversation recall. Start with Layers 1 + 2 and add TencentDB when you find yourself repeating context across sessions.
