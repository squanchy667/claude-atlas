# Checkpoint

You are conducting a human review walkthrough for a completed task. You will compare what was promised to what was delivered, guide the human through verification, and record their decision.

Parse $ARGUMENTS to extract the phase and task.

Expected format: `phase-N task-M`

Examples:
- `phase-1 task-1`
- `phase-2 task-3`

Extract:
- PHASE_NUM: the number after "phase-"
- TASK_NUM: the number after "task-"
- TASK_DIR: `tasks/phase-[PHASE_NUM]/task-[TASK_NUM]/`
- PHASE_DIR: `phases/phase-[PHASE_NUM]/`

## Step 1: Load Review Context

Read the following files:
- `[TASK_DIR]/agreement.md` — what was promised (checkpoint parameters, scope, demo moment)
- `[TASK_DIR]/outcome.md` — what was built
- `[TASK_DIR]/checkpoint.md` — self-validation assessment
- `[TASK_DIR]/drift.md` — any deviations (may not exist; that is fine)

If `agreement.md` does not exist, stop and say: "No agreement found for this task. Cannot run checkpoint without a prior agreement. Run `/task phase-[N] task-[M] plan` first."

If `outcome.md` does not exist, stop and say: "No outcome recorded for this task. Run `/task phase-[N] task-[M] complete` first."

### Criteria Verification

Before presenting the comparison, verify that the agreement has not been modified since approval:
1. Check the git history of `[TASK_DIR]/agreement.md`. If it was modified after the approval timestamp, flag this immediately: "WARNING: agreement.md was modified after approval. The checkpoint parameters may have been altered."
2. Check the git history of any test files in `[TASK_DIR]/tests/`. If pre-existing tests were modified, flag: "WARNING: Pre-existing test files were modified during this task. This requires human review."
3. Present any flags before the comparison so the human can investigate.

## Step 2: Present Side-by-Side Comparison

For each checkpoint parameter from the agreement, present a comparison:

```
CHECKPOINT REVIEW: [TXXX] [Task Name]
=======================================

Demo Moment (promised):
  [text from agreement]

Demo Moment (delivered):
  [text from outcome]

---

Parameter 1: [parameter name]
  Promised: [what the agreement said]
  Delivered: [what the outcome says]
  Self-Assessment: [from checkpoint.md — MET/PARTIALLY_MET/NOT_MET]
  [If drift exists for this parameter: "Drift D[NNN]: [brief description]"]

Parameter 2: [parameter name]
  Promised: [...]
  Delivered: [...]
  Self-Assessment: [...]

Parameter 3: [parameter name]
  Promised: [...]
  Delivered: [...]
  Self-Assessment: [...]

[If additional drift entries exist that don't map to specific parameters:]
Other Drift Events:
  D[NNN]: [description] — Severity: [level]
```

## Step 3: Guide Verification

Say: "Please verify each checkpoint parameter now. Check the running program, inspect the output, or run the tests as appropriate."

Then, for each parameter, ask individually:
"Parameter [N]: [parameter name] — Does this look right? (yes / no / partial)"

Wait for the human's response to each parameter before moving to the next.

## Step 4: Collect Overall Decision

After all parameters have been reviewed, ask:
"Overall decision for [TXXX]: Approved / Revisions Required / Rejected?"

## Step 5: Record the Review

Update `[TASK_DIR]/checkpoint.md` by filling the Human Review section:

```markdown
## Human Review

**Reviewer:** [human]
**Date:** [timestamp]

### Parameter Results
| Parameter | Self-Assessment | Human Verdict | Notes |
|-----------|----------------|---------------|-------|
| [param 1] | MET            | Approved      | —     |
| [param 2] | PARTIALLY_MET  | Revision      | [note]|

### Overall Decision: [APPROVED / REVISIONS_REQUIRED / REJECTED]

### Revision Items
[If revisions required, list each specific item that needs fixing]

### Rejection Reason
[If rejected, document why]
```

## Step 6: Apply Decision

### If APPROVED:
1. Update `[PHASE_DIR]/INDEX.md`: set this task's status to DONE.
2. Update `status/progress.md`: set Last Completed to this task, advance Current Task to the next task.
3. Move `[TASK_DIR]/checkpoint.md` copy to `checkpoints/passed/phase-[N]-task-[M].md`.
4. Say: "Task [TXXX] approved and marked DONE."

### If REVISIONS_REQUIRED:
1. Update `[PHASE_DIR]/INDEX.md`: set this task's status back to IN_PROGRESS.
2. List each specific revision item clearly.
3. Say: "Task [TXXX] needs revisions. Fix the items listed above, then run `/task phase-[N] task-[M] complete` again followed by `/checkpoint phase-[N] task-[M]`."

### If REJECTED:
1. Update `[PHASE_DIR]/INDEX.md`: set this task's status to BLOCKED.
2. Add entry to `status/blockers.md` referencing the rejection.
3. Document the rejection reason in `[TASK_DIR]/checkpoint.md`.
4. Say: "Task [TXXX] rejected. See blocker entry. This task and any tasks depending on it are now blocked."
