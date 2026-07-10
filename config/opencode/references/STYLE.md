# Style Guide

Personal style conventions for all code and documentation. Topic-specific
practice documents live in `PRACTICES/`. Agents should read this and the
relevant `PRACTICES/` files before writing code, commits, tests, or prose, and
follow them unless the project's own conventions override.

## Formatting

- Indent with the project's existing style; never mix tabs and spaces.
- Keep lines under 100 chars where reasonable; never exceed the project's
  configured limit.
- End files with a single trailing newline. No trailing whitespace.
- One statement per line; no comma-first formatting.

## Naming

- Variables and functions: `camelCase`, `snake_case`, or `PascalCase`,
  matching the language and the surrounding file. Consistency within a file
  wins.
- Constants: `SCREAMING_SNAKE_CASE` for true constants; otherwise match locals.
- Boolean names read as assertions: `isActive`, `hasAccess`, not `flag` / `state`.
- Pluralize collections unless the language idiom forbids it.
- Avoid abbreviations except widespread ones (`id`, `url`, `http`, `db`).

## Typography

- American English spelling.
- Regular hyphens (`-`), never em dashes. No surrounding spaces in
  compound words (`word-word`); use a comma, semicolon, or parenthetical
  rewrite for parenthetical clauses instead of a dash.
- Oxford comma in lists of three or more.
- Two spaces after a sentence-ending period is not used; one space.
- Backticks for code, file paths, commands, identifiers. Quotes for prose.

## Comments & docs

- Comments explain *why*, never *what*; the code shows what.
- No commented-out code; delete it, the VCS remembers.
- Docstrings/headers describe the contract, not the implementation.

## Simplicity

- Done-right over a hard-coded temporary fix. If a workaround only solves a
  specific input, generalize it or remove the case that needs it.
- Simple, robust, readable over clever. Cleverness taxes the next reader.
- Not over-engineered; build for real requirements, not imagined ones. Delete
  speculative params, config flags, and abstractions "for later" when a
  simpler approach covers the actual cases.
- Fewer moving parts. If a change doubles the surface area to fix one bug, it
  is probably wrong.

## Other

- Prefer composition over inheritance.
- Fail loudly and early; avoid silent fallbacks.
- No `TODO` without a name and date: `TODO(justin 2026-07): ...`.
- Don't introduce a dependency for a one-liner.