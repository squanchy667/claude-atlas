# Task

You are executing a task lifecycle action. This is the unified task command handling plan, start, complete, and drift actions.

Parse $ARGUMENTS to extract the phase, task, and action.

Expected format: `phase-N task-M [plan|start|complete|drift]`

Examples:
- `phase-1 task-1 plan`
- `phase-2 task-3 start`
- `phase-1 task-2 complete`
- `phase-3 task-1 drift`

Extract:
- PHASE_NUM: the number after "phase-"
- TASK_NUM: the number after "task-"
- ACTION: one of plan, start, complete, drift

If any part is missing, ask the user to provide it.

Paths used throughout:
- TASK_DIR: `tasks/phase-[PHASE_NUM]/task-[TASK_NUM]/`
- PHASE_DIR: `phases/phase-[PHASE_NUM]/`

---

## Action: plan

This is the pre-task agreement conversation. The single most important step in the entire workflow. Get this right and the task executes cleanly. Get it wrong and everything drifts.

### 1. Load Context

Read the following files:
- `[TASK_DIR]/task.md` — the task definition
- `project/architecture.md` — structural context
- `skills/INDEX.md` — available skills
- `memory/mistakes.md` — lessons learned from past mistakes
- `memory/patterns.md` — established patterns
- `memory/decisions.md` — prior decisions that may constrain this task

If any file does not exist, note its absence but continue.

### 2. Propose the Agreement

Present the full pre-task agreement to the human:

**Demo Moment:** Describe in plain language what the human will see or experience when this task is done. Be specific. "You will be able to click X and see Y" not "The feature will work."

**Checkpoint Parameters:** List 3-4 concrete things the human will physically verify after completion. Each must be observable and unambiguous. Examples: "The login form accepts email and password", "The API returns 200 with the expected JSON shape", "The test suite passes with 0 failures."

**Scope Boundary:**
- IN: [what this task will do]
- OUT: [what this task will NOT do, even if related]

**Skill Manifest:** List which existing skills from skills/active/ and skills/foundation/ will be used, and how.

**Achilles' Heels:** Where is this task most likely to go wrong? What is the hardest part? Be honest.

**New Skills Needed:** If this task requires a capability not covered by existing skills, list what needs to be created.

**Known Unknowns:** Questions that cannot be answered until implementation begins.

### 3. Get Approval

Present the agreement and ask: "Does this agreement look right? Adjust anything before I proceed."

Incorporate all feedback. Re-present changed sections. Repeat until the human approves.

### 4. Write Agreement Files

Once approved, create these files in TASK_DIR:

**agreement.md:**
```markdown
# Agreement: [TXXX] [Task Name]

**Status:** APPROVED
**Approved:** [timestamp]

## Demo Moment
[text]

## Checkpoint Parameters
1. [parameter 1]
2. [parameter 2]
3. [parameter 3]

## Scope
### In Scope
- [item]

### Out of Scope
- [item]

## Skill Manifest
- [skill]: [how it will be used]

## Achilles' Heels
- [risk]

## New Skills Needed
- [skill] or "None"

## Known Unknowns
- [question] or "None"
```

**skills.md:** List the skills loaded for this task with their file paths.

**test-spec.md:** Define the test criteria based on checkpoint parameters. For each parameter, write a concrete test (manual or automated) that verifies it.

### 5. Chain Skill Creation

If "New Skills Needed" is not empty, tell the user: "This task needs [N] new skill(s). Run `/skill create [name]` for each, or I can create them now."

If the user agrees, create each skill following the `/skill create` process.

---

## Action: start

Load surgical context and prepare for implementation.

### 1. Verify Agreement

Read `[TASK_DIR]/agreement.md`. If it does not exist or its status is not "APPROVED", stop and say: "No approved agreement found for this task. Run `/task phase-[N] task-[M] plan` first."

### 2. Verify Dependencies

Read `[TASK_DIR]/task.md` for the "Depends On" field. For each dependency, check its status in `[PHASE_DIR]/INDEX.md`. If any dependency is not DONE, stop and say: "Blocked by [TXXX] which is [status]. Complete that task first."

### 3. Team Mode Check

Read `status/progress.md`. If team mode is active, read `[PHASE_DIR]/workstreams.md` (if it exists) and verify this task is either unassigned or assigned to the current developer. If assigned to someone else, warn: "This task is assigned to [developer]. Proceed anyway? (y/n)"

### 4. Load Context

Based on the agreement's skill manifest and the task's "Files Likely Touched" list, read only the files relevant to this task. Do not load the entire codebase.

Report what was loaded:
```
Context loaded for [TXXX]:
- Architecture: [sections read]
- Skills: [skills loaded]
- Source files: [files read]
- Memory: [relevant entries]
```

### 5. Update Status

Update `status/progress.md`: set Current Task to this task.
Update `[PHASE_DIR]/INDEX.md`: set this task's status to IN_PROGRESS.

### 6. Ready

Say: "Ready to implement [TXXX]: [task name]. Context is loaded. Proceed when ready."

Do NOT begin implementation. Wait for the human to signal to proceed.

---

## Action: complete

End-of-task sequence. This is the most thorough and honest command.

### 1. Write Outcome

Create `[TASK_DIR]/outcome.md`:
```markdown
# Outcome: [TXXX] [Task Name]

**Completed:** [timestamp]
**Status:** COMPLETE

## What Was Built
[summary paragraph]

## Files Changed
| File | Action | Description |
|------|--------|-------------|
| [path] | Created/Modified/Deleted | [what changed] |

## Verification
- [how it was tested or verified]

## Notes
[anything noteworthy]
```

### 2. Drift Interrogation

Ask yourself these questions honestly. Do not skip any.

- "Did anything deviate from the agreement?"
- "Did I modify any file not listed in the agreement's scope?"
- "Did I fix anything without documenting it?"
- "Did I make any decision not in the plan?"
- "Did the implementation differ from what the demo moment described?"

If ANY answer is yes, immediately create or append to `[TASK_DIR]/drift.md`:
```markdown
## Drift: [DRIFT_ID]
- **Timestamp:** [now]
- **Expected:** [what the agreement said]
- **Actual:** [what actually happened]
- **Why:** [reason for deviation]
- **Action Taken:** [what was done about it]
- **Impact:** [effect on task or project]
- **Severity:** [Low / Medium / High]
```

### 3. File Tests

If any tests were created or updated during this task, copy or link them to `[TASK_DIR]/tests/`. Create the directory if needed.

### 4. Skill Scan

Analyze the outcome for patterns worth capturing:
- Did a new approach emerge that was not previously documented?
- Was a workaround found for a known challenge?
- Did a technique prove particularly effective?

If a pattern is found, create a draft skill in `skills/archive/phase-[N]-task-[M]/` with SKILL.md following the standard template. Flag it for phase-end review.

### 5. Fill Checkpoint Self-Validation

Create `[TASK_DIR]/checkpoint.md` using the template from `checkpoints/template.md`:
- Fill the "Expected" column from the agreement's checkpoint parameters.
- Fill the "Actual" column honestly based on what was delivered.
- Fill the "Status" column: MET, PARTIALLY_MET, or NOT_MET.
- Write the self-validation section: an honest assessment of the work.
- Leave the "Human Review" section empty for the checkpoint command.

### 6. Update Memory

Check if any of the following apply and update the corresponding files:

- **New pattern discovered** -> Append to `memory/patterns.md` with ID, description, context, and usage guidance.
- **Mistake made and corrected** -> Append to `memory/mistakes.md` with ID, what happened, root cause, lesson, and prevention.
- **Significant decision made** -> Append to `memory/decisions.md` with ID, date, decision, context, alternatives, and outcome.

### 7. Archive Task Skills

If any skills were created in the task directory during implementation, move them to `skills/archive/phase-[N]-task-[M]/`.

### 8. Update Index Files

Update `[PHASE_DIR]/INDEX.md`: set this task's status to IN_REVIEW.
Update `skills/INDEX.md` if any skills were created or archived.
Update `status/progress.md`: set Last Completed to this task.

### 9. Commit

Stage and commit all changes with message: `task(phase-[N]-task-[M]): complete -- [task name]`

### 10. Present Summary

```
Task [TXXX] complete: [task name]

Files changed: [count]
Drift events: [count] ([severities])
Skills drafted: [count]
Memory updates: [count]
Self-validation: [all met / partial / issues found]

Next: Run /checkpoint phase-[N] task-[M] for human review.
```

---

## Action: drift

Flag a deviation immediately. This can be run at any time during an active task.

### 1. Ask What Deviated

Ask the user: "What deviated from the plan?" Wait for their response.

If the user does not provide details, prompt: "Please describe: what was expected, what actually happened, and why."

### 2. Create Drift Entry

Generate a drift ID: `D[NNN]` (incrementing from existing entries).

Create or append to `[TASK_DIR]/drift.md`:

```markdown
## Drift: [DRIFT_ID]
- **Timestamp:** [now]
- **Expected:** [from user or agreement]
- **Actual:** [what happened]
- **Why:** [reason]
- **Action Taken:** [what was done or will be done]
- **Impact:** [effect on task or project]
- **Severity:** [Low / Medium / High — ask user if unclear]
```

### 3. Assess Impact

If the drift creates a blocker (prevents other tasks from starting or completing):
- Add to `status/blockers.md` with reference to the drift ID.
- Report: "This drift has been flagged as a blocker."

If the drift touches the task's scope or the project architecture:
- Immediately notify: "WARNING: This drift affects [scope/architecture]. Please review before continuing."

### 4. Update Checkpoint

If `[TASK_DIR]/checkpoint.md` exists, add a note that drift occurred, referencing the drift ID.

### 5. Continue

Say: "Drift [DRIFT_ID] documented. Work can continue unless this is a blocker."

Drift documentation does not stop progress unless the drift is a blocker.
