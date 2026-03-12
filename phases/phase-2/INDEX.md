# Phase 2 — Combat Core

## Status: DONE
## Completed: 2026-03-12

## Tasks

| ID | Task | Status | Depends On | Blocks |
|----|------|--------|------------|--------|
| T008 | Combat Data ScriptableObjects | DONE | — | T010, T012 |
| T009 | Health System | DONE | — | T010, T011, T012, T013 |
| T010 | Attack System | DONE | T008, T009 | T011, T014 |
| T011 | Hit Feedback System | DONE | T009, T010 | T014 |
| T012 | Enemy AI | DONE | T008, T009 | T014 |
| T013 | Health Bar UI | DONE | T009 | T014 |
| T014 | Combat Test Scene Integration | DONE | T010, T011, T012, T013 | — |

## Verified Working (2026-03-12)
- Player attack via C key / left mouse button
- Enemy chasing, attacking, and dealing damage to player
- Hit detection (OverlapCircle)
- Enemy death (stops, disables collider, turns blue)
- Screen shake on hit (both directions)
- Hitstop on hit
- DamageFlash on hit (both directions)
- Knockback on hit (both directions)
- Health bar updates in real time
- Player can die (game over state)
- Weapon and enemy data auto-creation fallbacks
