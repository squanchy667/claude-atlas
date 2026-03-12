# T015: Dungeon Data ScriptableObjects
## Phase: 3 — Dungeon Generation
## Status: PENDING
## Complexity: Low
## Estimated Scope: 4 files, ~200 lines

## Objective
Create the data layer for the dungeon system: enums, structs, and ScriptableObject definitions that all other dungeon tasks depend on.

## Deliverables
- `Assets/Scripts/Dungeon/RoomType.cs` — RoomType enum (Start, Combat, Treasure, Shop, Boss)
- `Assets/Scripts/Dungeon/DoorDirection.cs` — DoorDirection enum + DoorConfig struct
- `Assets/Scripts/Dungeon/RoomTemplate.cs` — RoomTemplate ScriptableObject
- `Assets/Scripts/Dungeon/FloorConfig.cs` — FloorConfig ScriptableObject (per-floor settings)

## Dependencies
- Depends On: None
- Blocks: T016, T017, T018

## Acceptance Criteria
- [ ] RoomType enum with 5 values: Start, Combat, Treasure, Shop, Boss
- [ ] DoorDirection enum with 4 values: North, South, East, West
- [ ] DoorConfig struct with position (Vector2) and direction (DoorDirection)
- [ ] RoomTemplate SO with: roomType, roomSize (Vector2), spawnPoints, doorPositions, minEnemies, maxEnemies, enemyPool, floorLevel
- [ ] FloorConfig SO with: floorNumber, minRooms, maxRooms, difficultyMultiplier, floorColor
- [ ] All scripts compile without errors
