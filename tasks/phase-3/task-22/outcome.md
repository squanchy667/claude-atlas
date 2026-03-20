# Outcome — T022: Dungeon Integration Test

**Status:** DONE (with open issues)
**Date:** 2026-03-20

## What Was Built

Full Phase 3 Unity integration testing and bug fixing session. All core dungeon generation features were tested in Unity, bugs identified and fixed iteratively.

## Deliverables

- [x] Dungeon generates procedurally with pyramid DAG structure
- [x] Rooms connect via doors with conflict-free wall assignments
- [x] Door lock/unlock works for combat rooms
- [x] Player can navigate between rooms via door teleportation
- [x] Minimap displays explored/unexplored rooms with correct colors
- [x] Minimap nodes stay within frame bounds (RectMask2D clipping)
- [x] Floor progression works across 3 floors
- [x] Boss defeat spawns floor portal
- [x] Floor portal advances to next floor
- [x] Completing all 3 floors triggers victory screen
- [x] Game over screen on player death
- [x] Restart (R key) fully resets all singletons and reloads scene
- [x] Enemy attack range visualized (red circles)
- [x] Player weapon range visualized (green circle)
- [x] Treasure rooms show gold marker
- [x] Shop rooms show green marker
- [x] Boss room requires 3+ transitions from start
- [x] Input System migration (no legacy Input.GetKeyDown)
- [x] Walls visible with thick outlines and high-contrast colors (runtime sprite fix)
- [x] Floor color differences clearly distinct between floors (high-saturation palette)
- [ ] Treasure/shop rooms not interactive (by design — Phase 5 scope)

## Files Changed

| File | Change |
|------|--------|
| `Scripts/Dungeon/DungeonGenerator.cs` | Major rewrite: conflict-free door directions, teleport cooldown, velocity clearing, runtime sprite creation |
| `Scripts/Dungeon/FloorGraph.cs` | Boss path depth fix (middleRooms <= 1 threshold) |
| `Scripts/Dungeon/RoomBuilder.cs` | DOOR_WIDTH 2f → 3f, WALL_THICKNESS 1f → 1.5f, black outline borders, sorting order fix |
| `Scripts/Dungeon/RoomController.cs` | Added SpawnRoomMarker() for treasure/shop visual markers |
| `Scripts/Core/RunManager.cs` | Floor colors: blue-gray/brown/purple with brighter walls |
| `Scripts/UI/MinimapUI.cs` | Complete rewrite: RectMask2D, padding, sizing, color coding |
| `Scripts/UI/GameOverUI.cs` | New: death/victory screens, singleton cleanup on restart, Input System |
| `Scripts/Combat/HitboxVisualizer.cs` | New: debug circles for attack/weapon range |
| `Editor/SceneSetup.cs` | Added GameOverUI, HitboxVisualizer to scenes |

## Drift Events

7 drift events logged (see drift.md). 4 High, 2 Medium, 1 Low.
All resolved. 1 open issue (treasure/shop interaction) deferred to Phase 5 by design.

## Notes

Phase 3 required extensive iterative debugging in Unity. The programmatic scene setup (no prefabs) continues to expose edge cases. Key learnings:
- Door direction assignment is a graph-level problem, not per-connection
- Singleton persistence across scene reloads requires explicit cleanup
- Minimap UI positioning needs mathematical validation of bounds before testing
- Wall visibility is an ongoing issue that may need a different rendering approach (e.g., thicker walls, outline shaders, or tilemap)
