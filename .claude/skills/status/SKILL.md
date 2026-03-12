---
name: status
description: Atlas status command
user-invocable: true
---

# Status

You are producing a quick project status summary. This command takes no arguments and should complete in under 3 seconds. Keep output concise and scannable.

## Step 1: Load State

Read the following files. If any file does not exist, note it as "not initialized" in the relevant section.

- `status/progress.md` — current phase, current task, last completed, setup state
- `status/blockers.md` — open blockers
- `phases/INDEX.md` — all phases and their statuses
- The current phase's `INDEX.md` (from `phases/phase-[N]/INDEX.md` where N is from progress.md)

## Step 2: Compute Health

Determine project health based on these signals:
- **Green:** No blockers, current task on track, no unresolved systemic drift.
- **Yellow:** Minor blockers exist, or 1+ tasks have drift events, or a checkpoint has revisions required.
- **Red:** Blocking issues prevent progress, or a task was rejected, or setup is incomplete.

## Step 3: Present Summary

Output the following format exactly. Replace bracketed values with actual data. Omit sections that do not apply.

```
PROJECT STATUS
===============

Phase: [N] — [phase name] ([M/T tasks done])
Task:  [TXXX] [task name] ([status])
Last:  [TXXX] [task name] — [date or "just now"]
Next:  [TXXX] [task name]

Blockers: [count]
[If any blockers, list each on its own line:]
  - [BL001] [description] — [severity]

Health: [GREEN / YELLOW / RED]
[If not green, one-line explanation why]
```

## Step 4: Team Status (if team mode)

Read `status/progress.md` for team mode flag. If active, read `team/members.md` and the current phase's `workstreams.md` (if it exists).

Append to the output:

```
Team:
  [Developer]: [current task or "idle"] — [tasks completed this phase]/[tasks assigned]
  [Developer]: [current task or "idle"] — [tasks completed this phase]/[tasks assigned]
```

## Step 5: Quick Suggestions

If there are actionable next steps, append up to 2 suggestions:

```
Suggested:
  - [action, e.g., "Run /checkpoint phase-1 task-2 to review completed task"]
  - [action, e.g., "Resolve blocker BL001 before starting task-3"]
```

If everything is on track, do not add suggestions.
