# Agreement — T018: Room Manager & Door System
## Status: APPROVED
## Approved: 2026-03-12 (auto-approved by atlas-run --full-permission)

## Scope
- RoomManager state machine (Inactive/Active/Cleared)
- Enemy spawning from RoomTemplate data
- Room clear detection (all enemies dead check)
- Door MonoBehaviour with open/closed states
- Door trigger collider for player detection
- GameEvents integration (OnRoomEntered, OnRoomCleared)

## Not In Scope
- Room placement or transitions (T019)
- Floor progression (T020)

## Checkpoint Parameters
- RoomManager state transitions work correctly
- Enemies spawn at designated spawn points
- Door locks/unlocks toggle based on room state
- GameEvents fire at correct times
- Non-combat rooms never lock

## Skills Used
- singleton-events-pattern
- room-prefab-conventions
