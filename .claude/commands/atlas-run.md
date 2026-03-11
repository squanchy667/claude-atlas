# Atlas Run

You are entering full execution mode. This command orchestrates phase-by-phase, task-by-task project execution with configurable automation levels.

The user may pass arguments: $ARGUMENTS

## Step 1: Verify Setup

Read `status/progress.md`. Check that:
- "Setup Complete" is "yes"
- "Preview Approved" is "yes"

If either condition is not met, stop immediately and say:
"Cannot run. Project setup is incomplete or preview has not been approved. Run /atlas-setup first."

## Step 2: Parse Mode

Parse the mode from $ARGUMENTS:

- `--full-permission` — Full autopilot. Minimal interruptions. Only pause on errors, blockers, or phase boundaries if critical.
- `--supervised` — Autopilot with pauses at: pre-task agreement review, checkpoint review, and phase completion. This is the default.
- `--full-permission --report-only` — Same as full-permission but log every decision with reasoning to `atlas/run-report-[timestamp].md`.
- If $ARGUMENTS is empty or unrecognized, default to `--supervised`.

Report the selected mode to the user.

## Step 3: Determine Starting Point

Read `status/progress.md` to find:
- Current phase number
- Current task (if mid-phase)
- Last completed task

Read `phases/INDEX.md` to get the full phase list and their statuses.

Identify the starting point: the first phase with status not "DONE", and within it, the first task not "DONE".

Report: "Starting from Phase [N], Task [M]."

## Step 4: Execute Phases

For each phase starting from the current one:

### 4a. Plan Phase (if needed)
Check if `phases/phase-[N]/INDEX.md` has tasks listed. If not, execute the equivalent of `/plan-phase [N]`:
- Break the phase into tasks
- Create task folders and definitions
- Identify dependencies
- In team mode: propose workstream assignments

In `--supervised` mode: pause and present the phase plan for approval before continuing.

### 4b. Execute Tasks

Read `phases/phase-[N]/INDEX.md` to get the ordered task list with dependencies.

For each task in dependency order:

1. **Check dependencies.** If any dependency task is not DONE, skip this task and move to the next eligible one. If no tasks are eligible and undone tasks remain, report a deadlock and stop.

2. **In team mode:** Check workstream assignments. If the task is assigned to a different developer, skip it and note "Skipped [task] — assigned to [developer]."

3. **Plan the task.** Execute the equivalent of `/task phase-[N] task-[M] plan`:
   - Read task definition, architecture, skills, and mistakes
   - Propose the agreement (demo moment, checkpoints, scope, skills, risks)
   - In `--supervised` mode: pause and present agreement for human approval. Wait for approval before continuing.
   - In `--full-permission` mode: auto-approve the agreement and log the reasoning.
   - Write agreement.md, skills.md, test-spec.md

4. **Start the task.** Execute the equivalent of `/task phase-[N] task-[M] start`:
   - Load surgical context
   - Update progress and status

5. **Implement.** Execute the actual implementation work defined in the task agreement:
   - Follow the steps in agreement.md
   - Create/modify the files specified
   - Run tests if applicable
   - In `--report-only` mode: log each significant decision with reasoning

6. **Complete the task.** Execute the equivalent of `/task phase-[N] task-[M] complete`:
   - Fill outcome.md
   - Run drift interrogation
   - Scan for skill patterns
   - Update memory files
   - Update status

7. **Checkpoint.** Execute the equivalent of `/checkpoint phase-[N] task-[M]`:
   - In `--supervised` mode: present checkpoint comparison and wait for human review.
   - In `--full-permission` mode: perform self-validation, auto-approve if all parameters met, log reasoning. If any parameter fails, pause and ask the human.

8. **Commit.** Commit all changes: `task(phase-[N]-task-[M]): complete -- [task name]`

### 4c. Complete Phase

After all tasks in the phase are done:

1. Execute the equivalent of `/complete-phase [N]`:
   - Verify all checkpoints approved
   - Scan skills for promotion
   - Update memory
   - Analyze drift patterns
   - Create phase checkpoint

2. In `--supervised` mode: pause and present phase summary for approval.

3. In `--full-permission` mode: auto-approve and log reasoning.

4. Commit: `phase([N]): complete -- [phase name]`

5. Move to the next phase.

## Step 5: Project Summary

After all phases are complete, present the full project summary:

```
PROJECT COMPLETE: [PROJECT_NAME]
==================================

Phases completed: [N]
Tasks completed: [M]
Skills created: [K] ([promoted] promoted to active)
Drift events: [D] ([systemic] systemic)
Memory updates: [patterns] patterns, [decisions] decisions, [mistakes] mistakes
Blockers encountered: [B]

Mode: [mode used]
```

If `--report-only` was used, note the location of the run report file.
