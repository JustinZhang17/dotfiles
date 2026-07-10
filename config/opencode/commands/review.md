---
description: Review the current changes (staged + unstaged) for bugs, security, edge cases, and test coverage.
agent: reviewer
---

Review the pending changes in this repository.

1. Run `git status` and `git diff` (both staged and unstaged) to see what
   changed. If a branch and base were given, review `git diff $1...HEAD` where
   `$1` is the base branch (default to the main branch if not provided).
2. Read the changed files with enough surrounding context to understand how
   the change fits the existing code.
3. Report findings grouped by severity: **blocker**, **should-fix**, **nit**
   (skip nits unless asked). Each item: `path:line`, problem, why it matters.
4. If the change is sound, say so explicitly and stop.

$ARGUMENTS