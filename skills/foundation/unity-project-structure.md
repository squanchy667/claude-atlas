# Unity Project Structure

**Tier:** Foundation
**Category:** Architecture
**Created:** 2026-03-11
**Status:** Active

## What It Solves
Establishes a consistent folder structure for the Unity project so all scripts, assets, and configurations have a predictable home. Prevents the common Unity pitfall of flat, disorganized Assets folders.

## Approach
1. Use this folder structure under `Assets/`:
   ```
   Assets/
   ├── Scripts/
   │   ├── Core/           — GameManager, Singleton<T>, GameEvents, MetaProgressionManager
   │   ├── Player/         — PlayerController, DodgeRoll, PlayerInput
   │   ├── Combat/         — CombatSystem, HealthSystem, WeaponController
   │   ├── Enemies/        — EnemyAI, EnemySpawner, BossController
   │   ├── Dungeon/        — DungeonGenerator, RoomManager, RoomPlacer, DoorController
   │   ├── Kennel/         — KennelManager, DogManager, UpgradeManager
   │   ├── Camera/         — CameraController, ScreenShake
   │   ├── UI/             — UIManager, HealthBar, MinimapController, MenuController
   │   └── Utils/          — Extensions, helpers, constants
   ├── ScriptableObjects/
   │   ├── Characters/     — CharacterData assets
   │   ├── Weapons/        — WeaponData assets
   │   ├── Enemies/        — EnemyData assets
   │   ├── Rooms/          — RoomTemplate assets
   │   ├── Upgrades/       — UpgradeData assets
   │   └── Audio/          — SoundBank assets
   ├── Prefabs/
   │   ├── Player/         — Player prefab variants
   │   ├── Enemies/        — Enemy prefabs
   │   ├── Weapons/        — Weapon/projectile prefabs
   │   ├── Rooms/          — Room prefabs
   │   ├── UI/             — UI prefabs (health bar, minimap, menus)
   │   └── Effects/        — Particle system prefabs
   ├── Scenes/
   │   ├── MainMenu.unity
   │   ├── CharacterSelect.unity
   │   ├── Dungeon.unity
   │   └── Kennel.unity
   ├── Art/
   │   ├── Sprites/        — All sprite sheets and individual sprites
   │   ├── Tilemaps/       — Tile palettes and rule tiles
   │   └── UI/             — UI sprites and icons
   ├── Audio/
   │   ├── SFX/            — Sound effect files
   │   └── Music/          — Music tracks
   ├── Animations/
   │   ├── Player/         — Player animation controllers and clips
   │   ├── Enemies/        — Enemy animations
   │   └── UI/             — UI animations
   ├── Editor/             — Editor-only scripts (setup helpers, custom inspectors)
   └── Settings/           — URP settings, Input Action assets
   ```
2. Each C# script file belongs in exactly one folder based on its system.
3. ScriptableObject definitions (C# classes) go in `Scripts/`. ScriptableObject assets (instances) go in `ScriptableObjects/`.
4. Prefabs reference ScriptableObject assets, not hardcoded values.

## When To Use
- Starting any new script, prefab, or asset — check this structure first
- During code review — verify files are in the correct folder
- When creating new systems — add a subfolder if needed, following the pattern

## When NOT To Use
- Don't reorganize an existing structure mid-phase unless it's causing real problems
- Don't add folders for hypothetical future systems

## Gotchas
- Unity meta files: every file and folder has a .meta file. Never delete .meta files manually or Git will lose references.
- Moving files in Unity must be done through the Editor (or carefully with .meta files) to preserve asset references.
- `Editor/` folder has special meaning in Unity — scripts there only compile in the Editor, not in builds.
