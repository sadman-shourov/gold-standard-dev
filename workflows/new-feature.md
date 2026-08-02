# New Feature Workflow — Full Phase Loop

For medium to large features. Delegates to specialist agents at each phase.

## Phase 1: Discuss (CTO + PM)
1. CTO describes feature request
2. PM agent researches gray areas, produces decision tables
3. CTO approves decisions
4. Output: decisions documented in CONTEXT.md

## Phase 2: Plan (PM)
1. PM agent loads graphify for architecture context
2. PM decomposes feature into phases
3. PM produces PLAN.md with: tasks, complexity estimates, dependencies
4. CTO reviews and approves plan
5. Output: `.planning/phases/XX-plan/PLAN.md`

## Phase 3: Design (UI/UX — if applicable)
1. UI/UX agent loads design system + standards
2. Produces design spec with: component tokens, layout, typography, spacing
3. CTO approves design
4. Output: DESIGN.md

## Phase 4: Execute (Frontend + Backend — parallel)
1. CTO dispatches frontend agent + backend agent in parallel
2. Each agent works in fresh context
3. Each agent self-reviews against standards
4. Output: implemented code, committed per task

## Phase 5: Verify (QA + Security)
1. QA agent runs agent-browser tests
2. QA agent compares implementation against spec + design
3. Security agent audits code
4. Output: VERIFICATION.md + SECURITY.md

## Phase 6: Ship (DevOps)
1. DevOps agent verifies build
2. Creates PR with summary
3. Deploys if CI passes
4. Output: PR link, deploy URL

## Phase 7: Archive (Memory)
1. Memory agent updates CONTEXT.md with new patterns
2. Memory agent runs `graphify --update`
3. Memory agent archives learnings
4. Output: updated context + patterns catalog
