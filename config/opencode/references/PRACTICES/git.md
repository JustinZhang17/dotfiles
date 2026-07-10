# Git Workflow

Trunk-based development, kept simple and language-agnostic.

## Branching

- Default branch: `main` (fall back to `master` if that is the repo default).
- Short-lived feature branches off the latest `main`. Merge or rebase within a
  few days.
- Branch naming: `<type>/<short-scope>`, e.g. `feat/checkout-flow`,
  `fix/expire-token`, `chore/bump-deps`, `hotfix/null-render`. Lowercase,
  hyphen-separated, no issue number unless the org requires it (`feat/checkout-482`).
- Never commit directly to `main`. Always open a PR.

## Merging vs rebasing

- **Rebase** your branch onto `main` before opening a PR to keep history clean.
- **Squash-merge** single-commit work; **merge** (no fast-forward) multi-commit
  work where the individual commits tell a useful story.
- After merge, delete the branch locally and remotely.

## History

- Rewrite only your own unmerged branches. Never rewrite shared history or
  anything already on `main`.
- Force-push to your own branches is fine (`git push --force-with-lease`); never
  `--force` to `main`/`master` or to anyone else's branch.
- `git reset --hard`, `git clean -fd`: only on your own unmerged work.

## Commits

- See `commits.md` for conventional commits, one logical change per commit.
- Stage deliberately (`git add -p`) rather than `git add -A` when the working
  tree has unrelated noise.

## Stash

- `git stash` is fine for short detours; clear it when done. Don't use stash as
  long-term storage; create a branch instead.