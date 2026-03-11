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

## Connection to Future Features

### Team Quality Scorecard

The quality scorecard (see quality-scorecard.md) extends in team mode to include per-developer metrics. This is explicitly for calibration, not for blame or performance ranking.

**Per-developer metrics tracked:**
- First-try approval rate per developer (are some developers' checkpoints consistently needing revisions? That may indicate unclear agreements, not developer quality)
- Drift rate per developer (does one developer's workstream have more drift? That may mean their task domain is less well-understood)
- Estimation accuracy per developer per task category (Developer A may be perfectly calibrated on API tasks but consistently underestimate auth tasks)

**How it is used:**
- During `/plan-phase`, task assignment considers each developer's estimation accuracy for the relevant task category. A developer who is well-calibrated on auth tasks gets auth tasks assigned (or at least has their estimates trusted more)
- During `/complete-phase`, the team scorecard is presented alongside the phase scorecard. It surfaces actionable patterns without creating a competitive dynamic
- During `/atlas-retro`, per-developer scorecards feed into each developer's personal calibration data

**Presentation:** The team scorecard is always framed as calibration data, not rankings:
```
Team Calibration — Phase 2
──────────────────────────
Alice:
  Strength: API tasks (92% accurate), UI tasks (85% accurate)
  Growth area: Database tasks (55% accurate — tends to underestimate migration scope)
  First-try approvals: 90%

Bob:
  Strength: Database tasks (88% accurate), Infrastructure (90% accurate)
  Growth area: Auth tasks (50% accurate — tends to underestimate token management)
  First-try approvals: 75% (agreements may need more detail for Bob's workstream)
```

### Team Estimation

Different developers have different estimation accuracy profiles. In team mode, adaptive estimation (see adaptive-estimation.md) is calibrated per developer, not per project.

**How it works:**
- Each developer in `team/members.md` has their own calibration profile
- When `/plan-phase` distributes tasks, it applies the assigned developer's calibration to each task
- If a task has not been assigned yet, Atlas uses the team-wide average calibration
- The calibration blending (personal vs collective) applies per developer

**Example scenario:**
Task T015 (Payment Integration) is estimated as "moderate" and assigned to Alice.
- Alice's calibration for integration tasks: adjustment factor 1.4 (she underestimates by 40%)
- Bob's calibration for integration tasks: adjustment factor 1.0 (he is well-calibrated)
- Atlas recommends reassigning T015 to Bob, or adjusting Alice's estimate to "complex"

This is presented as a suggestion, never as an automatic reassignment. The team decides.

### Team Scope Changes

When a scope change (see scope-change-protocol.md) affects tasks assigned to multiple developers, additional coordination steps are triggered.

**Multi-workstream scope change process:**
1. The impact analysis in `/scope-change` identifies which developers are affected
2. If more than one developer is affected, Atlas flags it as a "cross-workstream scope change"
3. A sync point is automatically proposed: all affected developers must review and confirm the scope change before it is applied
4. The scope change record includes a "Workstream Impact" section:
   ```
   Workstream Impact:
   - Alice: T015, T016 affected (both in her workstream)
   - Bob: T023 affected (in his workstream)
   - Sync point required: Alice and Bob must align on new database schema approach
   ```
5. The scope change is not applied until all affected developers confirm
6. After confirmation, each developer's workstream plan in `team/workstreams.md` is updated

**Why this matters:** In solo mode, a scope change is a conversation between one developer and Atlas. In team mode, a scope change can silently invalidate another developer's work. The cross-workstream detection ensures that does not happen.

### Team Retrospective

`/atlas-retro` extends in team mode to include both per-developer and team-wide analysis.

**Per-developer retrospective:**
- Individual estimation accuracy and calibration update
- Individual drift patterns (which task types cause the most drift for this developer)
- Individual skill usage (which skills did this developer use most, which did they create)
- Personal calibration data exported to each developer's `~/.atlas/intelligence/personal/calibration.json`

**Team-wide retrospective:**
- Collision analysis: how many collisions were detected, how many were predicted vs unexpected, average resolution time
- Sync point analysis: how many sync points were needed, how many caused delays, were they placed correctly
- Workload balance: was the distribution even, did any developer become a bottleneck
- Communication patterns: did scope changes trigger appropriate sync points, were team blockers resolved quickly
- Assignment effectiveness: were tasks assigned to the right developers based on their strengths

**Team retrospective report:**
```markdown
## Team Analysis

### Collision Performance
- Predicted collisions: 5
- Actual collisions: 7 (2 unpredicted — both in shared middleware layer)
- Resolution: 4 sequential, 2 split, 1 sync point
- Recommendation: Add middleware layer to collision scan heuristics

### Sync Points
- Total sync points: 3
- Average wait time: 0.5 sessions (acceptable)
- Longest wait: 1 session (API contract sync — Bob was blocked on database migration)

### Workload Balance
- Alice: 18 tasks (52%), estimated moderate-high average
- Bob: 17 tasks (48%), estimated moderate average
- Balance: good (within 10% of even)
- Note: Alice's tasks had higher actual complexity due to auth underestimation

### Assignment Effectiveness
- Well-matched: 28/35 tasks (80%) — developer's strength matched task category
- Mismatched: 7/35 tasks (20%) — could have been better assigned
- Highest-impact mismatch: T015 (auth task assigned to Bob, who underestimates auth by 50%)
```

The team retrospective is presented to the entire team for discussion. It is designed to improve the process, not evaluate individuals.
