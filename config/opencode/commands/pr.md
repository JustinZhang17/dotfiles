---
description: Draft a pull request description from the diff between the current branch and its base for the user to open themselves.
agent: build
---

Draft a pull request description. Version control and PRs are the user's
responsibility; you draft, the user opens the PR. Never run `gh` or any git
mutation yourself.

1. Determine the base branch: use `$1` if given, otherwise the repository's
   main branch (typically `main`; fall back to `master`).
2. Run `git log --oneline $BASE..HEAD`, `git diff $BASE...HEAD`, and
   `git status` (read-only) to understand the full set of changes on this branch.
3. Fill this template:

   ```markdown
   ## Summary

   <one line capturing the branch's purpose>

   ## Changes

   <bulleted list of what changed and why, grouped by area>

   ## Testing

   <how it was verified: commands run, results; or "To be filled by author">

   ## Related Issues

   <issue refs from branch name or commits; blank if none>
   ```

   Do not fabricate issue links.

4. **Print the completed description and the `gh pr create` command (or the
   PR URL target) for the user to run themselves.** Never open the PR, raise
   an issue, or run `gh`/git mutation.

$ARGUMENTS