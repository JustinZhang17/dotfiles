# Commit Messages: Conventional Commits

All commits follow [Conventional Commits](https://www.conventionalcommits.org/)
with the format:

```
<type>(<scope>): <short description>

<body>

<footer>
```

## Format

- **type**: one of `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`,
  `build`, `ci`, `chore`, `revert`.
- **scope**: optional, lowercase, the affected area (`auth`, `api`, `ui`). Omit
  if the change spans the whole repo.
- **short description**: imperative mood, lowercase first letter, no trailing
  period, ≤ ~50 chars.
- **body**: optional, wrapped at ~72 chars; explain *why*, not *what* (the diff
  shows what). One blank line separates header, body, footer.
- **footer**: `BREAKING CHANGE: <description>` or issue refs
  (`Closes #123`, `Refs #456`). One per line.

## Breaking changes

- Use the `!` marker: `feat(api)!: drop support for v1` *or* a
  `BREAKING CHANGE:` footer. Prefer the footer when more context is needed.

## Rules

- One logical change per commit. If unrelated, split.
- Do not commit secrets, build artifacts, or `.env`.
- Squash fixup commits before merging to the target branch, not after.
- A revert commit is `revert: <original subject>` with a body linking the
  reverted commit's hash.

## Examples

Good:

```
fix(auth): reject expired tokens before refresh

Expired tokens were silently refreshing, masking logout. Reject at the
guard instead so the client sees a 401 and can re-authenticate.

Closes #482
```

Bad: `updated stuff`, `Fixes bug, WIP`, `feat: This adds a new feature.`