# Claude Atlas

**Define it once. Press play.**

Claude Atlas is a standalone docs repository template that acts as a complete operating system for any software project built with Claude Code. It sits alongside your code repo and serves as the brain -- the map, the memory, the toolbox, and the operating manual. You define your project once through a guided conversation, then execute it through commands, not prompts.

---

## Principles

1. **Depth-First** -- Build one thing end to end before expanding. Never scaffold everything first.
2. **Radical Transparency** -- Every decision, deviation, and mistake is documented. Nothing happens silently.
3. **Pre-Task Agreement** -- Before any work begins, Claude and the human agree on exactly what will be built.
4. **Growing Toolbox** -- Skills discovered during work are captured, tested, and promoted for reuse.
5. **Layered Validation** -- Every task produces a checkpoint. Every phase produces a gate. Humans verify at every layer.

---

## Quick Start

```bash
# Clone the template
git clone https://github.com/ofekray/claude-atlas.git my-project-docs

# Open Claude Code in your project
cd my-project-docs

# Create the Atlas folder structure
/atlas-init

# Define your project through guided conversation
/atlas-setup

# Preview the generated plan
# (offered automatically at the end of setup)

# Start building
/atlas-run
```

---

## Commands

| Command | What It Does |
|---------|-------------|
| `/atlas-init` | Create the Atlas folder structure from template. |
| `/atlas-setup` | Guided project definition conversation. Fills all spec files. |
| `/atlas-run` | Execute the project with autopilot. Three modes: full-permission, supervised, report-only. |
| `/plan-phase` | Break a phase into tasks with dependencies, risks, and skills. |
| `/task` | Plan, start, complete, or flag drift on a task. |
| `/checkpoint` | Human review walkthrough. Compare agreement to outcome. |
| `/complete-phase` | Phase gate. Verify checkpoints, promote skills, update memory. |
| `/skill` | Create, promote, scan, import, or publish reusable skills. |
| `/status` | Current project state at a glance. |

See `atlas/commands.md` for full documentation of every command.

---

## How It Works

The Atlas journey follows a loop:

```
init --> setup --> preview --> run --> loop
              |                         |
              |    plan-phase           |
              |        |                |
              |    task plan             |
              |    task start            |
              |    task complete         |
              |    checkpoint            |
              |        |                |
              |    complete-phase -------+
```

**Init** creates the folder structure. **Setup** asks you about your project and fills the spec files. **Preview** shows you the generated plan for approval. **Run** starts execution.

During execution, each phase is planned into tasks. Each task goes through a lifecycle: plan (create agreement), start (load context), build, complete (write outcome and checkpoint). The human reviews each checkpoint. When all tasks pass, the phase completes with a gate that promotes skills and updates memory.

The project accumulates knowledge as it runs. Decisions, mistakes, and patterns are logged in memory. Skills are discovered, tested, and promoted. Gaps are tracked and resolved. Each phase builds on the knowledge of the previous one.

---

## Team Mode

Atlas is built for one or more developers from the start. When `/atlas-setup` detects more than one developer, it activates team mode:

- Workstreams with clear file ownership boundaries
- Collision detection before task assignment
- Sync points logged for cross-workstream visibility
- Per-developer context routing

Team mode adds coordination overhead only when it is needed.

---

## Skill Marketplace

Atlas ships with pre-built skill packs for common project patterns:

| Pack | Skills | What It Covers |
|------|--------|---------------|
| general | 5 | Git workflow, testing, error handling, code review, documentation |
| web-app | 5 | Components, state, API integration, auth, forms |
| api-service | 5 | REST design, database, validation, middleware, logging |
| cli-tool | 3 | Arguments, output formatting, configuration |

Import a skill: `/skill import general/testing-strategy`
Import a full pack: `/skill import web-app`
Browse available skills: `/skill browse`
Publish your own: `/skill publish my-custom-skill`

---

## Repository Structure

```
claude-atlas/
  CLAUDE.md              -- Agent protocol (Claude reads this first)
  INDEX.md               -- Switchboard (routes agents to the right files)
  README.md              -- This file
  atlas/                 -- System docs: setup, commands, workflow, gaps
  project/               -- Project definition: overview, architecture, data model, integrations
  phases/                -- Phase plans
  tasks/                 -- Task specs, agreements, outcomes
  checkpoints/
    pending/             -- Awaiting human review
    passed/              -- Approved (sealed, never modified)
  skills/
    foundation/          -- Project-type skills (created at setup)
    active/              -- Promoted skills (proven useful)
    archive/             -- Retired skills (kept for reference)
    imported/            -- Skills from other projects
  marketplace/           -- Pre-built skill packs (general, web-app, api-service, cli-tool)
  memory/                -- Decisions, mistakes, patterns
  status/                -- Progress, blockers
  team/                  -- Workstreams and sync log (team mode)
  hooks/                 -- Automation scripts
```

---

## Future

These features are planned but not yet implemented:

- **Dashboard** -- Visual project health dashboard.
- **Multi-Repo** -- Coordinate multiple code repos from a single Atlas.

---

## License

MIT License. See [LICENSE](LICENSE).
