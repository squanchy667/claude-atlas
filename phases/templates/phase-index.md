# Phase [PHASE_NUMBER]: [PHASE_NAME] — Task Map

<!-- Auto-updated by hooks when task status changes. -->

## Tasks

| | Task | Name | Status | Depends On | Assigned To | Started | Completed |
|---|------|------|--------|------------|-------------|---------|-----------|
| | [PHASE_NUMBER]-1 | [TASK_NAME] | pending | — | [DEVELOPER] | — | — |
| | [PHASE_NUMBER]-2 | [TASK_NAME] | pending | [PHASE_NUMBER]-1 | [DEVELOPER] | — | — |
| | [PHASE_NUMBER]-3 | [TASK_NAME] | pending | — | [DEVELOPER] | — | — |
| | [PHASE_NUMBER]-4 | [TASK_NAME] | pending | [PHASE_NUMBER]-2, [PHASE_NUMBER]-3 | [DEVELOPER] | — | — |

<!-- Active task marker: replace the empty first column with ">>>" for the current task. -->

## Status Values

- **pending** — Not started. May be blocked by dependencies.
- **in progress** — Currently being worked on.
- **in review** — Code complete, awaiting checkpoint approval.
- **done** — Checkpoint approved. Task is finished.
- **blocked** — Cannot proceed. Dependency not met or issue discovered.

## Dependency Map

<!-- Visual representation of which tasks block which. Update as tasks are added. -->

```
[DEPENDENCY_DIAGRAM]

Example:

  [PHASE_NUMBER]-1 ───▶ [PHASE_NUMBER]-2 ───▶ [PHASE_NUMBER]-4
                                                    ▲
  [PHASE_NUMBER]-3 ────────────────────────────────┘
```

## Notes

- Tasks with no dependencies can run in parallel.
- A task cannot start until all entries in its "Depends On" column are done.
- "Assigned To" is only relevant in team mode. Solo projects can leave it blank.
