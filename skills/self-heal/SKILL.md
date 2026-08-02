---
name: self-heal
description: Auto-corrects drift and learns from corrections. When an agent or verifier detects a pattern violation, fix it immediately and update CONTEXT.md so it never happens again.
---

# Self-Healing Skill

## Core Rule

When you detect a drift violation, do not just report it. Fix it. Then teach the system so it never recurs.

## Self-Correction Protocol

When gsd-code-reviewer or gsd-verifier finds a standard violation:

1. **Fix it immediately.** Do not create an issue. Do not ask permission. Fix the violation.
   - Hand-rolled button? Replace with existing `<Button>` component.
   - Raw hex value? Replace with theme token.
   - Raw flexbox? Replace with design system layout primitive.
   - Inconsistent pattern? Rewrite to match canonical example from CONTEXT.md.

2. **Verify the fix.** After fixing, re-run the verification that caught it.

3. **Commit with tag.** `fix(drift): auto-corrected [violation type] - [file]`

## Self-Learning Protocol

When a new pattern is discovered (something done consistently but not in CONTEXT.md):

1. **Extract the pattern.** Find the canonical example. Document it.

2. **Update CONTEXT.md.** Add the new pattern immediately. Do not wait for milestone-end.
   - New API convention? Add to API Layer section.
   - New component pattern? Add to Frontend Architecture section.
   - New form pattern? Add to Page Behavior section.
   - New permission pattern? Add to Auth & Permissions section.

3. **Commit.** `docs(context): discovered [pattern name] pattern`

## Drift Detection Triggers

| Drift | Auto-Fix |
|---|---|
| New component when design system has equivalent | Replace with existing component |
| Raw color/spacing value instead of token | Replace with `theme.*` or CSS variable |
| Inline styles | Extract to styled component or CSS module |
| Raw flexbox/grid instead of layout primitive | Replace with `<Grid>`, `<Stack>`, `<Flex>` |
| New API endpoint breaks naming convention | Rename to match existing pattern |
| Different error handling than rest of codebase | Rewrite to match canonical error pattern |
| New auth check doesn't match existing | Rewrite to use existing hook/middleware |
| Component props don't follow convention | Rename to match CONTEXT.md convention |
| File doesn't follow naming convention | Rename file |
| Import doesn't follow grouping convention | Reorder imports |

## When NOT to Auto-Fix

- The fix requires architectural changes (new DB table, service layer, auth approach)
- The fix would change public API behavior
- The code is unclear whether it's a violation or intentional deviation

In these cases: flag as warning, do not auto-fix, ask reviewer.
