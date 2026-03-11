#!/bin/bash
# Claude Atlas — Scope Guard Hook
# Fires: PreToolUse on Edit, Write
# Purpose: Warn when editing files outside the current task's agreed scope

# This is a soft guard — it warns but does not block.
# Blocking would break legitimate edge cases.
# The /task complete drift interrogation does the real enforcement.

STATUS_FILE="status/progress.md"

if [ ! -f "$STATUS_FILE" ]; then
  exit 0
fi

# Extract current phase and task from status
CURRENT_TASK=$(grep -o 'phase-[0-9]*-task-[0-9]*' "$STATUS_FILE" | head -1)

if [ -z "$CURRENT_TASK" ]; then
  exit 0
fi

# Parse phase and task numbers
PHASE=$(echo "$CURRENT_TASK" | grep -o 'phase-[0-9]*' | grep -o '[0-9]*')
TASK=$(echo "$CURRENT_TASK" | grep -o 'task-[0-9]*' | grep -o '[0-9]*')

AGREEMENT="tasks/phase-${PHASE}/task-${TASK}/agreement.md"

if [ ! -f "$AGREEMENT" ]; then
  exit 0
fi

# If agreement exists, this is informational only.
# The /task complete drift interrogation does the real check.
