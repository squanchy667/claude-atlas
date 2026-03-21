# Phase 5 — The Kennel (Base)

**Goal:** Home base scene, dog management, role assignment, building/upgrade system, resource economy, meta-progression
**Status:** PENDING
**Tasks:** 8

## Task Map

| Task | Name | Status | Complexity | Depends On | Blocks |
|------|------|--------|------------|------------|--------|
| T031 | Kennel Data Models | PENDING | Medium | — | T032, T033, T034 |
| T032 | MetaProgressionManager (Save/Load) | PENDING | High | T031 | T035, T036, T037 |
| T033 | Dog Rescue Mechanic | PENDING | Medium | T031 | T035 |
| T034 | Kennel Scene & Navigation | PENDING | Medium | T031 | T035, T036, T037 |
| T035 | Dog Roster & Role Assignment UI | PENDING | High | T032, T033, T034 | T038 |
| T036 | Building & Upgrade System | PENDING | High | T032, T034 | T038 |
| T037 | Scene Transitions & Run Economy | PENDING | High | T032, T034 | T038 |
| T038 | Phase 5 Integration Test | PENDING | Medium | T035, T036, T037 | — |

## Dependency Graph

```
T031 ──→ T032 ──→ T035 ──→ T038
    \──→ T033 ──/       /
    \──→ T034 ──→ T036 ─/
              \──→ T037 ─/
```

## Parallel Groups

- **Group 1:** T031 (foundation — all other tasks depend on this)
- **Group 2:** T032 + T033 + T034 (all depend only on T031, parallel with each other)
- **Group 3:** T035 + T036 + T037 (convergence layer, partial parallelism — T036 and T037 can run together)
- **Group 4:** T038 (integration test, depends on all Group 3 tasks)
