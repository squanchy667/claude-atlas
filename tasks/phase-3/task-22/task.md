# T022: Dungeon Integration Test
## Phase: 3 — Dungeon Generation
## Status: PENDING
## Complexity: Medium
## Estimated Scope: 1 file (SceneSetup extension), ~150 lines

## Objective
Extend SceneSetup.cs to create a full dungeon test scene. Player starts a run, navigates rooms, fights enemies, defeats boss, progresses through 3 floors. Validates all Phase 3 systems working together.

## Deliverables
- Updated `Assets/Editor/SceneSetup.cs` — New menu item "Create Dungeon Test Scene"

## Dependencies
- Depends On: T019, T020, T021
- Blocks: None

## Acceptance Criteria
- [ ] SceneSetup creates a dungeon scene with DungeonGenerator, RunManager, player, UI
- [ ] Floor 1 generates with 5-8 rooms in DAG layout
- [ ] Player can navigate between rooms via doors
- [ ] Combat rooms lock and spawn enemies
- [ ] Boss room has a stronger enemy
- [ ] Defeating boss spawns portal to Floor 2
- [ ] Minimap shows room graph
- [ ] All 3 floors are playable in sequence
- [ ] Scene is playable: enter Play mode and test dungeon immediately
