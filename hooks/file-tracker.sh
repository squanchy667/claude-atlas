#!/bin/bash
# Claude Atlas — File Tracker Hook
# Fires: PostToolUse on Edit, Write
# Purpose: Track all file modifications for drift detection

# This hook is called by Claude Code after Edit/Write tool use.
# It appends the modified file path to .atlas-session-files.
# The /task complete command reads this to compare against agreed scope.

SESSION_FILE=".atlas-session-files"

# The file path comes from stdin as JSON from Claude Code hooks.
# If stdin is a terminal (no piped input), exit silently.
if [ -t 0 ]; then
  exit 0
fi

INPUT=$(cat)

# Extract file_path from the hook input
FILE_PATH=$(echo "$INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')

if [ -n "$FILE_PATH" ]; then
  echo "$FILE_PATH" >> "$SESSION_FILE"
fi
