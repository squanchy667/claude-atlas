# T020: Floor Progression
## Phase: 3 — Dungeon Generation
## Status: PENDING
## Complexity: Medium
## Estimated Scope: 2 files, ~150 lines

## Objective
Implement the 3-floor progression system. After defeating the boss of a floor, a portal spawns that takes the player to the next floor. Each floor has increasing difficulty (enemy stat multipliers). Track run state across floors.

## Deliverables
- `Assets/Scripts/Dungeon/FloorPortal.cs` — Portal that triggers floor transition
- `Assets/Scripts/Core/RunManager.cs` — Tracks run state (current floor, rooms cleared, collected resources)

## Dependencies
- Depends On: T019
- Blocks: T022

## Acceptance Criteria
- [ ] Boss defeat in a floor spawns a portal
- [ ] Portal interaction generates the next floor and places player at Start room
- [ ] Previous floor is destroyed/unloaded
- [ ] FloorConfig provides difficulty multiplier per floor (enemy health/damage scaling)
- [ ] RunManager tracks currentFloor, roomsCleared
- [ ] After Floor 3 boss, run completes (GameEvents.RunComplete fires)
- [ ] 3 FloorConfig assets created programmatically with distinct floor colors
