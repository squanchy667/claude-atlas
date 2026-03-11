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

### Quality Scorecard View

Real-time project health metrics displayed as a dedicated dashboard panel.

**Layout:** A top-level health indicator (GOOD / FAIR / NEEDS_IMPROVEMENT) with drill-down into individual metrics.

**Metrics displayed:**
- First-try approval rate as a percentage with trend sparkline across phases
- Drift rate as a percentage with severity breakdown (Low / Medium / High / Critical pie chart)
- Estimation accuracy as a percentage with per-category breakdown (auth, database, API, UI, integration, infrastructure)
- Blocker resolution time as average duration with a timeline of open/close events
- Skill reuse rate as a ratio with most-used and least-used skills highlighted
- Agreement revision rate as a percentage

**Trend lines:** Each metric has a phase-by-phase trend line showing how the metric has changed over time. A project that starts with 50% first-try approval and improves to 85% tells a different story than one that starts at 90% and declines to 60%.

**Phase comparison:** Side-by-side phase scorecards allow the user to compare health across phases. This surfaces patterns like "Phase 2 always has high drift because that is where requirements are least understood" or "estimation accuracy improves every phase as the team calibrates."

**Red/yellow/green indicators:** Each metric is color-coded against its threshold:
- Green: within "good" range
- Yellow: within "fair" range
- Red: in "needs improvement" range

The overall health indicator uses the weighted composite described in quality-scorecard.md.

**Data source:** Parsed from checkpoint files, drift files, agreement files, outcome files, and blocker files. No additional data collection required.

### Collective Intelligence View

A view that surfaces aggregated project intelligence from the Atlas community. Available when the user has opted into collective intelligence or when browsing public data.

**Browse by project type:** Select a project type (SaaS, API, CLI, game, extension, library) and see aggregated intelligence:
- Most common mistakes for this project type, ranked by frequency
- Most effective patterns, ranked by adoption rate and reported impact
- Estimation benchmarks: what the average accuracy is for each task category
- Typical project structure: median phase count, median tasks per phase, median duration
- Most-used skills by project type

**Compare to baseline:** When viewing your project's dashboard, a toggle switches between "absolute" and "relative" views. Relative view shows your project's metrics compared to the collective baseline for your project type:
- "Your drift rate: 25% (vs 35% average for SaaS projects)"
- "Your estimation accuracy: 78% (vs 68% average)"
- "Your first-try approval: 85% (vs 72% average)"

This tells the developer whether their challenges are unique or common across projects of this type.

**Trending insights:** The collective intelligence view highlights recently emerging patterns --- new mistakes being reported frequently, new patterns gaining adoption, shifts in estimation accuracy as tooling improves.

**Privacy:** The collective intelligence view only shows aggregated, anonymized data. No individual project details, no developer names, no company information. See cross-project-intelligence.md for the full privacy model.

### Team Workstream View (Enhanced)

When team mode is active, the workstream view expands beyond basic task assignment to provide real-time coordination intelligence.

**Live collision detection visualization:** A matrix view showing developers on one axis and files/modules on the other. Cells are color-coded:
- Green: no overlap, safe to work in parallel
- Yellow: potential overlap, same module but different files
- Red: active collision, two developers touching the same file
- Blue: sync point, deliberate convergence required

The matrix updates as tasks are started and completed. Developers can see at a glance where conflicts are brewing.

**Developer assignment heatmap:** A visual representation of workload distribution:
- Each developer shown as a column
- Tasks stacked vertically, color-coded by complexity (simple = light, complex = dark)
- Height indicates estimated effort
- Makes overload immediately visible: one tall dark column next to short light ones means imbalanced distribution

This enables the team lead (or any team member) to spot and address workload imbalances before they cause bottlenecks.

**Sync point timeline:** A horizontal timeline showing all sync points for the current phase:
- Past sync points marked as complete (green) or missed (red)
- Current sync points marked as pending with participant status (who has confirmed, who has not)
- Future sync points with estimated dates based on current progress
- Click on a sync point to see what it is about (shared interface, database migration, API contract)

**Workstream progress comparison:** Side-by-side progress bars for each developer's workstream. Shows:
- Tasks completed vs total assigned
- Current velocity (tasks per session)
- Estimated completion date based on velocity
- Blockers currently assigned to each developer

## Prerequisites

This feature depends on:
- Stable Atlas file format (markdown structure must be finalized)
- Validated workflow (dashboard is only useful if Atlas workflow works)
- Enough projects using Atlas to justify the development investment
- Quality scorecard implementation (for Quality Scorecard View)
- Cross-project intelligence infrastructure (for Collective Intelligence View)
- Team mode implementation (for enhanced Team Workstream View)
