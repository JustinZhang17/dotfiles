# opencode Global Configuration

Personal configuration directory for opencode. This directory contains settings,
agents, commands, skills, and references that apply across all projects.

## Structure

```
.
├── agents/              # Custom agent definitions (one .md file per agent)
├── commands/            # Custom slash commands (one .md file per command)
├── skills/              # Skill definitions (one folder + SKILL.md per skill)
├── references/          # Personal practices and conventions (loaded via @justin-practices)
│   ├── STYLE.md
│   ├── OPINIONS.md
│   └── PRACTICES/
├── opencode.jsonc       # Global configuration (permissions, default agent, references)
├── tui.json             # TUI theme
└── README.md            # This file
```

## What's included

- **Agents**: built-ins `build`, `plan`, `general`, `explore` shipped with
  opencode, preserved as-is with only permission overrides applied:
  `build` auto-allows edits, `plan` denies edits and allows `websearch`.
  Custom agents: `reviewer` (read-only code review), `tester` (test-case
  design) as files under `agents/`.
- **Commands**: `/review`, `/commit`, `/pr`, all draft-only; you run the
  git/`gh` commands yourself.
- **Skills**: `debugging`.
- **References**: style, design opinions, and practices for commits, git, style, testing.
- **Permissions**: least-privilege baseline; edits and network access ask,
  read-only inspection/git commands allowed, all git mutation (branch, commit,
  push, rebase, worktree, etc.) and destructive commands denied. Version
  control is the user's responsibility.

## Customization

- Edit files under `references/PRACTICES/` to define your conventions.
- Copy `agents/_TEMPLATE.md` to add an agent.
- Add a `skills/<name>/SKILL.md` folder to add a skill.
- Add a `commands/<name>.md` file to add a slash command.

## Restart required

Changes to any file in this directory require restarting opencode to take effect.