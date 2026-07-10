---
description: Draft a conventional commit message from the staged changes for the user to commit themselves.
agent: build
---

Draft a commit message for the currently staged changes following
`@justin-practices/commits` (conventional commits). Version control is the user's
responsibility; you draft, the user commits.

1. Run `git status` and `git diff --staged` to see what is staged. If nothing
   is staged, list `git diff` so the user can decide what to stage; do NOT
   stage anything.
2. Determine the conventional commit `type` and `scope` from the nature and
   location of the change (e.g., `feat`, `fix`, `refactor`, `test`, `docs`,
   `chore`, `style`, `perf`).
3. Write a `SHORT_DESCRIPTION` in the imperative mood, lowercase start, no
   trailing period, ≤ ~50 chars. Add a `BODY` only if the "why" is not obvious
   from the diff; wrap body lines at ~72 chars.
4. Format (conventional commits):
   ```
   <type>(<scope>): <short description>

   <body>
   ```
   Omit `(scope)` if the change spans the whole repo. Omit the body if the
   header is self-explanatory. Add a `BREAKING CHANGE:` footer or `!` marker
   for breaking changes.
5. **Print the exact `git commit -m "..."` command (or a multi-line
   `git commit -F -` heredoc) for the user to run themselves.** Never run
   `git commit`, `git add`, or any git mutation yourself.

$ARGUMENTS