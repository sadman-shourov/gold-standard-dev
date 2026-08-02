# Onboard Workflow — First Contact With a Codebase

Runs once per project. Learns everything. Builds context. Sets up the graph.

## Phase 1: Install Foundation
1. Install GSD Core: `npx @opengsd/gsd-core`
2. Install Graphify: `pip install graphifyy` or `uv tool install graphifyy`
3. Install skills: `npx skills add anthropics/skills --skill frontend-design`, `npx skills add binjuhor/shadcn-lar --skill ui-ux-pro-max`, `npm i -g agent-browser && agent-browser install`

## Phase 2: Scan & Map
1. Run `/gsd-onboard` — GSD indexes codebase, creates `.planning/`
2. Run `/graphify .` — builds knowledge graph in `graphify-out/`
3. Label communities, review god nodes

## Phase 3: Extract Context
1. Read `package.json`, `tsconfig.json`, theme/config files
2. Identify: tech stack, design system, component library, state management, routing, API layer, database
3. Build CONTEXT.md with:
   - Tech stack summary
   - Design system tokens
   - Component patterns found
   - Architecture map
   - Known conventions
   - Graphify community map

## Phase 4: Build Patterns Catalog
1. Scan `components/ui/` for canonical components
2. Scan `hooks/` for data fetching patterns
3. Scan pages for layout patterns
4. Record each in patterns/

## Phase 5: Verify
1. Run `graphify query "architecture overview"` — confirms graph works
2. Run a test: `agent-browser skills get core` — confirms tools work
3. Delegate to pm agent: "Review the codebase and suggest first milestone"

## Output
```
.planning/
├── STATE.md          ← "Ready to plan"
├── CONTEXT.md        ← full project context
├── ROADMAP.md        ← suggested milestones
└── phases/

graphify-out/
├── graph.json
├── GRAPH_REPORT.md
└── graph.html

patterns/
├── react-components.md
├── layouts.md
└── api-patterns.md
```

## After Onboard
Memory agent archives everything. CTO reviews ROADMAP.md and picks first milestone.
