# Claude Atlas — Getting Started Guide

This guide walks you through everything: your first project, the full development loop, how skills work, and where every file lives. Read it once, then use the quick reference at the bottom.

---

## 1. Your First Project

### Clone and launch

```bash
# Clone Atlas
git clone https://github.com/squanchy667/claude-atlas.git my-project-docs
cd my-project-docs

# Open Claude Code
claude

# Run setup — this starts a guided conversation
/atlas-setup
```

### What happens during `/atlas-setup`

Atlas asks you 11 questions, one at a time:

1. **Project name** — what is this thing called?
2. **Description** — one sentence: what does it do?
3. **Problem** — what pain does it solve, and for whom?
4. **Stack** — languages, frameworks, databases, infrastructure
5. **Team size** — how many developers?
6. **Success criteria** — what does "done" look like? Be specific.
7. **Failure conditions** — what would make this project a failure?
8. **Non-scope** — what are you explicitly NOT building?
9. **Phases** — high-level milestones (Atlas proposes, you adjust)
10. **Risks** — what could go wrong? Technical debt, unknowns, dependencies.
11. **Integrations** — external services, APIs, third-party tools

If you answer more than 1 developer for team size, **team mode activates**. Atlas asks follow-up questions about each developer: name, strengths, availability, and preferred areas. This drives task assignment later.

As you answer, Claude fills your project files in real-time. You are not filling out a form — you are having a conversation, and Atlas is writing the documentation as you talk.

At the end, Atlas presents a **full preview** of everything it created. This is your cheapest correction point. Read it carefully. Adjust anything that looks wrong. When you approve, the files are committed and your project is initialized.

### Files created by setup

| File | What it contains |
|------|-----------------|
| `project/overview.md` | Vision, problem, audience, success criteria |
| `project/architecture.md` | Stack decisions, module boundaries, data flow |
| `project/data-model.md` | Entities, fields, relationships |
| `project/integrations.md` | External services, env vars, API contracts |
| `phases/*` | Phase definitions with goals and exit criteria |
| `skills/foundation/*` | Stack-specific skills derived from your answers |
| `CLAUDE.md` | Agent protocol — how Claude should behave on this project |
| `INDEX.md` | Switchboard — routes Claude to the right files |
| `status/progress.md` | Current state tracker |
| `atlas/gaps.md` | Known unknowns — things Atlas noticed but could not resolve |

Once setup completes, you are ready to build.

---

## 2. The Development Loop

Here is the complete command sequence for building one phase:

```
/plan-phase 1                      # Break phase into tasks
/task phase-1 task-1 plan          # Pre-task agreement (Claude proposes, you approve)
/task phase-1 task-1 start         # Load context, confirm ready
# ... Claude implements the task ...
/task phase-1 task-1 complete      # Outcome, drift check, memory update, commit
/checkpoint phase-1 task-1         # You review — approve, revise, or reject
/status                            # Quick check: where are we?
# ... repeat for each task ...
/complete-phase 1                  # Phase gate: verify, promote skills, gap report
```

### What happens at each step

**`/plan-phase N`** — Atlas reads the phase definition, your architecture, and any active skills. It decomposes the phase into concrete tasks with dependencies, deliverables, and test criteria. You review the task list before anything is locked.

**`/task phase-N task-M plan`** — Claude proposes a pre-task agreement: what it will build, which files it will touch, which skills it will use, and what the acceptance criteria are. You approve, revise, or reject. Once approved, the agreement is locked and becomes the contract for this task.

**`/task phase-N task-M start`** — Atlas loads the task context: agreement, relevant skills, architecture docs, and any outcomes from dependency tasks. Claude confirms it understands the scope and is ready to begin. Then it starts building.

**`/task phase-N task-M complete`** — Claude writes the outcome (what was actually built), runs a drift check against the agreement, updates project memory with any new patterns or decisions, and prepares a commit.

**`/checkpoint phase-N task-M`** — Claude self-validates the task against its test spec and agreement. Then you review. Three options: approve (task is sealed and done), revise (Claude fixes specific issues), or reject (task goes back to planning).

**`/status`** — Shows the current phase, active task, completion percentage, any blockers, and overall project health. Quick situational awareness without reading multiple files.

**`/complete-phase N`** — Phase-level gate. Atlas verifies all tasks passed their checkpoints, scans the skill archive for promotion candidates, generates a gap report for anything unresolved, and marks the phase as complete. After this, the next phase is ready for planning.

### Run modes

Atlas supports three levels of automation:

**`/atlas-run --supervised`** — Autopilot with pauses. Atlas drives the entire loop but stops at three points: pre-task agreements (so you can approve the plan), checkpoints (so you can review the work), and phase gates (so you can decide whether to proceed). This is the recommended mode for your first project. You stay in control without doing the mechanical work.

**`/atlas-run --full-permission`** — Full autopilot. Atlas drives from phase planning through phase completion with minimal interruptions. It makes its own decisions at agreements and checkpoints. Use this when you trust the setup and want maximum speed.

**`/atlas-run --full-permission --report-only`** — Full autopilot with a decision log. Same as full-permission, but every decision Atlas makes (approvals, skill selections, drift resolutions) is logged to a report. You review the report after the phase completes instead of during. Good for overnight runs or background execution.

---

## 3. Understanding Skills

### What is a skill?

A skill is a reusable knowledge unit specific to your project. It is not a generic tutorial. It is a concrete, opinionated guide for handling a specific pattern in YOUR codebase.

For example, a skill might document: "In this project, all API errors go through `lib/errors.ts`, use the `AppError` class, and must include a `code` field that maps to the error catalog in `docs/errors.md`." That is a skill. It tells Claude exactly how to handle errors in this project, not how error handling works in general.

Skills make Claude smarter about your project over time. The first task is the hardest. By the tenth task, Claude has accumulated enough skills that it rarely needs guidance.

### Skill tiers

| Tier | Location | How it gets there |
|------|----------|-------------------|
| Foundation | `skills/foundation/` | Created during `/atlas-setup` based on your stack |
| Active | `skills/active/` | Promoted from archive after proving useful across tasks |
| Archive | `skills/archive/phase-N-task-N/` | Task-level skills moved here after task completion |
| Imported | `skills/imported/` | Pulled from the marketplace |

### The skill lifecycle

1. **Created** — A skill is born in one of three ways: during setup (foundation skills derived from your stack), during a task (task-level skills for patterns discovered while building), or imported from the marketplace.

2. **Used** — When a task starts, its `skills.md` manifest lists which skills are loaded. Claude reads these before writing any code.

3. **Archived** — When a task completes, its task-level skills move to `skills/archive/phase-N-task-N/`. They are searchable but not automatically loaded for future tasks.

4. **Promoted** — At phase completion, Atlas scans the archive. If a skill was referenced by multiple tasks, or if it encodes a pattern that will clearly recur, Atlas proposes promoting it.

5. **Active** — Promoted skills live in `skills/active/` and are loaded for every future task. This is the permanent toolbox.

### Creating a skill

```
/skill create error-handling-pattern
```

Claude asks three questions: What problem does this skill solve? What category does it belong to? Is it a scaffold-only skill (used once during setup) or a permanent pattern?

This creates a `SKILL.md` file following the standard template with sections for context, rules, examples, and anti-patterns.

### Importing from the marketplace

```
/skill browse                              # See all available packs and skills
/skill browse web-app                      # See just the web-app pack
/skill import general/testing-strategy     # Import one skill
/skill import api-service                  # Import entire pack (5 skills)
```

Imported skills land in `skills/imported/[name]/SKILL.md`. They are available immediately for the next task.

### Publishing your own skills

```
/skill publish my-custom-pattern
```

This packages the skill from `skills/active/` into `marketplace/community/` for sharing across projects or with other developers.

### Available marketplace packs

| Pack | Count | What's inside |
|------|-------|--------------|
| general | 5 | git-workflow, testing-strategy, error-handling, code-review-checklist, documentation-patterns |
| web-app | 5 | component-architecture, state-management, api-integration, auth-flow, form-handling |
| api-service | 5 | rest-api-design, database-patterns, input-validation, middleware-design, logging-observability |
| cli-tool | 3 | argument-design, output-formatting, config-management |

---

## 4. Where Things Are Stored

```
my-project-docs/
├── CLAUDE.md                    # Agent protocol — Claude reads this first every session
├── INDEX.md                     # Switchboard — routes agents to the right files
├── GUIDE.md                     # This file
├── README.md                    # Project overview for GitHub
│
├── .claude/
│   ├── commands/                # The 9 slash commands that power everything
│   │   ├── atlas-init.md
│   │   ├── atlas-setup.md
│   │   ├── atlas-run.md
│   │   ├── plan-phase.md
│   │   ├── task.md              # Unified: plan, start, complete, drift
│   │   ├── checkpoint.md
│   │   ├── complete-phase.md
│   │   ├── skill.md             # Unified: create, promote, scan, import, publish, browse
│   │   └── status.md
│   └── settings.json            # Hook configurations (auto-wired)
│
├── atlas/                       # System documentation (how Atlas works)
│   ├── setup.md                 # Setup and configuration guide
│   ├── commands.md              # Full command reference
│   ├── workflow.md              # Development philosophy and process
│   └── gaps.md                  # Known unknowns — tracked and resolved
│
├── project/                     # YOUR project's definition (filled during /atlas-setup)
│   ├── overview.md              # What, why, for whom, success criteria
│   ├── architecture.md          # Stack, modules, rules, data flow
│   ├── data-model.md            # Entities, fields, relationships
│   └── integrations.md          # External services, dependencies, env vars
│
├── phases/                      # The roadmap
│   ├── INDEX.md                 # All phases with status
│   └── phase-N/
│       ├── phase.md             # Phase goal, deliverables, exit criteria
│       └── INDEX.md             # Task map for this phase
│
├── tasks/                       # Every unit of work
│   └── phase-N/
│       └── task-N/
│           ├── task.md          # What this task builds and why
│           ├── agreement.md     # Pre-task contract (LOCKED after approval)
│           ├── skills.md        # Which skills this task uses
│           ├── test-spec.md     # Pass criteria (written BEFORE code)
│           ├── tests/           # Actual test files
│           ├── outcome.md       # What was actually built (filled at completion)
│           ├── drift.md         # Every deviation from the plan
│           └── checkpoint.md    # Gate: Claude self-validates, human reviews
│
├── skills/                      # The growing toolbox
│   ├── INDEX.md                 # Searchable skill map
│   ├── foundation/              # Stack-specific skills (from setup)
│   ├── active/                  # Proven, promoted skills
│   ├── archive/                 # Task-level skills (searchable, not active)
│   └── imported/                # From the marketplace
│
├── marketplace/                 # Pre-built skill packs
│   ├── INDEX.md                 # Browse all available skills
│   ├── packs/                   # 4 packs, 18 skills
│   │   ├── general/
│   │   ├── web-app/
│   │   ├── api-service/
│   │   └── cli-tool/
│   └── community/               # Your published skills
│
├── hooks/                       # Automation scripts (auto-wired)
│   ├── file-tracker.sh          # Logs every file edit for drift detection
│   ├── scope-guard.sh           # Warns on out-of-scope edits
│   ├── session-end.sh           # Reminds to complete in-progress tasks
│   └── test-integrity.sh        # Warns on test file modifications
│
├── memory/                      # Project intelligence (grows over time)
│   ├── decisions.md             # Why things are the way they are
│   ├── mistakes.md              # What went wrong and how to avoid it
│   ├── patterns.md              # Proven solutions specific to this project
│   └── drift-log.md             # Cross-task drift patterns
│
├── checkpoints/                 # Phase-level gates
│   ├── template.md
│   ├── pending/                 # Awaiting human review
│   └── passed/                  # Approved — sealed, never modified
│
├── status/                      # Live project state
│   ├── progress.md              # Current phase, task, health
│   └── blockers.md              # What's blocked and why
│
├── team/                        # Team mode (activates when devs > 1)
│   ├── members.md               # Developer profiles
│   └── workstreams.md           # Task distribution, collision risks
│
└── future/                      # Planned features
    ├── team-mode.md             # Team mode details (built into v1)
    ├── skill-marketplace.md     # Marketplace roadmap
    └── dashboard.md             # Visual dashboard (planned)
```

### Key directories explained

**`project/`** — This is your project's identity. Everything here is filled during `/atlas-setup` and referenced by every task. If Claude makes a decision that contradicts something in `project/architecture.md`, that is a drift event.

**`tasks/`** — Every unit of work gets its own directory. The `agreement.md` file is the contract: once approved, it locks. The `outcome.md` file is the receipt: what was actually built. The `drift.md` file bridges the gap between the two.

**`skills/`** — The knowledge layer. Foundation skills are your starting toolkit. Active skills are your proven patterns. The archive is searchable history. Imported skills are community knowledge adapted to your project.

**`memory/`** — Long-term project intelligence. Decisions, mistakes, and patterns accumulate here across tasks and phases. This is what makes the tenth task faster than the first.

**`hooks/`** — Automation that runs in the background. File tracking catches undocumented changes. Scope guard warns when Claude edits files outside the task's declared scope. Test integrity warns if test files are modified after checkpoint approval.

---

## 5. Tips for Your First Project

**Start with `/atlas-run --supervised`.** It lets you see every step and approve at gates. You will understand the full workflow after one phase, and you can switch to full-permission for subsequent phases.

**Import skills early.** Run `/skill import general` right after setup. This gives you git workflow, testing strategy, and error handling patterns immediately. They cost nothing to have and save time on every task.

**Answer setup questions specifically.** "A productivity app" is vague. "A CLI that converts CSV to JSON with column mapping and custom delimiter support" is specific. Specificity drives everything downstream: better phase decomposition, better task scoping, better skills. Vague inputs produce vague plans.

**Review the preview carefully.** The post-setup preview is your cheapest correction point. Changing a phase definition here costs nothing. Changing it after three tasks are built against the old definition costs a lot. Read every section. Challenge anything that feels off.

**Do not fight the agreements.** If the pre-task agreement feels wrong, fix it before approving. Push back. Ask Claude to rethink the approach. Once you approve, the agreement becomes the contract for that task. Everything downstream — implementation, drift detection, checkpoints — is measured against it.

**Drift is not failure.** The `drift.md` file exists because reality diverges from plans. That is normal. A function that was supposed to return a string returns an object instead because the data model evolved. That is fine. What matters is that the drift is documented, not hidden. The system handles documented drift gracefully. Undocumented drift causes compounding confusion.

**Skills compound.** Your first project's skills become your second project's foundation. The more patterns you capture during your first build, the faster every future project goes. When Claude discovers a useful pattern, take 30 seconds to run `/skill create` and capture it.

---

## 6. Quick Reference

| I want to... | Run this |
|--------------|----------|
| Set up a new project | `/atlas-setup` |
| See where I am | `/status` |
| Plan the next phase | `/plan-phase N` |
| Start working on a task | `/task phase-N task-M plan` then `/task phase-N task-M start` |
| Finish a task | `/task phase-N task-M complete` |
| Review a task | `/checkpoint phase-N task-M` |
| Flag something went wrong | `/task phase-N task-M drift` |
| Complete a phase | `/complete-phase N` |
| Browse marketplace skills | `/skill browse` |
| Import a skill | `/skill import pack/name` |
| Create a custom skill | `/skill create name` |
| Publish a skill | `/skill publish name` |
| Run full autopilot | `/atlas-run --full-permission` |
| Run with checkpoints | `/atlas-run --supervised` |
