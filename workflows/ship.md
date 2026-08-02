# Ship Workflow

Gate before any code reaches production.

## Gate 1: Build
1. `npm run build` or equivalent — must pass
2. No warnings, no errors
3. If build fails → fix first, do not proceed

## Gate 2: QA Verification
1. QA agent verifies against PLAN.md
2. QA agent runs agent-browser smoke tests
3. QA agent checks for visual drift (screenshots vs design spec)
4. Must pass with `status: passed` in VERIFICATION.md

## Gate 3: Security Audit
1. Security agent runs `npm audit`
2. Security agent scans for secrets
3. Security agent reviews auth/data handling
4. No critical or high findings

## Gate 4: Standards Check
1. Frontend code checked against component-discipline.md
2. All code checked against code-consistency.md
3. Layout checked against page-layout.md
4. Architecture checked against architecture.md
5. Zero violations

## Gate 5: PR Creation
1. Descriptive title + summary of changes
2. Links to PLAN.md and VERIFICATION.md
3. Screenshots if UI changes (from agent-browser)
4. Labels applied

## Gate 6: Deploy
1. Merge PR
2. Verify deploy (health check)
3. Smoke test production
4. Monitor for 5 minutes — error rate normal?

## Post-Ship
1. Memory agent archives learnings
2. Update STATE.md to reflect completed phase
3. Prepare for next phase
