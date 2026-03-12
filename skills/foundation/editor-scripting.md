# Editor Scripting for CLI Workflow

**Tier:** Foundation
**Category:** Workflow
**Created:** 2026-03-11
**Status:** Active

## What It Solves
Since Claude cannot interact with the Unity Editor GUI, many setup tasks (creating scenes, configuring prefabs, wiring references) need to be done programmatically. This skill defines the pattern for Editor scripts that automate these tasks.

## Approach

### Editor Script Location
All Editor scripts go in `Assets/Editor/`. Unity compiles these only for the Editor — they are excluded from builds.

### Scene Setup Script Pattern
```csharp
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;

public static class SceneSetup
{
    [MenuItem("DogPack/Setup/Create Dungeon Scene")]
    public static void CreateDungeonScene()
    {
        var scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single);

        // Create camera
        var cameraGO = new GameObject("Main Camera");
        var camera = cameraGO.AddComponent<Camera>();
        camera.orthographic = true;
        camera.orthographicSize = 8;
        cameraGO.AddComponent<AudioListener>();
        // Add CameraController component
        // cameraGO.AddComponent<CameraController>();

        // Create managers
        var managers = new GameObject("--- Managers ---");
        // Add manager components as they are created

        // Create environment parent
        var environment = new GameObject("--- Environment ---");

        // Save scene
        EditorSceneManager.SaveScene(scene, "Assets/Scenes/Dungeon.unity");
        Debug.Log("Dungeon scene created.");
    }
}
```

### Prefab Creation Pattern
```csharp
[MenuItem("DogPack/Setup/Create Player Prefab")]
public static void CreatePlayerPrefab()
{
    var playerGO = new GameObject("Player");

    // Add components
    var rb = playerGO.AddComponent<Rigidbody2D>();
    rb.gravityScale = 0;
    rb.freezeRotation = true;

    var collider = playerGO.AddComponent<BoxCollider2D>();
    collider.size = new Vector2(0.8f, 0.8f);

    // Add sprite renderer with placeholder
    var sr = playerGO.AddComponent<SpriteRenderer>();
    sr.color = Color.cyan; // placeholder color

    // Save as prefab
    PrefabUtility.SaveAsPrefabAsset(playerGO, "Assets/Prefabs/Player/Player.prefab");
    Object.DestroyImmediate(playerGO);
    Debug.Log("Player prefab created.");
}
```

### ScriptableObject Asset Creation
```csharp
[MenuItem("DogPack/Setup/Create Default Weapons")]
public static void CreateDefaultWeapons()
{
    CreateWeapon("Bite", WeaponType.Melee, 10f, 1.5f, 1.5f);
    CreateWeapon("Bark", WeaponType.Ranged, 7f, 1.0f, 5f);
    CreateWeapon("Pounce", WeaponType.Dash, 15f, 0.5f, 3f);
    CreateWeapon("Howl", WeaponType.AoE, 8f, 0.3f, 3f);
}

private static void CreateWeapon(string name, WeaponType type, float damage, float speed, float range)
{
    var weapon = ScriptableObject.CreateInstance<WeaponData>();
    weapon.weaponName = name;
    weapon.weaponType = type;
    weapon.baseDamage = damage;
    weapon.attackSpeed = speed;
    weapon.range = range;

    AssetDatabase.CreateAsset(weapon, $"Assets/ScriptableObjects/Weapons/Weapon_{name}.asset");
    AssetDatabase.SaveAssets();
}
```

### Running Editor Scripts from CLI
```bash
# Run a specific static method from command line
Unity -batchmode -projectPath /path/to/project -executeMethod SceneSetup.CreateDungeonScene -quit

# Run all setup methods
Unity -batchmode -projectPath /path/to/project -executeMethod ProjectSetup.RunAll -quit
```

## When To Use
- Creating initial scenes, prefabs, and ScriptableObject assets
- Any task that would normally require clicking through the Unity Editor
- Batch operations (creating multiple assets at once)
- Automating repetitive setup

## When NOT To Use
- Runtime game logic (Editor scripts don't exist in builds)
- Anything that requires visual positioning (tilemap painting, precise object placement)
- Tasks better done by hand in the Editor (one-off visual adjustments)

## Gotchas
- Editor scripts must be in `Assets/Editor/` or a folder with an Assembly Definition that targets Editor only.
- `AssetDatabase` operations are Editor-only. Never reference them from runtime code.
- When creating GameObjects programmatically, you can't add components that haven't been compiled yet. Build scripts incrementally — create base components first, then scripts that reference them.
- `-batchmode` mode has no GUI. Debug.Log output goes to the Editor.log file, not the console.
