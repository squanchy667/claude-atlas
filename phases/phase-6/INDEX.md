# Phase 6 — Co-op

## Tasks

| ID | Task | Priority | Status | Depends On | Blocks |
|----|------|----------|--------|------------|--------|
| T039 | PlayerInputManager & P2 Join Flow | High | PENDING | — | T040, T041, T042, T043, T044 |
| T040 | Co-op Character Select | Medium | PENDING | T039 | T045 |
| T041 | Shared Camera & Leash | Medium | PENDING | T039 | T045 |
| T042 | Co-op UI (Dual Health/Ability Bars) | Medium | PENDING | T039 | T044, T045 |
| T043 | Enemy Scaling for Co-op | Low | PENDING | T039 | T045 |
| T044 | Revive Mechanic | High | PENDING | T039, T042 | T045 |
| T045 | Phase 6 Integration Test | Medium | PENDING | T040, T041, T042, T043, T044 | — |

## Dependency Graph

```
T039 (PlayerInputManager & P2 Join Flow)
├── T040 (Co-op Character Select) ──────────────┐
├── T041 (Shared Camera & Leash) ───────────────┤
├── T042 (Co-op UI) ──┬─────────────────────────┤
├── T043 (Enemy Scaling) ───────────────────────┤
│                      │                         │
│                      ▼                         │
│                 T044 (Revive Mechanic) ────────┤
│                                                │
│                                                ▼
│                                       T045 (Integration Test)
```

**Critical path:** T039 → T042 → T044 → T045

**Parallel batch after T039:** T040, T041, T042, T043 can all run in parallel once T039 is complete.

**T044 waits for:** T039 + T042 (needs co-op UI for revive circle integration).

**T045 waits for:** All tasks (T040-T044) complete before integration testing.
