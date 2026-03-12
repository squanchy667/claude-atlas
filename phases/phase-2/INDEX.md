# Phase 2 — Combat Core

## Status: IN PROGRESS (paused for next session)

## Tasks

| ID | Task | Status | Depends On | Blocks |
|----|------|--------|------------|--------|
| T008 | Combat Data ScriptableObjects | DONE | — | T010, T012 |
| T009 | Health System | DONE | — | T010, T011, T012, T013 |
| T010 | Attack System | DONE | T008, T009 | T011, T014 |
| T011 | Hit Feedback System | DONE | T009, T010 | T014 |
| T012 | Enemy AI | DONE | T008, T009 | T014 |
| T013 | Health Bar UI | DONE | T009 | T014 |
| T014 | Combat Test Scene Integration | IN_PROGRESS | T010, T011, T012, T013 | — |

## Verification Status (2026-03-12)

### Confirmed Working
- Player attack via C key / left mouse button
- Enemy chasing behavior (enemies detect and pursue player)
- Hit detection (OverlapCircle finds enemies in range)
- Enemy death (stops moving, disables collider)
- Screen shake on hit
- Hitstop on hit
- Weapon auto-creation fallback
- Enemy data auto-creation fallback

### Known Issues (to fix next session)
- **Player health bar not updating** — enemies chase but player health bar shows no change when enemies attack. Likely cause: enemy attack not dealing damage to player, OR PlayerHealthUI not connected to player's HealthSystem. Event timing fix was applied but not yet confirmed.
- **Dead enemy blue tint** — code exists but not confirmed working by user after latest fixes.
- **Knockback visual** — not confirmed by user.
- **Damage flash (white flash)** — not confirmed by user.

### Root Cause Pattern
Multiple systems subscribed to `OnPlayerSpawned` after the player already fired it in `OnEnable()`. Fix applied: added `Start()` fallback with `FindAnyObjectByType<PlayerController>()` to EnemyController, PlayerHealthUI, and CameraController. This fix needs Unity re-test.
