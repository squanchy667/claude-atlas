# Claude Atlas -- Agent Protocol

You are working inside a Claude Atlas project. Atlas is the operating system for this project: it holds the plan, the memory, the skills, and the rules. You follow this protocol at every session start and during every task.

---

## Session Start Protocol

Do this every time, in order. No exceptions.

1. Read this file (CLAUDE.md) completely.
2. Read INDEX.md to get current project state and your routing instructions.
3. Follow the routing instructions in INDEX.md to load exactly the files you need.
4. Do not read files you were not routed to. Context is expensive.
5. State what you are about to do and which files you loaded. Then begin.

---

## File Map

This is every file in the Atlas repo and when you read it.

### Always Read (Session Start)
| File | Purpose |
|------|---------|
| `CLAUDE.md` | This file. Agent protocol and rules. |
| `INDEX.md` | Switchboard. Routes you to the right files for your current task. |

### Read When Routed
| File | When |
|------|------|
| `project/overview.md` | Any task (background context). |
| `project/architecture.md` | Task touches system structure, new modules, data flow. |
| `project/data-model.md` | Task touches data, schemas, database. |
| `project/integrations.md` | Task touches external services, APIs, auth. |
| `phases/phase-N/plan.md` | Working on phase N. |
| `tasks/phase-N/task-N/task.md` | Working on a specific task. |
| `tasks/phase-N/task-N/agreement.md` | Before starting any task. Must exist and be approved. |
| `tasks/phase-N/task-N/outcome.md` | When completing a task. You write this. |
| `memory/decisions.md` | Task involves architectural or pattern decisions. |
| `memory/mistakes.md` | Complex task or unfamiliar territory. |
| `memory/patterns.md` | Looking for reusable approaches. |
| `skills/INDEX.md` | Finding tools and patterns for current task. |
| `skills/active/*.md` | Using a promoted skill. |
| `skills/foundation/*.md` | Using a project-type skill. |
| `status/progress.md` | Checking or updating project status. |
| `status/blockers.md` | Encountering or resolving a blocker. |
| `tasks/phase-N/task-N/drift.md` | Anything deviates from the agreed plan during a task. |
| `memory/drift-log.md` | Cross-task drift patterns and systemic issues. |
| `atlas/commands.md` | Understanding what a command does. |
| `atlas/workflow.md` | Understanding the development philosophy. |
| `atlas/gaps.md` | Checking or logging unknowns. |
| `atlas/setup.md` | During project initialization. |
| `checkpoints/pending/*.md` | Human review in progress. |
| `checkpoints/passed/*.md` | Reference only. Never modify. |
| `team/workstreams.md` | Team mode is active and you need coordination info. |
| `team/sync-log.md` | Team mode is active and you need sync history. |

---

## Decision Authority

| Decision | Authority |
|----------|-----------|
| Architectural changes | Human only |
| New dependencies | Human only |
| Phase scope changes | Human only |
| Moving checkpoint from pending/ to passed/ | Human only |
| Data model changes | Human only |
| Coding patterns within established rules | Claude |
| File naming within conventions | Claude |
| Updating outcome.md at task completion | Claude |
| Adding entries to drift.md | Claude (immediately, always) |
| Proposing new skills | Claude (propose only, human approves) |
| Updating memory files after task completion | Claude |
| Updating progress.md | Claude |

If a decision is not in this table, treat it as human-only.

---

## Non-Negotiables

These are hard rules. Violating any one of them is a session failure.

1. **Never skip INDEX.md at session start.** It tells you where you are and what to read. Without it you are guessing.

2. **Never make architectural decisions without documenting in memory/decisions.md.** Every structural choice gets a dated entry with rationale. No silent architecture.

3. **Never move a checkpoint from pending/ to passed/.** Only the human does this. You create the checkpoint file in pending/. The human reviews and moves it.

4. **Never modify files in checkpoints/passed/.** These are sealed records. They do not change after approval.

5. **Never fix something silently.** If the implementation drifts from the agreement, log it in status/drift.md immediately. Even if you fix it in the same session. The record matters.

6. **Never work on a task without an approved agreement.md.** The agreement is the contract. No agreement, no work. If the agreement does not exist, run `/task plan` first.

7. **Never proceed past a blocker without documenting in status/blockers.md.** If something blocks you, log it with impact and workaround attempts. Do not silently work around it.

8. **Never modify a pre-existing test to make it pass.** If a test fails, the code is wrong, not the test. If the test is genuinely wrong, flag it as drift and get human approval before changing it.

9. **Never create a skill without checking skills/active/ and skills/archive/ first.** Duplicate skills create confusion. Check before creating.

10. **If unsure: stop, ask, document.** Write what you are unsure about in the current task's outcome.md or in atlas/gaps.md. Then ask the human. Never guess on ambiguous requirements.

---

## Checkpoint Gate Process

At the end of every task, before marking it complete:

1. Write `tasks/phase-N/task-N/outcome.md` with: what was built, files changed, tests added, deviations from agreement.
2. Create a checkpoint file in `checkpoints/pending/phase-N-task-N.md` with: task summary, agreement parameters vs actual outcome, files for review.
3. Update `status/progress.md` with task status.
4. Update `INDEX.md` project state section.
5. If any drift occurred, verify it is logged in the task's `drift.md`.
6. Stop. The human reviews the checkpoint. You do not proceed to the next task until the checkpoint moves to passed/.

---

## Team Mode

> This section activates when the project has more than one developer.
> When inactive, ignore this section entirely.

[TEAM_MODE_STATUS: inactive]

When active:
- Read `team/workstreams.md` at session start to see who owns what.
- Check `team/sync-log.md` for recent decisions from other workstreams.
- Before starting a task, verify no other workstream is touching the same files.
- Log your file touches in `team/sync-log.md` when completing a task.
- Flag collision risks immediately in `status/blockers.md`.

---

## Project Details

> Filled by /atlas-setup. Do not edit manually.

[PROJECT_NAME: not configured]
[PROJECT_TYPE: not configured]
[PROJECT_DESCRIPTION: not configured]
[TECH_STACK: not configured]
[REPO_PATH: not configured]
[TEAM_SIZE: not configured]
[CURRENT_PHASE: not started]
[TOTAL_PHASES: not planned]
