# Complete Phase

You are running the phase gate sequence. This command verifies all tasks are done, promotes skills, updates memory, and formally closes the phase.

The phase number is provided in: $ARGUMENTS

## Step 1: Parse Phase Number

Extract the phase number from $ARGUMENTS. If not provided, read `status/progress.md` and use the current phase.

Set:
- PHASE_NUM: the phase number
- PHASE_DIR: `phases/phase-[PHASE_NUM]/`

## Step 2: Verify All Tasks Complete

Read `[PHASE_DIR]/INDEX.md` to get the task list and their statuses.

Check every task. For phase completion, every task must have an APPROVED checkpoint (status DONE in the INDEX).

If any tasks are not DONE:
1. List each incomplete task with its current status.
2. Say: "Cannot complete phase [N]. The following tasks do not have approved checkpoints:"
3. List them with suggested next action for each:
   - PENDING or IN_PROGRESS: "Run /task phase-[N] task-[M] complete"
   - IN_REVIEW: "Run /checkpoint phase-[N] task-[M]"
   - BLOCKED: "Resolve blocker first (see status/blockers.md)"
4. Stop. Do not proceed.

## Step 3: Skill Promotion Review

Scan `skills/archive/` for any skill directories matching `phase-[PHASE_NUM]-*`.

For each archived skill found:

1. Read its SKILL.md.
2. Check future phase definitions (all `phases/phase-[M]/phase.md` where M > PHASE_NUM) and task definitions to assess reusability.
3. Present to the human:
   ```
   Skill: [name]
   Created in: Phase [N], Task [M]
   What it does: [one line]
   Future relevance: [which future tasks or phases could use it]
   Recommendation: Promote / Keep in archive
   ```
4. Ask: "Promote this skill to active? (yes/no)"
5. If yes: move the skill file from `skills/archive/phase-[N]-task-[M]/` to `skills/active/`. Update `skills/INDEX.md`.
6. If no: keep in archive. Log the decision.

## Step 4: Memory Consolidation

Review all tasks from this phase for memory updates.

**Patterns:** Read all `outcome.md` files from the phase's tasks. Identify any recurring approaches, techniques, or solutions. If a pattern appears in 2+ tasks and is not already in `memory/patterns.md`, add it.

**Decisions:** Read all `agreement.md` files. Identify architectural or design decisions that affect future phases. If not already in `memory/decisions.md`, add them.

**Mistakes:** Read all `drift.md` files. Identify mistakes or avoidable issues. If not already in `memory/mistakes.md`, add them with prevention guidance.

## Step 5: Drift Analysis

Read all `drift.md` files from tasks in this phase.

Categorize drift events by type (scope change, approach change, dependency issue, etc.).

If the same drift type appears in 2 or more tasks:
1. Flag it as systemic in `memory/drift-log.md`:
   ```markdown
   ## Systemic Drift: [type]
   - Phase: [N]
   - Occurrences: [count]
   - Tasks affected: [TXXX, TXXX]
   - Pattern: [description of the recurring drift]
   - Recommended prevention: [what to do differently]
   ```
2. Report it to the human as a concern.

## Step 6: Create Phase Checkpoint

Create a file in `checkpoints/pending/phase-[PHASE_NUM].md`:

```markdown
# Phase [N] Checkpoint: [Phase Name]

**Date:** [timestamp]
**Status:** PENDING_REVIEW

## Phase Goal
[restate from phase.md]

## Deliverables
| Deliverable | Task | Evidence | Status |
|-------------|------|----------|--------|
| [item]      | TXXX | [file/test] | DONE |

## Exit Criteria
| Criterion | Met? | Evidence |
|-----------|------|----------|
| [criterion from phase.md] | Yes/No | [evidence] |

## Self-Validation
[honest assessment of whether the phase achieved its goal]

## Skills Promoted
- [skill name] — [reason]

## Patterns Learned
- [pattern] — [context]

## Gaps Carried Forward
- [any unresolved issues]

## Drift Summary
- Total events: [N]
- Systemic: [N]
- [list any significant drifts]
```

## Step 7: Update Gap Report

Read `atlas/gaps.md`. Check if any gaps from setup were resolved during this phase. If so, update their status to RESOLVED and fill "Resolved In" with the phase/task reference.

Check if any new gaps emerged during the phase. Add them to `atlas/gaps.md`.

## Step 8: Mark Phase Complete

Update `[PHASE_DIR]/INDEX.md`: set phase status to DONE.
Update `phases/INDEX.md`: set this phase's status to DONE.
Update `status/progress.md`: advance Current Phase to the next phase.

## Step 9: Team Retrospective (if team mode)

Read `status/progress.md`. If team mode is active:

1. Read `[PHASE_DIR]/workstreams.md` for the original assignments.
2. For each developer, summarize: tasks completed, drift events, skills contributed.
3. Identify collision events (tasks that conflicted or required coordination).
4. Assess sync point effectiveness (did planned sync points work?).
5. Write retrospective to `[PHASE_DIR]/retrospective.md`.

## Step 10: Commit

Stage and commit all changes: `phase([PHASE_NUM]): complete -- [phase name]`

## Step 11: Present Phase Summary

```
Phase [N] Complete: [Phase Name]
==================================

Tasks completed: [count]
Deliverables: [count] ([all met / some gaps])

Skills:
  Promoted to active: [count] ([names])
  Kept in archive: [count]

Memory updates:
  Patterns: +[N]
  Decisions: +[N]
  Mistakes: +[N]

Drift:
  Total events: [N]
  Systemic patterns: [N]

Gaps:
  Resolved: [N]
  New: [N]
  Carried forward: [N]

[If team mode:]
Team:
  [Developer]: [tasks completed] tasks, [drift] drift events
  Collisions: [count]
  Sync effectiveness: [assessment]

Next phase: [N+1] — [name]
Run /plan-phase [N+1] to detail it.
```
