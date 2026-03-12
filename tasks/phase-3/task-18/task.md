# T018: Room Manager & Door System
## Phase: 3 — Dungeon Generation
## Status: PENDING
## Complexity: Medium
## Estimated Scope: 2 files, ~250 lines

## Objective
Manage per-room state (inactive, active, cleared) and door behavior (lock on combat enter, unlock on clear). Handle enemy spawning within rooms and room clear detection.

## Deliverables
- `Assets/Scripts/Dungeon/RoomManager.cs` — Per-room state machine, enemy spawning, clear detection
- `Assets/Scripts/Dungeon/Door.cs` — Door MonoBehaviour with lock/unlock, trigger zone, visual state

## Dependencies
- Depends On: T015, T017
- Blocks: T019

## Acceptance Criteria
- [ ] RoomManager tracks room state: Inactive → Active → Cleared
- [ ] Combat rooms lock doors on entry, unlock when all enemies dead
- [ ] Non-combat rooms (Treasure, Shop, Start) don't lock doors
- [ ] RoomManager spawns enemies from template's enemyPool at spawn points
- [ ] Room clear fires GameEvents.RoomCleared
- [ ] Door has visual states (open/closed) using sprite color
- [ ] Door trigger zone detects player entry
