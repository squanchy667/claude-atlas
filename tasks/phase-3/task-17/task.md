# T017: Room Prefab System
## Phase: 3 — Dungeon Generation
## Status: PENDING
## Complexity: Medium
## Estimated Scope: 2 files, ~250 lines

## Objective
Create the system for building room GameObjects programmatically. Each room has walls, floor, door openings, and spawn point markers. Support multiple room sizes and layouts for variety.

## Deliverables
- `Assets/Scripts/Dungeon/RoomBuilder.cs` — Programmatic room construction (walls, floor, doors, spawn points)
- `Assets/Scripts/Dungeon/RoomController.cs` — MonoBehaviour attached to each room GO (holds template data, spawn points, door references)

## Dependencies
- Depends On: T015
- Blocks: T018, T019

## Acceptance Criteria
- [ ] RoomBuilder creates rooms programmatically with walls, floor tile, and door openings
- [ ] Rooms support variable sizes (small: 12x10, medium: 16x12, large: 20x14)
- [ ] Door openings are created at correct positions based on DoorConfig
- [ ] Spawn points are placed within room bounds
- [ ] RoomController component holds references to doors, spawn points, room template
- [ ] At least 3 room size variants work correctly
