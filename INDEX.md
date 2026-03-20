# Index -- Project Switchboard

Read this immediately after CLAUDE.md. It tells you where the project stands and routes you to exactly the files you need.

---

## Project State

> Auto-updated by hooks and commands. Do not edit manually.

| Field | Value |
|-------|-------|
| Project | DogPack Roguelite |
| Current Phase | 3 — Dungeon Generation (complete, approved) |
| Current Task | None — Phase 3 complete, ready for Phase 4 |
| Last Activity | 2026-03-20: Phase 3 final fixes approved. Walls/floors visible, floor colors distinct. Ready for Phase 4. |
| Health | Phases 1–3 complete. On track. |
| Blockers | None |
| Team Mode | Inactive |

---

## Agent Routing

You are an agent about to work on a task. Follow this algorithm to load your context. Read the minimum necessary -- never load files speculatively.

### Step 1: Always Read (3 files)

For any task in phase N, task M:

```
tasks/phase-N/task-M/task.md        -- What you are building
tasks/phase-N/task-M/agreement.md   -- The approved contract (must exist)
skills/INDEX.md                     -- Available tools and patterns
```

If `agreement.md` does not exist, stop. Run `/task plan` first.

### Step 2: Read If Task Touches Structure

If the task involves new modules, changes to system architecture, data flow changes, or new integration points:

```
project/architecture.md             -- System structure and boundaries
```

### Step 3: Read Relevant Decision History

If the task involves a domain where past decisions were made:

```
memory/decisions.md                 -- Scan for entries tagged with your domain
```

You do not need to read the entire file. Scan headings for relevance.

### Step 4: Read Available Skills

If the task is in a domain where reusable patterns might exist:

```
skills/INDEX.md                     -- Find skills tagged with your domain
skills/active/{relevant-skill}.md   -- Load the skill
skills/foundation/{relevant-skill}.md -- Load foundation skills for your project type
```

### Step 5: Read Mistake History (Complex Tasks Only)

If this is a complex task, touches unfamiliar territory, or has high risk:

```
memory/mistakes.md                  -- What went wrong before and how to avoid it
```

### Routing Summary

| Task Type | Files to Read |
|-----------|---------------|
| Simple implementation | task.md, agreement.md, skills/INDEX.md |
| Structural change | + project/architecture.md, memory/decisions.md |
| Data model work | + project/data-model.md, memory/decisions.md |
| Integration work | + project/integrations.md |
| Complex / high-risk | + memory/mistakes.md, memory/patterns.md |
| Phase planning | phases/phase-N/phase.md, project/overview.md, atlas/gaps.md |

---

## Human Navigation

Where to find everything in this repository.

### Project Definition
- `project/overview.md` -- Vision, goals, success criteria, failure conditions, non-scope
- `project/architecture.md` -- System design, tech stack, modules, architectural rules
- `project/data-model.md` -- ScriptableObject entities, runtime state, persisted state
- `project/integrations.md` -- Unity packages (no external services)

### Planning
- `phases/INDEX.md` -- Phase map with 7 phases
- `phases/phase-N/phase.md` -- Phase goals, deliverables, entry/exit criteria
- `phases/phase-N/INDEX.md` -- Task table for phase N
- `tasks/` -- Individual task specs, agreements, outcomes
- `atlas/gaps.md` -- 7 known unknowns from setup

### Execution
- `status/progress.md` -- Current phase and task status
- `status/blockers.md` -- Active blockers with impact
- `status/drift.md` -- Deviations from agreed plans

### Quality
- `checkpoints/pending/` -- Awaiting human review
- `checkpoints/passed/` -- Approved and sealed

### Knowledge
- `memory/decisions.md` -- Architectural and pattern decisions with rationale
- `memory/mistakes.md` -- What went wrong and lessons learned
- `memory/patterns.md` -- Reusable approaches that work

### Skills
- `skills/INDEX.md` -- Master list of all skills (7 foundation skills)
- `skills/foundation/` -- Unity/C# project skills (7 files)
- `skills/active/` -- Promoted skills (proven useful)
- `skills/archive/` -- Retired skills (kept for reference)
- `skills/imported/` -- Skills brought from other projects

### System
- `CLAUDE.md` -- Agent protocol and rules
- `INDEX.md` -- This file
- `atlas/` -- Setup guide, command reference, workflow, gaps
- `hooks/` -- Automation scripts

### Team (when active)
- `team/workstreams.md` -- Developer assignments and ownership
- `team/sync-log.md` -- Cross-workstream decisions and file touches

---

## Team Workstreams

> This section activates when team mode is enabled.

[TEAM_MODE: inactive]

When active, this section displays:
- Active workstreams with assigned developers
- Current task per workstream
- File ownership boundaries
- Last sync point
