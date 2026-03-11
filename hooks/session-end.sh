#!/bin/bash
# Claude Atlas — Session End Hook
# Fires: Stop
# Purpose: Remind to run /task complete if a task is in progress

STATUS_FILE="status/progress.md"

if [ ! -f "$STATUS_FILE" ]; then
  exit 0
fi

# Check if there's an in-progress task
if grep -q "IN_PROGRESS" "$STATUS_FILE" 2>/dev/null; then
  CURRENT_TASK=$(grep "Current Task" "$STATUS_FILE" | head -1)
  echo "REMINDER: A task is still in progress: $CURRENT_TASK"
  echo "Run /task [phase] [task] complete before ending your session."
fi
