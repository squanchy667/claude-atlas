# Agreement — T017: Room Prefab System
## Status: APPROVED
## Approved: 2026-03-12 (auto-approved by atlas-run --full-permission)

## Scope
- RoomBuilder static class for programmatic room creation
- RoomController MonoBehaviour for per-room data
- Wall creation with colliders and sprites
- Floor sprite (colored by floor level)
- Door openings (gaps in walls)
- Spawn point Transform markers
- 3 room size variants

## Not In Scope
- Door lock/unlock mechanics (T018)
- Enemy spawning (T018)
- Room placement in world (T019)

## Checkpoint Parameters
- Rooms build without errors
- Walls have colliders that block player movement
- Door openings are correctly placed
- 3 size variants produce visually distinct rooms
- RoomController holds all references

## Skills Used
- unity-project-structure
- room-prefab-conventions
- editor-scripting
