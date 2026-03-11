# Future Feature: Team Mode

> Team mode is built into v1 and activates when developer count > 1 during /atlas-setup.

## Overview

Atlas supports multi-developer projects out of the box. When `/atlas-setup` receives a developer count greater than 1, team mode activates automatically. This extends the planning and execution commands with workstream distribution, collision detection, and sync point management.

## Capabilities

### Developer Profiles

Each team member gets a profile in `team/members.md` with their role, specialties, and current assignment. Atlas uses this information during `/plan-phase` to assign tasks based on expertise alignment.

### Workstream Planning

During `/plan-phase`, Atlas distributes tasks across developers based on:
- Developer specialties (backend, frontend, data, infrastructure)
- Task dependencies (dependent tasks stay in the same workstream when possible)
- File/module ownership (minimize cross-developer collision on shared code)

The resulting workstream plan is written to `team/workstreams.md` with clear assignments and timelines.

### Collision Detection

Before finalizing a phase plan, Atlas scans for tasks that touch the same files or modules across different developers. Detected collisions are flagged with one of three resolution strategies:
- **Sequential** — one developer finishes before the other starts
- **Split** — divide the shared module into non-overlapping sections
- **Sync point** — both developers work in parallel but must converge at a defined point

### Sync Points

When parallel work must converge (shared interfaces, database migrations, API contracts), Atlas inserts explicit sync points. These appear in `team/workstreams.md` and block downstream tasks until both developers confirm alignment.

### Team Retrospectives

At phase completion, `/complete-phase` extends the checkpoint with team-specific questions:
- Were workstream assignments effective?
- Did any collisions occur that were not predicted?
- Should task distribution change for the next phase?

## Implementation

### Files
- `team/members.md` — developer profiles and current assignments
- `team/workstreams.md` — per-phase workstream distribution and collision analysis

### Extended Commands
- `/atlas-setup` — prompts for developer count and profiles when count > 1
- `/plan-phase` — generates workstream distribution and collision analysis
- `/complete-phase` — includes team retrospective in checkpoint

### Activation
Team mode is not a separate feature flag. It activates naturally when the project has more than one developer. All commands check `team/members.md` to determine whether team-specific logic should run.
