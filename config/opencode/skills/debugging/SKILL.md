---
name: debugging
description: Systematic debugging methodology. Use when encountering errors, stack traces, exceptions, crashes, test failures, panics, "bug", "broken", "not working", unexpected behavior, or any failing, flaky, or reproduced issue that needs root-causing and fixing.
---

# Debugging

Use ONLY when something is wrong and needs root-causing: errors, stack traces,
exceptions, crashes, panics, test failures, or reports that behavior is
"broken", "not working", "wrong", or unexpected. Do NOT use for normal feature
work or green-field implementation.

## Approach

Always work through the steps in order. Do not skip to a fix.

### 1. Reproduce

- Establish a minimal, reliable reproduction before anything else. If you
  cannot reproduce it, you cannot verify the fix.
- Capture the exact inputs, environment, version, and sequence that triggers
  it. Note intermittency and any timing/concurrency involved.

### 2. Isolate

- Narrow the trigger to the smallest input and code path that still reproduces.
- Bisect: binary-search through recent changes (`git bisect`, or hand-trimmed
  inputs) to find the commit, call, or condition that introduces the failure.
- Distinguish "this code is wrong" from "this code is right but fed bad data."
  Inspect actual values at the boundary, not assumptions.

### 3. Root-cause

- Find the *cause*, not the symptom. Fixing a symptom guarantees the bug
  returns in a new form.
- State the root cause in one sentence: "X assumes Y, but Y is false when Z."
- If you cannot state it, you have not found it. Go back to step 2.

### 4. Fix minimally

- Change the least code that fixes the root cause. Avoid "while I'm here"
  refactors in the same change; they hide the fix in review.
- Prefer fixing the source over patching downstream consumers.

### 5. Verify

- Re-run the exact reproduction from step 1 and confirm it now passes.
- Run the surrounding tests. Confirm nothing regressed.
- Challenge the fix: try a nearby input that *should* still trigger, and one
  that *should not*. Both must behave correctly.

### 6. Regression test

- Add a regression test named after the bug (e.g. `bug_482_expired_token_now_rejected`).
- It must fail without the fix and pass with it. Commit the test alongside the
  fix so the bug can never silently return.

## Rules

- **No shooting in the dark.** "Let me try changing this" is step 4, not step 1.
- **Read before write.** Understand the code around the failure before editing.
- **One change at a time.** Changing two things at once hides which one fixed it.
- **Never swallow to silence a failure.** If the fix is to handle the case,
  handle it; do not catch-and-ignore.
- **Trust the reproduction over the theory.** If the fix should work but the
  repro still fails, the root cause is elsewhere; go back to step 2.
- When the fix is non-obvious or risky, escalate the trade-off to the user
  rather than committing to it silently.