# T007: Test Room & Editor Setup Scripts
## Phase: 1 — Foundation
## Status: PENDING
## Depends On: T002, T004, T005, T006
## Blocks: None

## Description
Create Unity Editor scripts that automate project setup and test scene creation. These scripts live in an `Editor/` folder and provide menu items under `DogPack/Setup/` in the Unity menu bar.

**ProjectSetup.cs** creates the standard folder structure for the project and validates that required packages (Input System, TextMeshPro, etc.) are present. It creates folders like `Scripts/Player`, `Scripts/Camera`, `Scripts/Combat`, `Prefabs`, `Scenes`, `Art/Sprites`, `ScriptableObjects`, etc. Running it multiple times is safe (idempotent — skips existing folders).

**SceneSetup.cs** creates a functional test scene containing:
- A main camera with the CameraController component
- A player spawn point
- A tilemap-based room: 16x12 tiles with wall tiles around the perimeter (with TilemapCollider2D) and floor tiles filling the interior
- A placeholder player prefab: a cyan 16x16 pixel square sprite with Rigidbody2D (gravity scale 0, freeze rotation Z), BoxCollider2D, PlayerController, and DodgeRoll components

Both scripts are accessible via Unity menu items under `DogPack/Setup/Create Project Structure` and `DogPack/Setup/Create Test Scene`.

## Deliverables
- `Editor/ProjectSetup.cs` — Creates folder structure, validates project settings
- `Editor/SceneSetup.cs` — Creates test scene with camera, player, tilemap room
- Placeholder player prefab (cyan 16x16 square with all Phase 1 components)
- Tilemap test room (16x12, walls with colliders, floor)
- Menu items under `DogPack/Setup/` in Unity editor

## Acceptance Criteria
- Menu items appear under `DogPack/Setup/` in the Unity menu bar
- `Create Project Structure` creates all required folders without errors
- Running `Create Project Structure` twice does not duplicate or error
- `Create Test Scene` creates a scene with camera, player prefab, and tilemap room
- Player prefab has Rigidbody2D, BoxCollider2D, PlayerController, and DodgeRoll components
- Rigidbody2D is configured: gravity scale 0, freeze rotation Z
- Tilemap room has 16x12 interior with wall colliders around perimeter
- Camera has CameraController component targeting the player
- Player can move around the test room and collide with walls
- Test scene is playable immediately after creation (press Play and move)
