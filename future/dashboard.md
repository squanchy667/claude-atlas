# Future Feature: Web Dashboard

> Planned for post-v1. Requires validation of Atlas workflow before building visibility layer.

## Overview

The Web Dashboard reads an Atlas docs repository and visualizes project state in a browser. It provides real-time visibility into progress, team workstreams, drift patterns, and skill usage without requiring CLI access.

## Capabilities

### Project Timeline

Visual timeline showing phases, tasks, and their status. Color-coded by completion state (pending, in progress, done, blocked). Clicking a task shows its full spec, agreement, checkpoint, and drift history.

### Phase Progress

Dashboard view per phase showing:
- Task completion percentage
- Estimated vs actual duration
- Blocker count and resolution time
- Exit criteria status

### Team Workstream View

When team mode is active, the dashboard shows:
- Per-developer task assignments and progress
- Active collision warnings with resolution strategies
- Sync point status (pending, converging, complete)
- Workload distribution across developers

### Drift Analytics

Aggregated drift data across the project:
- Drift frequency by type (scope, implementation, dependency)
- Drift severity distribution
- Recurring drift patterns with root cause analysis
- Tasks with highest drift — potential process improvement targets

### Skill Library Browser

Visual browser for the project's skill library:
- Skills organized by category and tier (Foundation, Active, Archive)
- Usage frequency and effectiveness metrics
- Skill creation timeline (when skills were discovered)
- Related skill clusters

### Checkpoint Status

Overview of all phase checkpoints:
- Self-validation results from Claude
- Human review status and notes
- Approval history
- Carried-forward gaps

## Technical Approach

The dashboard reads Atlas markdown files directly from the repository. No separate database — the docs repo is the source of truth. The dashboard parses:
- `status/progress.md` for current state
- `status/blockers.md` for blocker data
- `memory/drift-log.md` for drift analytics
- `skills/INDEX.md` for skill library
- `checkpoints/` for checkpoint history
- `team/` for workstream data
- `tasks/` for task specs and agreements

## Revenue Model

- **Free tier** — basic project progress view, single project
- **Paid subscription** — full analytics, team views, multi-project portfolio, historical trends

## Prerequisites

This feature depends on:
- Stable Atlas file format (markdown structure must be finalized)
- Validated workflow (dashboard is only useful if Atlas workflow works)
- Enough projects using Atlas to justify the development investment
