# Agreement — T022: Dungeon Integration Test
## Status: APPROVED
## Approved: 2026-03-12 (auto-approved by atlas-run --full-permission)

## Scope
- SceneSetup.CreateDungeonTestScene() menu item
- Creates: DungeonGenerator, RunManager, player (from prefab), UI canvas, minimap, health bar
- Triggers floor generation on Play mode start
- Wires all systems together

## Not In Scope
- New gameplay mechanics
- Persistent saves
- Menu systems

## Checkpoint Parameters
- Scene creates and plays without errors
- Full dungeon run is completable (3 floors)
- All Phase 3 exit criteria met in this scene

## Skills Used
- editor-scripting
- Pattern-001 (event timing)
