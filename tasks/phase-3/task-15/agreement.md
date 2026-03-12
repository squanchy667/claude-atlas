# Agreement — T015: Dungeon Data ScriptableObjects
## Status: APPROVED
## Approved: 2026-03-12 (auto-approved by atlas-run --full-permission)

## Scope
- Create RoomType enum (Start, Combat, Treasure, Shop, Boss)
- Create DoorDirection enum (North, South, East, West) and DoorConfig serializable struct
- Create RoomTemplate ScriptableObject with room configuration fields
- Create FloorConfig ScriptableObject with per-floor settings

## Not In Scope
- Room prefab creation (T017)
- Floor graph generation (T016)
- Any runtime logic

## Checkpoint Parameters
- All 4 files compile without errors
- Enums have correct values
- SOs have all required fields from data-model.md
- Follow ScriptableObject data pattern from skills

## Skills Used
- scriptableobject-data-pattern
- unity-project-structure
