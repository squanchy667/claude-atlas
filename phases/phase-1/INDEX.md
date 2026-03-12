# Phase 1 — Foundation

## Tasks

| ID | Task | Status | Depends On | Blocks |
|----|------|--------|------------|--------|
| T001 | Project Setup & Repository Init | DONE | — | T002, T003, T006 |
| T002 | Core Framework (Singleton + GameEvents) | DONE | T001 | T004, T007 |
| T003 | Input System Setup | DONE | T001 | T004 |
| T004 | Player Controller | DONE | T002, T003 | T005, T006, T007 |
| T005 | Dodge Roll System | DONE | T004 | T007 |
| T006 | Camera System | DONE | T001 | T007 |
| T007 | Test Room & Editor Setup Scripts | DONE | T002, T004, T005, T006 | — |

## Drift Summary

| Task | Drift | Severity | Resolution |
|------|-------|----------|------------|
| T003 | Ability gamepad binding: rightTrigger instead of East/B | Low | Pending human decision |
| T004 | Movement: linearVelocity instead of MovePosition | Medium | Recommend keeping — better collision response |
| T005 | I-frames: boolean flag instead of Physics2D layer collision | Medium | Recommend keeping — simpler, combat system will respect flag |
