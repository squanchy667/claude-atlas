#!/bin/bash
# Claude Atlas — Test Integrity Hook
# Fires: PostToolUse on Edit
# Purpose: Warn when pre-existing test files are modified
# Rule: Tests define requirements. Fix code to pass tests. Never change tests.

if [ -t 0 ]; then
  exit 0
fi

INPUT=$(cat)

FILE_PATH=$(echo "$INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Check if this is a test file
if echo "$FILE_PATH" | grep -qE '(test|spec|__tests__)'; then
  # Check if this file existed before the current task started
  # (was committed in git before task started)
  if git log --oneline -1 -- "$FILE_PATH" 2>/dev/null | grep -q .; then
    echo "WARNING: Modifying pre-existing test file: $FILE_PATH"
    echo "Tests define requirements. Fix the code, not the test."
    echo "If this modification is intentional, document it in drift.md as a CRITICAL drift event."
  fi
fi
