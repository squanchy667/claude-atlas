# T019: Dungeon Generator & Scene Controller
## Phase: 3 — Dungeon Generation
## Status: PENDING
## Complexity: High
## Estimated Scope: 1 file, ~300 lines

## Objective
The orchestrator that takes a FloorGraph and instantiates the physical dungeon. Places rooms in world space, connects them with corridors/doors, handles player room transitions, and manages camera movement between rooms.

## Deliverables
- `Assets/Scripts/Dungeon/DungeonGenerator.cs` — Singleton that generates and manages the physical dungeon

## Dependencies
- Depends On: T016, T017, T018
- Blocks: T020, T021

## Acceptance Criteria
- [ ] DungeonGenerator takes a floor number, generates FloorGraph, builds rooms in world space
- [ ] Rooms are positioned with spacing so they don't overlap
- [ ] Doors between connected rooms are properly linked
- [ ] Player transitions between rooms when passing through doors
- [ ] Camera snaps/lerps to new room on transition
- [ ] Current room activates (enemies spawn) on entry
- [ ] Previously cleared rooms remain cleared on revisit
- [ ] DungeonGenerator is a singleton (Singleton pattern)
