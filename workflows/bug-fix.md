# Bug Fix Workflow

For bugs, regressions, and unexpected behavior.

## Phase 1: Diagnose (QA)
1. QA agent reproduces the bug
2. QA agent captures: steps to reproduce, expected vs actual, screenshots
3. QA agent traces through graphify to identify affected code
4. Output: BUG_REPORT.md

## Phase 2: Fix (Frontend or Backend)
1. CTO delegates to appropriate agent (frontend/backend)
2. Agent identifies root cause via graphify query
3. Agent implements fix
4. Agent self-reviews against standards
5. Output: fix commit

## Phase 3: Verify Fix (QA)
1. QA agent confirms bug is resolved
2. QA agent runs regression tests on affected area
3. Output: VERIFICATION.md (updated)

## Phase 4: Ship (DevOps)
1. Standard ship workflow
2. Include "Fixes: [bug description]" in PR

## Phase 5: Learn (Memory)
1. Memory agent documents: what caused the bug, how it was fixed
2. Updates CONTEXT.md with pitfall if applicable
3. Updates patterns if fix reveals a new pattern
