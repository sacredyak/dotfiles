#!/usr/bin/env bash
# WorktreeCreate hook — creates a git worktree and copies .env* files from main worktree
# Receives JSON on stdin: {name, session_id, cwd}
# Must print the absolute path of the created worktree directory to stdout

set -euo pipefail

LOG_PREFIX="[worktree-create]"

# Read stdin JSON
INPUT=$(cat)
NAME=$(echo "$INPUT" | jq -r '.name')
CWD=$(echo "$INPUT" | jq -r '.cwd')

echo "$LOG_PREFIX name=$NAME cwd=$CWD" >&2

# Find git repo root from cwd
REPO_ROOT=$(git -C "$CWD" rev-parse --show-toplevel 2>/dev/null)
if [ -z "$REPO_ROOT" ]; then
  echo "$LOG_PREFIX ERROR: Could not find git repo root from $CWD" >&2
  exit 1
fi
echo "$LOG_PREFIX repo root=$REPO_ROOT" >&2

# Worktree destination
WORKTREE_DIR="$REPO_ROOT/.claude/worktrees/$NAME"
echo "$LOG_PREFIX worktree dir=$WORKTREE_DIR" >&2

# Create parent directory if needed
mkdir -p "$(dirname "$WORKTREE_DIR")"

# Create the worktree branching from origin/HEAD
git -C "$REPO_ROOT" worktree add "$WORKTREE_DIR" -b "$NAME" "origin/HEAD" 2>&1 | while IFS= read -r line; do
  echo "$LOG_PREFIX git: $line" >&2
done

# Copy .env* files from cwd into the new worktree
ENV_COUNT=0
while IFS= read -r -d '' ENV_FILE; do
  BASENAME=$(basename "$ENV_FILE")
  DEST="$WORKTREE_DIR/$BASENAME"
  cp "$ENV_FILE" "$DEST"
  echo "$LOG_PREFIX copied $BASENAME → $DEST" >&2
  ENV_COUNT=$((ENV_COUNT + 1))
done < <(find "$CWD" -maxdepth 1 -name '.env*' -type f -print0 2>/dev/null)

echo "$LOG_PREFIX copied $ENV_COUNT .env* file(s)" >&2

# Print the worktree path to stdout (required by WorktreeCreate hook contract)
echo "$WORKTREE_DIR"
