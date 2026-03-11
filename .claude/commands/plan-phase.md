# Plan Phase

You are planning a specific phase in detail, breaking it into concrete tasks with dependencies, complexity estimates, and file impact analysis.

The phase number is provided in: $ARGUMENTS

## Step 1: Parse Phase Number

Extract the phase number from $ARGUMENTS. If no number is provided, read `status/progress.md` to determine the current phase. If that is also empty, default to phase 1.

## Step 2: Read Phase Definition

Read `phases/phase-[N]/phase.md` for the rough phase definition (goal, deliverables, entry/exit criteria).

If the file does not exist:
1. Read `phases/INDEX.md` and `project/overview.md` to understand the phase's intended scope.
2. Create `phases/phase-[N]/` directory if needed.
3. Create `phases/phase-[N]/phase.md` with: Phase Name, Goal, Key Deliverables, Entry Criteria, Exit Criteria, Dependencies on prior phases.

Also read:
- `project/architecture.md` for structural context
- `project/data-model.md` for entity context
- `skills/INDEX.md` for available skills
- `memory/patterns.md` and `memory/mistakes.md` for lessons from prior phases

## Step 3: Decompose into Tasks

Break the phase into concrete, implementable tasks. For each task:

1. Create directory `tasks/phase-[N]/task-[M]/` (where M is the task number within the phase, using TXXX format globally).
2. Create `tasks/phase-[N]/task-[M]/task.md` with:

```markdown
# [TXXX] [Task Name]

**Phase:** [N]
**Status:** PENDING
**Complexity:** [Low / Medium / High]
**Estimated Scope:** [number of files, approximate lines]

## Objective
[What this task produces — one paragraph]

## Deliverables
- [concrete output 1]
- [concrete output 2]

## Files Likely Touched
- [file path 1] — [what changes]
- [file path 2] — [what changes]

## Dependencies
- Depends On: [TXXX, TXXX] or "None"
- Blocks: [TXXX, TXXX] or "None"

## Acceptance Criteria
- [ ] [criterion 1]
- [ ] [criterion 2]

## Notes
[anything relevant]
```

Guidelines for task decomposition:
- Each task should be completable in a single focused session.
- Tasks that touch the same files should be sequential, not parallel.
- Data model and schema tasks come before logic tasks.
- Infrastructure/setup tasks come before feature tasks.
- Each task should have a clear, demonstrable outcome.

## Step 4: Identify Dependencies

Build the dependency graph:
- For each task, determine which other tasks must complete first.
- Fill the "Depends On" and "Blocks" fields in each task.md.
- Identify tasks that can run in parallel (no shared dependencies or file conflicts).

## Step 5: Team Mode (if active)

Check `status/progress.md` for team mode. If active:

1. Read `team/members.md` for developer specialties.
2. Analyze which tasks can run in parallel without file collisions.
3. Detect collision risks: tasks that touch the same files or modules.
4. Propose workstream assignments based on developer specialties and task domains.
5. Identify sync points: tasks where multiple workstreams must converge.
6. Write `phases/phase-[N]/workstreams.md`:

```markdown
# Phase [N] Workstreams

## Assignments
| Task | Developer | Rationale |
|------|-----------|-----------|
| TXXX | [name]    | [why]     |

## Parallel Groups
- Group 1: [TXXX, TXXX] — can run simultaneously
- Group 2: [TXXX, TXXX] — can run after Group 1

## Collision Risks
- [TXXX] and [TXXX] both touch [file] — must be sequential

## Sync Points
- After [TXXX, TXXX]: integration check before proceeding to [TXXX]
```

## Step 6: Skill Assessment

Review the tasks against `skills/INDEX.md`:
- For each task, note which existing skills apply.
- If a task requires a capability not covered by any existing skill, flag it.
- If a new foundation skill would benefit multiple tasks, propose its creation.

## Step 7: Update Index Files

Update `phases/phase-[N]/INDEX.md`:

```markdown
# Phase [N]: [Phase Name]

**Goal:** [one line]
**Status:** PLANNED
**Tasks:** [count]

## Task Map
| Task | Name | Status | Complexity | Depends On | Assigned To |
|------|------|--------|------------|------------|-------------|
| TXXX | ...  | PENDING | Medium    | -          | -           |

## Dependency Graph
[text representation showing task flow]
```

Update `phases/INDEX.md` with the phase status set to PLANNED.

Update `status/progress.md` with current phase if not already set.

## Step 8: Present Phase Summary

Present the complete phase plan for human review:

```
Phase [N]: [Phase Name]
========================

Goal: [goal]

Tasks ([count]):
  TXXX: [name] [complexity] [depends on]
  TXXX: [name] [complexity] [depends on]
  ...

Dependency flow:
  TXXX --> TXXX --> TXXX
              \--> TXXX

[If team mode:]
Workstream assignments:
  [Developer]: TXXX, TXXX
  [Developer]: TXXX, TXXX

Collision risks: [count]
Sync points: [count]

Skills needed: [list]
New skills to create: [list or "none"]
Estimated total complexity: [Low/Medium/High]
```

Wait for the human to review and approve. Apply any requested changes before finalizing.
