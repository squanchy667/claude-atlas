# Commands Reference

This is the single source of truth for every Atlas command. There are 9 commands. Each one has a defined purpose, sequence, and set of files it touches.

---

## 1. /atlas-init

**Purpose**: Create the Atlas folder structure from the template.

**Syntax**: `/atlas-init`

**When to use**: Once, at the very beginning of a new project.

**Sequence**:
1. Verify current directory is a git repository.
2. Create all directories: project/, phases/, tasks/, checkpoints/pending/, checkpoints/passed/, skills/foundation/, skills/active/, skills/archive/, skills/imported/, memory/, status/, team/, hooks/, atlas/.
3. Create all template files with headers and empty sections.
4. Create CLAUDE.md with the agent protocol.
5. Create INDEX.md with the switchboard.
6. Report what was created.

**Files written**: CLAUDE.md, INDEX.md, all directory structure and template files.

**Files read**: None.

**Chains into**: `/atlas-setup`

**Human summary**: "Atlas structure created. Run /atlas-setup to define your project."

---

## 2. /atlas-setup

**Purpose**: Guided project definition conversation. Fills all spec files based on human answers.

**Syntax**: `/atlas-setup`

**When to use**: After `/atlas-init`. Can be re-run to fill gaps.

**Sequence**:
1. Ask project identity: name, type, description.
2. Ask tech stack with rationale.
3. Ask team size. If > 1, activate team mode.
4. Ask success criteria and hard failure conditions.
5. Ask for rough phase outline.
6. Ask about known risks.
7. Fill project/overview.md with identity and criteria.
8. Fill project/architecture.md with tech stack and high-level design.
9. Fill project/data-model.md (content or placeholder).
10. Fill project/integrations.md (content or placeholder).
11. Create foundation skills in skills/foundation/ based on project type.
12. Create phase plan files in phases/phase-N/.
13. Fill CLAUDE.md project details section.
14. Update INDEX.md project state.
15. Initialize status/progress.md with phase list.
16. Convert known risks to gap entries in atlas/gaps.md.
17. Generate gap report (unanswered questions, assumptions).
18. Offer `/atlas-preview` to review everything before execution.

**Files written**: project/overview.md, project/architecture.md, project/data-model.md, project/integrations.md, phases/phase-N/plan.md, skills/foundation/*.md, skills/INDEX.md, atlas/gaps.md, CLAUDE.md, INDEX.md, status/progress.md.

**Files read**: Existing versions of all above files (to detect what is already filled).

**Chains into**: Offers `/atlas-preview` (the final step of setup).

**Human summary**: "Project defined. Review the preview and approve to proceed."

---

## 3. /atlas-run

**Purpose**: Execute the project plan. The main execution loop.

**Syntax**: `/atlas-run [--mode]`

**Modes**:
- `--full-permission` -- Autopilot. Claude executes tasks without pausing, creates checkpoints for later review.
- `--supervised` -- Pauses at every checkpoint gate for human review before proceeding.
- `--full-permission --report-only` -- Dry run. Plans tasks and reports what would happen without writing code.

**When to use**: After setup preview is approved.

**Prerequisite**: Setup must be complete and preview must be approved.

**Sequence**:
1. Read INDEX.md to determine current state.
2. If no phase is planned, run `/plan-phase` for the next phase.
3. For each task in the current phase (respecting dependency order):
   a. Run `/task plan` to create the agreement.
   b. In supervised mode: pause for human approval of agreement.
   c. Run `/task start` to load context.
   d. Execute the task (write code in the project repo).
   e. Run `/task complete` to write outcome and checkpoint.
   f. In supervised mode: pause for human checkpoint review.
4. When all tasks in the phase are done, run `/complete-phase`.
5. Loop to step 2 for the next phase.

**Files read**: INDEX.md, status/progress.md, all task files for current phase.

**Files written**: Via sub-commands (/plan-phase, /task, /complete-phase).

**Chains into**: `/plan-phase`, `/task`, `/checkpoint`, `/complete-phase` (all internally).

**Human summary**: Reports progress after each task and at phase boundaries.

---

## 4. /plan-phase

**Purpose**: Break a phase into concrete tasks with dependencies, risks, and skills.

**Syntax**: `/plan-phase [N]`

**When to use**: Before starting execution of phase N.

**Sequence**:
1. Read phases/phase-N/plan.md for the phase theme and scope.
2. Read project/architecture.md for system context.
3. Read memory/decisions.md for relevant past decisions.
4. Read atlas/gaps.md for open gaps that affect this phase.
5. Break the phase into tasks. Each task gets:
   - A task folder: tasks/phase-N/task-M/
   - A task spec: tasks/phase-N/task-M/task.md (description, scope, acceptance criteria, dependencies)
6. Identify dependencies between tasks.
7. Identify risks specific to this phase.
8. Check if foundation skills exist for the task types. Create new ones if needed (with human approval).
9. In team mode: analyze which tasks can run in parallel across workstreams and identify collision risks (shared files, shared modules).
10. Update phases/phase-N/plan.md with the task list and dependency graph.
11. Update status/progress.md.

**Files read**: phases/phase-N/plan.md, project/architecture.md, memory/decisions.md, atlas/gaps.md, skills/INDEX.md.

**Files written**: tasks/phase-N/task-M/task.md (one per task), phases/phase-N/plan.md (updated), status/progress.md.

**Chains into**: `/task plan` for each task (when invoked by /atlas-run).

**Human summary**: "Phase N planned: M tasks, K parallel tracks, J risks identified."

---

## 5. /task

**Purpose**: Unified task lifecycle command. Plan, start, complete, or flag drift on a task.

**Syntax**: `/task [phase-N] [task-M] [action]`

**Actions**:

### /task plan
Create the pre-task agreement.

1. Read tasks/phase-N/task-M/task.md for the task spec.
2. Read skills/INDEX.md for relevant skills.
3. Read memory/decisions.md for relevant past decisions.
4. Read project/architecture.md if the task touches structure.
5. Write tasks/phase-N/task-M/agreement.md with:
   - What will be built (specific, concrete).
   - Files that will be created or modified.
   - Tests that will be written.
   - Acceptance criteria (measurable).
   - Estimated scope (small / medium / large).
   - Risks and mitigation.
   - Skills to be used.
6. Present the agreement to the human for approval.
7. If skills are needed that do not exist, propose `/skill create` (human must approve).

### /task start
Load context and begin work.

1. Verify agreement.md exists and is approved.
2. Follow INDEX.md routing to load the right files.
3. Load relevant skills from skills/active/ and skills/foundation/.
4. State what you are about to build and which files you loaded.
5. Begin implementation.

### /task complete
End-of-task sequence. This is an 11-step process.

1. Verify all acceptance criteria from agreement.md are met.
2. Run tests. All must pass.
3. Write tasks/phase-N/task-M/outcome.md with:
   - What was built.
   - Files created or modified (full paths).
   - Tests added (full paths).
   - Deviations from agreement (if any).
   - Skills discovered or used.
   - Decisions made (with rationale).
4. If any deviations occurred, log them in status/drift.md.
5. If any decisions were made, log them in memory/decisions.md.
6. If any mistakes were made and recovered from, log them in memory/mistakes.md.
7. If any reusable patterns were discovered, log them in memory/patterns.md.
8. If any new skills were created, update skills/INDEX.md.
9. Create checkpoints/pending/phase-N-task-M.md with:
   - Task summary.
   - Agreement parameters vs actual outcome (side by side).
   - Files for review.
10. Update status/progress.md with task status.
11. Update INDEX.md project state.

### /task drift
Flag a deviation immediately.

1. Write an entry in status/drift.md with:
   - Task reference.
   - What deviated and why.
   - Impact assessment.
   - Whether it was resolved or still open.
2. Update the task's agreement.md with a drift note (do not modify the original terms -- append a drift section).

**Files read**: Varies by action. See individual action sequences above.

**Files written**: Varies by action. See individual action sequences above.

**Chains into**: `/task plan` may chain `/skill create`. `/task complete` creates the checkpoint.

**Human summary**: Varies by action. Plan: "Agreement ready for review." Start: "Context loaded, beginning work." Complete: "Task done, checkpoint created for review." Drift: "Deviation logged."

---

## 6. /checkpoint

**Purpose**: Human review walkthrough. Structured comparison of agreement to outcome.

**Syntax**: `/checkpoint [phase-N] [task-M]`

**When to use**: After `/task complete` creates a pending checkpoint.

**Sequence**:
1. Read checkpoints/pending/phase-N-task-M.md.
2. Read tasks/phase-N/task-M/agreement.md.
3. Read tasks/phase-N/task-M/outcome.md.
4. Present to the human:
   - Agreement parameters (left column) vs actual outcome (right column).
   - Files changed with brief description.
   - Tests added.
   - Deviations (highlighted if any).
   - Drift entries (if any).
5. Ask the human to record observations.
6. Ask for verdict: **approve**, **revisions needed**, or **reject**.
   - **Approve**: Human moves the checkpoint from pending/ to passed/. Claude does not do this.
   - **Revisions needed**: Claude logs the required changes, reopens the task.
   - **Reject**: Claude logs the reason, marks the task as blocked, and stops.

**Files read**: checkpoints/pending/phase-N-task-M.md, tasks/phase-N/task-M/agreement.md, tasks/phase-N/task-M/outcome.md, status/drift.md (for relevant entries).

**Files written**: Human observations are appended to the checkpoint file. If revisions needed: task status updated in status/progress.md.

**Chains into**: If approved, the next task. If revisions needed, `/task start` again.

**Human summary**: "Checkpoint reviewed. [Approved / Revisions needed / Rejected]."

---

## 7. /complete-phase

**Purpose**: Phase gate. Verify everything is done, promote skills, update memory, prepare for next phase.

**Syntax**: `/complete-phase [N]`

**When to use**: After all tasks in phase N have approved checkpoints.

**Sequence**:
1. Verify all tasks in phase N have checkpoints in passed/.
2. If any checkpoints are still in pending/, stop and report.
3. Scan skills/archive/ for skills used in 3+ tasks this phase -- propose promotion to active/.
4. Scan memory/ for patterns that emerged across tasks.
5. Update memory/patterns.md with phase-level insights.
6. Create a phase-level checkpoint in checkpoints/pending/phase-N-complete.md with:
   - Phase summary.
   - Tasks completed.
   - Skills promoted.
   - Gaps resolved.
   - Gaps opened.
7. Generate a gap report for the next phase.
8. Update status/progress.md.
9. Update INDEX.md.

**Files read**: All checkpoints/passed/phase-N-*.md, skills/INDEX.md, skills/archive/*.md, memory/*.md, atlas/gaps.md, status/progress.md.

**Files written**: checkpoints/pending/phase-N-complete.md, memory/patterns.md, skills/active/ (promoted skills), skills/INDEX.md, atlas/gaps.md, status/progress.md, INDEX.md.

**Chains into**: `/plan-phase` for the next phase (when invoked by /atlas-run).

**Human summary**: "Phase N complete. K skills promoted, J gaps resolved, M gaps opened for next phase."

---

## 8. /skill

**Purpose**: Manage reusable skills (patterns, conventions, techniques).

**Syntax**: `/skill [action] [name]`

**Actions**:

### /skill create [name]
Create a new skill.

1. Check skills/active/ and skills/archive/ for duplicates. If a similar skill exists, stop and report.
2. Create the skill file in skills/archive/ (all new skills start in archive).
3. Skill file contains: name, description, when to use, the pattern/convention/technique, examples, tags.
4. Update skills/INDEX.md with the new entry.

### /skill promote [name]
Move a skill from archive/ to active/.

1. Verify the skill exists in archive/.
2. Move it to active/.
3. Update skills/INDEX.md.

### /skill scan
Find relevant skills for the current task.

1. Read the current task spec.
2. Read skills/INDEX.md.
3. Match task requirements against skill tags and descriptions.
4. Report which skills are relevant, with brief descriptions.

### /skill import [pack/name]
Import a skill from the marketplace into your project.

1. Parse the argument: `pack/name` imports a single skill, `pack` imports the whole pack.
2. Verify the skill(s) exist in `marketplace/packs/`.
3. Check `skills/active/` and `skills/foundation/` for duplicates; warn if similar skills exist.
4. Copy skill file(s) to `skills/imported/[name]/SKILL.md`.
5. Update `skills/INDEX.md` with the imported skill(s).
6. Report: "Imported N skill(s) from [pack]."

### /skill publish [name]
Export a project skill to the marketplace for sharing.

1. Find the skill in `skills/active/`, `skills/foundation/`, or `skills/archive/`.
2. Validate it has all required sections (What It Solves, Approach, Steps, Example, Gotchas).
3. Create a portable package in `marketplace/community/[name]/` with the skill file and source metadata.
4. Update `marketplace/INDEX.md`.
5. Report: "Skill published to marketplace/community/."

### /skill browse [pack?]
List available marketplace skills.

1. Read `marketplace/INDEX.md`.
2. If no pack specified: display all packs with skill counts, then all skills by pack.
3. If pack specified: display that pack's skills with summaries.
4. End with: "To import a skill: `/skill import [pack/name]`"

**Files read**: skills/INDEX.md, skills/active/*.md, skills/archive/*.md, current task spec (for scan), marketplace/INDEX.md (for browse/import), marketplace/packs/ (for import).

**Files written**: skills/archive/{name}.md (create), skills/active/{name}.md (promote), skills/INDEX.md, skills/imported/{name}/SKILL.md (import), marketplace/community/{name}/ (publish), marketplace/INDEX.md (publish).

**Chains into**: Nothing.

**Human summary**: Create: "Skill created in archive." Promote: "Skill promoted to active." Scan: "Found N relevant skills." Import: "Imported N skill(s) from pack." Publish: "Skill published to marketplace." Browse: "Marketplace listing displayed."

---

## 9. /status

**Purpose**: Current project state at a glance.

**Syntax**: `/status`

**When to use**: Anytime. Quick health check.

**Sequence**:
1. Read INDEX.md for project state.
2. Read status/progress.md for task-level progress.
3. Read status/blockers.md for active blockers.
4. Read status/drift.md for unresolved deviations.
5. Read atlas/gaps.md for open gaps.
6. Present:
   - Current phase and task.
   - Tasks completed / total.
   - Active blockers (count and brief).
   - Unresolved drift (count and brief).
   - Open gaps (count).
   - Overall health assessment: green (on track), yellow (minor issues), red (blocked or drifting).

**Files read**: INDEX.md, status/progress.md, status/blockers.md, status/drift.md, atlas/gaps.md.

**Files written**: None.

**Chains into**: Nothing.

**Human summary**: One-paragraph status with health color.

---

## Command Chaining Rules

Commands can chain into other commands. These are the valid chains:

| From | To | Condition |
|------|----|-----------|
| `/atlas-init` | `/atlas-setup` | Always (suggested, not automatic) |
| `/atlas-setup` | Preview step | Always (offered at end of setup) |
| `/atlas-run` | `/plan-phase` | When no phase is planned |
| `/atlas-run` | `/task plan` | For each task in phase |
| `/atlas-run` | `/task complete` | After task implementation |
| `/atlas-run` | `/complete-phase` | When all tasks done |
| `/plan-phase` | `/task plan` | When invoked by /atlas-run |
| `/task plan` | `/skill create` | When needed skill does not exist (human approval required) |
| `/task complete` | `/checkpoint` | Always (checkpoint created) |
| `/complete-phase` | `/plan-phase` | For next phase (when invoked by /atlas-run) |

Commands never chain silently. Every chain is reported to the human.
