# Active Hook Scripts

- **auto-mode.sh** — PreToolUse (Bash): auto-approves Bash commands when enabled (toggle: `~/.claude/.auto-mode`), enforces deny list
- **rtk-rewrite.sh** — PreToolUse (Bash): rewrites commands through RTK proxy for token savings
- **superpowers-redirect.sh** — PreToolUse (Write|Edit): blocks spec/plan markdown writes outside ~/projects/
- **pre-commit-reminder.sh** — PreToolUse (Bash): reminds user to invoke pre-commit skill before git commits
- **cleanup-worktrees.sh** — SessionStart: removes merged worktrees automatically (runs on every session start)
- **worktree-create.sh** — WorktreeCreate: creates worktree at `<repo-root>/.claude/worktrees/<name>` branching from `origin/HEAD`, then copies `.env*` files from the main worktree into the new one; prints the absolute worktree path to stdout

## Hook Execution Order

**PreToolUse** hooks fire in this sequence:
1. **auto-mode.sh** (Bash) — auto-approves or denies Bash commands based on toggle and deny list
2. **rtk-rewrite.sh** (Bash) — rewrites commands through RTK proxy for token savings
3. **superpowers-redirect.sh** (Write|Edit) — blocks spec/plan writes outside ~/projects/
4. **pre-commit-reminder.sh** (Bash) — reminds user to invoke pre-commit skill before git commits

**WorktreeCreate** hooks fire in this sequence:
1. worktree-create.sh — creates worktree + copies .env* files; prints path to stdout

**SessionStart** hooks fire in this sequence:
1. cleanup-worktrees.sh — removes merged worktrees

## Maintenance

- **After `ctx upgrade`**: context-mode hook paths in `settings.json` are version-pinned by the plugin. Verify hook commands still resolve after upgrades — run `ctx doctor` if hooks stop firing.

## Linting

- Add PostEdit hooks in **project** settings.json (eslint, ruff, ktlint, etc.)
- Never add to global — linters vary by project
