# Agreement — T019: Dungeon Generator & Scene Controller
## Status: APPROVED
## Approved: 2026-03-12 (auto-approved by atlas-run --full-permission)

## Scope
- DungeonGenerator singleton
- Room placement algorithm (grid-based positioning from graph layout)
- Door linking between adjacent rooms
- Player room transition via door triggers
- Camera snap to new room center
- Room activation on player entry
- Cleared room state persistence

## Not In Scope
- Floor-to-floor transitions (T020)
- Minimap (T021)

## Checkpoint Parameters
- Dungeon generates without overlapping rooms
- Player can walk through doors to adjacent rooms
- Camera follows to new room
- Enemies spawn only in the active room
- Revisiting a cleared room does not respawn enemies

## Skills Used
- singleton-events-pattern
- room-prefab-conventions
- editor-scripting
