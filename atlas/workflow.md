# Workflow -- Development Philosophy and Loop

This document defines how you build with Claude Atlas. It is opinionated. It does not say "you could do it this way." It says: this is how you build.

---

## Depth-First Philosophy

Build one thing. Prove it works end to end. Then expand.

Do not scaffold everything first. Do not create empty modules and fill them in later. Do not build horizontally across features. Build vertically through one feature: data model, backend, frontend, tests, all the way through. Verify it works. Then move to the next thing.

This applies at every level:
- **Phase level**: Complete phase 1 before planning phase 2 in detail.
- **Task level**: Finish one task before starting the next (unless dependencies allow parallel work).
- **Code level**: Implement the full path through a feature, not stubs.

The reason is simple: you learn the most from the first complete path. Every subsequent path is faster and better because of what the first one taught you. The knowledge compounds. Scaffolding teaches you nothing.

---

## The Full Journey

```
/atlas-init
    |
/atlas-setup (guided conversation)
    |
Preview (human approves the plan)
    |
/atlas-run (execution loop)
    |
    +-- /plan-phase N
    |       |
    |       +-- /task plan (for each task)
    |       |       |
    |       |       +-- Agreement (human approves)
    |       |
    |       +-- /task start
    |       |       |
    |       |       +-- Build (write code)
    |       |
    |       +-- /task complete
    |       |       |
    |       |       +-- Checkpoint (human reviews)
    |       |
    |       +-- (repeat for all tasks in phase)
    |
    +-- /complete-phase N
    |       |
    |       +-- Phase gate (verify, promote skills, update memory)
    |
    +-- (loop to next phase)
```

**Init** creates the structure. **Setup** fills it with your project definition. **Preview** gets human approval. **Run** executes the plan in a loop.

The loop is: plan a phase, execute its tasks one by one, gate the phase, move to the next. Within each task, the loop is: agree on what to build, build it, verify and checkpoint.

---

## Task Lifecycle

Every task follows the same lifecycle. No exceptions.

### 1. Plan

Claude reads the task spec and produces an agreement: what will be built, what files will be touched, what tests will be written, what the acceptance criteria are.

The agreement is the contract. Nothing happens without it.

The human reviews and approves the agreement. If it needs changes, Claude revises. If it is rejected, the task goes back to planning.

### 2. Agree

The human says yes. This is a gate. Claude does not proceed without explicit approval.

What approval means: the human has read the agreement and accepts the scope, approach, and criteria. If the human approved without reading, that is the human's responsibility, but Claude should make the agreement clear enough that skipping it would be an obvious mistake.

### 3. Build

Claude loads context (following INDEX.md routing), loads relevant skills, and implements the task. During implementation:

- If anything deviates from the agreement, Claude immediately logs it in status/drift.md using `/task drift`.
- If a decision is made that affects architecture, it goes to memory/decisions.md.
- If a mistake is made and recovered from, it goes to memory/mistakes.md.
- If a reusable pattern is discovered, it goes to memory/patterns.md.

Nothing happens silently. Every significant action is logged.

### 4. Complete

Claude runs the 11-step end-of-task sequence (see atlas/commands.md, `/task complete`). This produces:

- outcome.md in the task folder
- A checkpoint file in checkpoints/pending/
- Updated status and memory files

### 5. Checkpoint

The human reviews. Claude presents the agreement side by side with the outcome. The human can approve, request revisions, or reject.

Only the human moves the checkpoint from pending/ to passed/. Claude never does this.

---

## Phase Lifecycle

### 1. Plan

Claude breaks the phase into tasks using `/plan-phase`. Each task gets a spec with description, scope, acceptance criteria, and dependencies. Dependencies determine execution order.

### 2. Execute Tasks

Tasks are executed in dependency order. Tasks with no dependencies on each other can run in parallel (in team mode, on separate workstreams). Each task goes through the full task lifecycle.

### 3. Checkpoint

After all tasks are complete and all checkpoints are approved, the phase is ready for its gate.

### 4. Complete

Claude runs `/complete-phase`, which:
- Verifies all task checkpoints are in passed/.
- Scans for skills to promote (archive to active).
- Updates memory with phase-level patterns.
- Creates a phase-level checkpoint.
- Generates a gap report for the next phase.

---

## Skill Lifecycle

Skills are reusable patterns, conventions, or techniques discovered during work.

### 1. Identify

During a task, Claude recognizes a pattern that could be reused. Examples: a testing convention, an error handling approach, a component structure, a deployment pattern.

### 2. Create

Claude proposes the skill. The human approves. The skill is created in skills/archive/ with a clear description, usage instructions, examples, and tags.

All new skills start in archive. They are not yet proven.

### 3. Use

Claude references the skill during subsequent tasks. Each use is noted in the task's outcome.md.

### 4. Archive

The skill stays in archive until it has proven its value.

### 5. Promote

During `/complete-phase`, Claude scans for skills that were used in 3 or more tasks during the phase. These are proposed for promotion to skills/active/. The human approves.

Active skills are loaded by default during context routing. Archive skills are loaded only when specifically relevant.

---

## Drift Lifecycle

Drift is any deviation from the agreed plan. It is not a failure -- it is reality. But it must be documented.

### 1. Detect

During implementation, Claude recognizes that the actual work differs from the agreement. This could be: a different file was needed, an additional dependency was required, the scope was larger than estimated, the approach changed.

### 2. Document

Claude immediately logs the drift in status/drift.md using `/task drift`. The entry includes: what deviated, why, and the impact. The task's agreement.md gets a drift appendix (original terms are never modified).

### 3. Fix

If the drift can be resolved within the current task, Claude fixes it and notes the resolution. If it cannot, it becomes a blocker or a gap.

### 4. Log

The drift record persists. It is visible during checkpoint review. Over time, drift patterns reveal estimation problems, architecture issues, or unclear requirements.

---

## Memory Lifecycle

Memory is the project's accumulated knowledge. It grows with every task.

### 1. Accumulate

Three memory files grow throughout the project:
- **decisions.md** -- Every architectural or pattern decision, with date and rationale.
- **mistakes.md** -- Every mistake made and recovered from, with what was learned.
- **patterns.md** -- Every reusable approach discovered, with when to use it.

Claude writes to these files during `/task complete`. Entries are dated and tagged with the task that produced them.

### 2. Surface Patterns

During `/complete-phase`, Claude scans memory for patterns that emerged across multiple tasks. These become phase-level insights in patterns.md.

### 3. Improve

Memory files are consulted during task planning and execution. Claude reads relevant entries to avoid repeating mistakes and to apply proven patterns. The project gets better as it goes.

---

## Pre-Task Agreement

The agreement is the most important artifact in Atlas. Here is how it works.

### What It Contains

| Section | Purpose |
|---------|---------|
| What will be built | Specific, concrete description. Not vague. Not aspirational. |
| Files to create or modify | Exact paths. The human knows what will be touched. |
| Tests to write | What will be tested and how. |
| Acceptance criteria | Measurable conditions. "It works" is not a criterion. |
| Estimated scope | Small (< 1 hour), Medium (1-3 hours), Large (3+ hours). |
| Risks | What could go wrong and what the mitigation is. |
| Skills to use | Which existing skills will be applied. |

### Why It Matters

Without an agreement:
- The human does not know what Claude is about to do.
- There is no baseline to measure deviation against.
- Checkpoints have nothing to compare the outcome to.
- Drift is invisible because there is no plan to drift from.

The agreement takes minutes. The clarity it provides saves hours.

### The Human's Role

Read the agreement. Think about whether the scope is right, the files make sense, and the acceptance criteria are sufficient. Approve if yes. Ask for changes if no.

Do not approve without reading. The agreement is only valuable if both sides understand it.

---

## Checkpoint Review

The checkpoint is the human's verification step. Here is how to walk through it.

### What You See

Claude presents:
1. **Agreement summary** -- What was supposed to be built.
2. **Outcome summary** -- What was actually built.
3. **Side-by-side comparison** -- Agreement parameters vs actual outcome.
4. **Files changed** -- Every file created or modified, with a brief note.
5. **Tests** -- What was tested and the results.
6. **Deviations** -- Any drift from the agreement, highlighted.

### What You Do

1. Read the comparison. Does the outcome match the agreement?
2. Check the deviations. Are they acceptable?
3. Glance at the files changed. Do they make sense?
4. Record your observations (optional but valuable).
5. Verdict: **approve**, **revisions needed**, or **reject**.

### Verdicts

- **Approve**: You are satisfied. Move the checkpoint file from pending/ to passed/. Claude proceeds.
- **Revisions needed**: Something needs to change. Describe what. Claude reopens the task and addresses the feedback.
- **Reject**: The task is fundamentally wrong. Claude marks it as blocked. You discuss what went wrong before trying again.

---

### The Integrity Contract

Claude Atlas enforces a strict separation between requirements and implementation:

**Requirements** are defined in `agreement.md` (checkpoint parameters) and `test-spec.md` (test criteria). They are written BEFORE implementation begins and locked after approval.

**Implementation** is the code that must satisfy those requirements.

**The direction is always: fix the implementation to match the requirements.** Never adjust requirements to match a broken implementation. This is the single most important rule in the system.

Why this matters: Claude's instinct is to deliver a clean result. If reality is messy, Claude will try to clean up the report rather than report the mess. Atlas fights this by:
1. Locking agreements after approval
2. Running test integrity hooks that detect modifications to test files
3. Asking explicit criteria integrity questions during drift interrogation
4. Requiring human review of every checkpoint — the human sees the running program, not just Claude's report

If a task genuinely cannot meet its agreed criteria, the correct action is:
1. Document the gap in `drift.md` with CRITICAL severity
2. Report it honestly in `checkpoint.md` self-validation
3. Let the human decide: revise the implementation, revise the criteria (with documented justification), or accept the gap

---

## What the Human Does vs What Claude Does

| Step | Human | Claude |
|------|-------|--------|
| Project definition | Answers questions | Asks questions, fills files |
| Preview approval | Reviews and approves | Generates the preview |
| Phase planning | Reviews task list | Breaks phase into tasks |
| Agreement review | Reads and approves | Creates the agreement |
| Implementation | Observes (or does other work) | Writes code |
| Drift detection | Informed via drift log | Detects and logs immediately |
| Checkpoint review | Reviews and verdicts | Creates the checkpoint |
| Moving checkpoint to passed/ | Does this manually | Never does this |
| Skill approval | Approves creation and promotion | Proposes and creates |
| Phase gate | Reviews phase checkpoint | Runs the gate process |
| Architecture decisions | Makes the decision | Documents it |
| Adding dependencies | Makes the decision | Documents it |

The pattern is clear: Claude proposes, creates, documents. The human reviews, decides, approves.

---

## Team Mode Workflow Additions

When more than one developer is working on the project, team mode adds coordination.

### Workstream Check

Before starting a task, Claude checks team/workstreams.md to verify:
- The task is assigned to the current developer's workstream.
- No other workstream is touching the same files.
- No sync point is pending that should be resolved first.

### Collision Detection

During `/plan-phase`, Claude analyzes which tasks touch which files. Tasks that touch the same files are flagged as collision risks and are never assigned to parallel workstreams.

### Sync Points

After completing a task that affects shared modules, Claude logs a sync point in team/sync-log.md. Other workstreams see this at their next session start and can adjust accordingly.

### Workstream Context

Each developer's Claude session loads only their workstream's context. This keeps sessions focused and prevents context pollution from unrelated work.
