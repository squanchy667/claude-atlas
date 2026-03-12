# Phase 3 — Dungeon Generation

## Status: IN PROGRESS

## Tasks

| ID | Task | Status | Complexity | Depends On | Blocks |
|----|------|--------|------------|------------|--------|
| T015 | Dungeon Data ScriptableObjects | PENDING | Low | — | T016, T017, T018 |
| T016 | Floor Graph Generator | PENDING | High | T015 | T019, T021 |
| T017 | Room Prefab System | PENDING | Medium | T015 | T018, T019 |
| T018 | Room Manager & Door System | PENDING | Medium | T015, T017 | T019 |
| T019 | Dungeon Generator & Scene Controller | PENDING | High | T016, T017, T018 | T020, T021 |
| T020 | Floor Progression | PENDING | Medium | T019 | T022 |
| T021 | Minimap UI | PENDING | Medium | T016, T019 | T022 |
| T022 | Dungeon Integration Test | PENDING | Medium | T019, T020, T021 | — |

## Dependency Graph
```
T015 ──→ T016 ──┐
  │              │
  ├──→ T017 ──→ T018 ──→ T019 ──→ T020 ──→ T022
  │              │         │
  └──────────────┘         └──→ T021 ──→ T022
```
