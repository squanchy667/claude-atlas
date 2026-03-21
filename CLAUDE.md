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

8. **Never modify tests, weaken assertions, or adjust acceptance criteria to make a failing task appear to pass.** Tests and agreements define requirements. If reality doesn't match, that is drift — document it and flag it. Do not adjust the target. See "Integrity Rules" below.

9. **Never create a skill without checking skills/active/ and skills/archive/ first.** Duplicate skills create confusion. Check before creating.

10. **If unsure: stop, ask, document.** Write what you are unsure about in the current task's outcome.md or in atlas/gaps.md. Then ask the human. Never guess on ambiguous requirements.

---

## Integrity Rules — Zero Tolerance

These rules exist because Claude's natural instinct is to make things work — even if that means quietly adjusting the definition of "working." This section exists to block that instinct.

### Tests Are Requirements
- Tests define what the code must do. The code must pass the tests as written.
- You may NOT modify a pre-existing test to make it pass. Ever.
- You may NOT weaken an assertion (e.g., changing `.toBe(5)` to `.toBeDefined()`).
- You may NOT delete a test that is failing.
- You may NOT skip a test (`it.skip`, `xit`, `@skip`) to hide a failure.
- If a test is genuinely wrong (tests the wrong behavior), flag it as CRITICAL drift and get human approval before touching it.

### Agreements Are Locked
- Once `agreement.md` has status APPROVED, its checkpoint parameters are frozen.
- You may NOT modify checkpoint parameters after approval to match a different outcome.
- You may NOT weaken acceptance criteria (e.g., changing "responds in under 100ms" to "responds successfully").
- You may NOT add qualifiers to pass criteria (e.g., changing "all tests pass" to "all tests pass except...").
- If the implementation cannot meet the agreed parameters, that is drift — document it, do not adjust the target.

### Outcomes Must Be Honest
- `outcome.md` describes what was ACTUALLY built, not what was supposed to be built.
- If something doesn't work, say it doesn't work. Do not describe a partial result as complete.
- If tests fail, report the failures. Do not omit them.
- `checkpoint.md` self-validation must reflect reality. "Honest uncertainty" means listing what you know is wrong or incomplete.

### The Principle
The goal is never to make a task LOOK complete. The goal is to make a task BE complete. If it isn't complete, the system is designed to handle that — revisions exist for a reason. Faking completion is worse than flagging incompleteness.

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

[PROJECT_NAME: DogPack Roguelite]
[PROJECT_TYPE: 2D Game (Unity)]
[PROJECT_DESCRIPTION: A 2D top-down roguelite where players control dog characters through procedurally generated dungeon runs with combat, dodge-rolling, and a home base (The Kennel) for managing and upgrading their pack of rescued dogs between runs.]
[TECH_STACK: Unity 2022.3 LTS, C#, 2D URP, Singleton-Events-ScriptableObject pattern, Unity Input System, Unity Animator, Canvas UI, 2D Tilemap]
[REPO_PATH: /Users/ofek/Projects/Claude/AtlasTest/CultRoguelite/]
[TEAM_SIZE: 1 (solo)]
[CURRENT_PHASE: 6 (pending planning)]
[TOTAL_PHASES: 7]

## Phase Overview

| Phase | Name | Focus |
|-------|------|-------|
| 1 | Foundation | Project setup, input, player controller, camera, test room |
| 2 | Combat Core | Weapons, damage, health, enemy AI, hit feedback |
| 3 | Dungeon Generation | Pyramid DAG floors, room prefabs, path choice, minimap |
| 4 | Characters & Enemies | 2 characters (Malinois, Vizsla), 6 enemies, 3 bosses |
| 5 | The Kennel (Base) | Home base, dog management, upgrades, resource economy |
| 6 | Co-op | 2-player local, shared camera, enemy scaling, revive |
| 7 | Polish & UI | Menus, audio, particles, difficulty scaling, game feel |

## Project Conventions

- Architecture: Singleton + Events + ScriptableObject trinity pattern
- All game data in ScriptableObjects (no magic numbers in MonoBehaviours)
- Systems communicate via `GameEvents` static event bus
- Combat parameters tunable via AnimationCurves
- Folder structure: `Scripts/`, `ScriptableObjects/`, `Prefabs/`, `Scenes/`, `Art/`, `Audio/`, `Animations/`, `Editor/`, `Settings/`
- Branch naming: `feat/TXXX-task-name`
- Commit format: `[Phase N] TXXX: Brief description`
