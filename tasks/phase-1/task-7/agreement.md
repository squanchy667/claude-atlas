# Agreement — T007: Test Room & Editor Setup Scripts
## Status: APPROVED
## Approved: 2026-03-11 (auto-approved by atlas-run --full-permission)

## Scope
- ProjectSetup.cs Editor script with folder creation and validation
- SceneSetup.cs Editor script with test scene generation
- Menu items under DogPack/Setup/
- Placeholder player prefab with all Phase 1 components
- Tilemap room with walls (colliders) and floor
- Camera setup targeting the player

## Not In Scope
- Art assets beyond placeholder colored squares
- Tilemap palette or tile asset creation tools
- Scene loading or scene management system
- Build configuration or platform setup
- Automated testing or test runner integration

## Checkpoint Parameters
- Editor scripts compile with no errors in Unity Editor
- Menu items `DogPack/Setup/Create Project Structure` and `DogPack/Setup/Create Test Scene` appear in menu bar
- Running Create Project Structure creates expected folder hierarchy
- Running Create Project Structure a second time produces no errors or duplicates
- Running Create Test Scene produces a playable scene with player, camera, and walled room
- Player can move in the test scene and collide with walls
- All Phase 1 components (PlayerController, DodgeRoll, CameraController) are present and functional in the test scene

## Skills Used
- unity-editor-scripting (MenuItem, AssetDatabase, EditorSceneManager)
- unity-tilemap (Tilemap, TilemapCollider2D, programmatic tile placement)
- unity-prefab (programmatic prefab creation and component assembly)

## Risks
- Editor scripts must be in an `Editor/` folder or wrapped in `#if UNITY_EDITOR` to avoid build errors
- Programmatic tilemap creation requires a Tile asset — script must create a default tile or use Unity's built-in tile
- Scene setup depends on all Phase 1 scripts compiling — if T004/T005/T006 have errors, SceneSetup will fail to add components
- Prefab creation via script requires careful use of PrefabUtility to save correctly
