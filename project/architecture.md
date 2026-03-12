# Architecture — DogPack Roguelite

## System Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    GameManager (Singleton)                    │
│                   DontDestroyOnLoad                          │
│  ┌──────────────┐ ┌────────────────────┐ ┌──────────────┐   │
│  │  RunManager   │ │MetaProgressionMgr  │ │ AudioManager │   │
│  └──────────────┘ └────────────────────┘ └──────────────┘   │
│  ┌──────────────┐ ┌────────────────────┐                     │
│  │PlayerManager  │ │   GameEvents       │                     │
│  └──────────────┘ └────────────────────┘                     │
└─────────────────────────────────────────────────────────────┘
          │                                     │
    ┌─────▼──────────────────┐    ┌────────────▼──────────────┐
    │    Dungeon Scene        │    │     Kennel Scene           │
    │  ┌──────────────────┐  │    │  ┌──────────────────────┐  │
    │  │DungeonGenerator   │  │    │  │  KennelManager       │  │
    │  │RoomManager        │  │    │  │  DogManager          │  │
    │  │CombatSystem       │  │    │  │  UpgradeManager      │  │
    │  │CameraController   │  │    │  │  UIManager (Kennel)  │  │
    │  │UIManager (HUD)    │  │    │  └──────────────────────┘  │
    │  └──────────────────┘  │    └────────────────────────────┘
    └────────────────────────┘
```

## Tech Stack

| Layer | Technology | Version | Reason |
|-------|-----------|---------|--------|
| Engine | Unity | 2022.3 LTS | Stable LTS, excellent 2D support, large community |
| Render Pipeline | 2D URP | — | Lightweight 2D rendering, supports shader effects for juice |
| Language | C# | — | Unity's primary language, strong typing, good tooling |
| Architecture | Singleton-Events-ScriptableObject | — | Proven "trinity" for mid-scale Unity games |
| Physics | Unity 2D Physics | — | Rigidbody2D + BoxCollider2D for movement and collision |
| Input | Unity Input System (new) | — | Native multi-device support, PlayerInputManager for co-op |
| Animation | Unity Animator | — | Blend trees for 8-directional movement, state machines for combat |
| UI | Canvas UI | — | Built-in, sufficient for game menus and HUD |
| Audio | Unity Audio | — | ScriptableObject-based sound bank pattern |
| Data | ScriptableObjects | — | Editor-friendly, type-safe, supports asset references |
| Tilemaps | Unity 2D Tilemap + Extras | — | Room layout construction with rule tiles |
| VCS | Git | — | Standard version control |

## Core Modules

### GameManager
- **Responsibility:** Root singleton that persists across scenes and manages game state transitions
- **Boundaries:** Owns high-level state (menu, playing, paused, game over). Does not handle gameplay logic directly.
- **Key files:** `Assets/Scripts/Core/GameManager.cs`
- **Public interface:** `StartRun()`, `EndRun()`, `ReturnToKennel()`, `PauseGame()`, `ResumeGame()`
- **Depends on:** RunManager, MetaProgressionManager, PlayerManager

### PlayerController
- **Responsibility:** Player movement, dodge roll, input handling, i-frames
- **Boundaries:** Owns player physics and input response. Does not handle combat damage or weapon logic.
- **Key files:** `Assets/Scripts/Player/PlayerController.cs`, `Assets/Scripts/Player/DodgeRoll.cs`
- **Public interface:** `Move(Vector2)`, `Dodge()`, `IsInvincible`, `CurrentState`
- **Depends on:** Input System, Physics

### CombatSystem
- **Responsibility:** Weapon attacks, hit detection, damage calculation, knockback
- **Boundaries:** Owns damage dealing and receiving. Does not own health display or death handling.
- **Key files:** `Assets/Scripts/Combat/`
- **Public interface:** `Attack()`, `TakeDamage(float, Vector2)`, `ApplyKnockback(Vector2, float)`
- **Depends on:** WeaponData (ScriptableObject), PlayerController, HealthSystem

### HealthSystem
- **Responsibility:** HP tracking, death detection, health UI updates
- **Boundaries:** Owns HP values. Does not handle damage source logic.
- **Key files:** `Assets/Scripts/Combat/HealthSystem.cs`
- **Public interface:** `TakeDamage(float)`, `Heal(float)`, `OnDeath` event, `CurrentHealth`
- **Depends on:** GameEvents

### DungeonGenerator
- **Responsibility:** Procedural floor assembly using pyramid/branching DAG structure
- **Boundaries:** Owns room placement and path branching. Does not own room content (enemies, loot).
- **Key files:** `Assets/Scripts/Dungeon/DungeonGenerator.cs`, `Assets/Scripts/Dungeon/FloorGraph.cs`
- **Public interface:** `GenerateFloor(int floorNumber)`, `GetCurrentRoom()`, `GetAvailablePaths()`, `OnRoomEntered` event
- **Depends on:** RoomTemplate (ScriptableObject)
- **Note:** Floors are DAGs — player starts at one room, chooses between branching paths, all paths converge at the boss room. Not a grid or free-roam layout.

### RoomManager
- **Responsibility:** Room state (enemies alive, doors locked/unlocked), enemy spawning
- **Boundaries:** Owns per-room state. Does not own room layout or procedural placement.
- **Key files:** `Assets/Scripts/Dungeon/RoomManager.cs`
- **Public interface:** `EnterRoom()`, `OnRoomCleared` event, `SpawnEnemies()`
- **Depends on:** EnemyData (ScriptableObject), DungeonGenerator

### EnemyAI
- **Responsibility:** Enemy behavior (chase, attack, patrol), boss patterns
- **Boundaries:** Owns enemy decision-making. Does not own damage calculation.
- **Key files:** `Assets/Scripts/Enemies/`
- **Public interface:** `SetTarget(Transform)`, `OnStateChanged` event
- **Depends on:** HealthSystem, CombatSystem

### KennelManager
- **Responsibility:** Base scene state, building placement, dog management
- **Boundaries:** Owns base-building logic. Does not own meta-progression math.
- **Key files:** `Assets/Scripts/Kennel/`
- **Public interface:** `BuildStructure(BuildingData)`, `AssignRole(Dog, Role)`, `GetDogRoster()`
- **Depends on:** MetaProgressionManager

### MetaProgressionManager
- **Responsibility:** Persistent upgrades, resource banking (Bones/Treats), save/load
- **Boundaries:** Owns all data that persists between runs. Does not own in-run state.
- **Key files:** `Assets/Scripts/Core/MetaProgressionManager.cs`
- **Public interface:** `SpendBones(int)`, `SpendTreats(int)`, `UnlockUpgrade(UpgradeData)`, `Save()`, `Load()`
- **Depends on:** JSON serialization

### CameraController
- **Responsibility:** Follow player(s), dynamic zoom for co-op, screen shake
- **Boundaries:** Owns camera transform. Does not own player positions.
- **Key files:** `Assets/Scripts/Camera/CameraController.cs`
- **Public interface:** `Shake(float intensity, float duration)`, `SetTargets(Transform[])`
- **Depends on:** PlayerManager

## Data Flow — Primary Use Case (Dungeon Run)

```
1. Player selects character → PlayerManager stores CharacterData
2. Player starts run → RunManager initializes RunState, loads Dungeon scene
3. DungeonGenerator builds floor as pyramid DAG → player sees branching paths ahead
4. Player chooses path → enters room → RoomManager locks doors, spawns enemies from EnemyData
5. Player attacks → CombatSystem checks WeaponData, applies damage via HealthSystem
6. Enemy dies → GameEvents.OnEnemyDefeated fires → RunManager tallies loot, AudioManager plays SFX
7. All enemies dead → RoomManager unlocks doors → player proceeds
8. Floor boss defeated → DungeonGenerator loads next floor (or triggers run victory)
9. Run ends → RunManager calculates rewards (failed runs keep 70%, lose 30%) → MetaProgressionManager banks Bones/Treats
10. Scene transitions to Kennel → player spends resources on UpgradeData
```

## Architectural Rules

1. **All game configuration lives in ScriptableObjects.** No magic numbers in MonoBehaviours. Character stats, weapon params, enemy data, upgrade costs — all ScriptableObject assets.
2. **Systems communicate through events, not direct references.** Use `GameEvents` static class. No system should hold a reference to another system's internal state.
3. **Singletons use a base class with DontDestroyOnLoad.** All manager singletons inherit from `Singleton<T>` and persist across scenes.
4. **No game logic in Update().** Use coroutines, state machines, or event callbacks. Update() is reserved for input polling and physics-adjacent work.
5. **Prefab rooms are self-contained.** Each room prefab includes its own tilemap, spawn points, and door positions. No external configuration at placement time.
6. **All combat parameters are AnimationCurve-tunable.** Knockback force, hitstop duration, screen shake intensity — exposed as AnimationCurves for designer tuning without code changes.

## Performance Assumptions

- Expected scale: Single player or 2-player local co-op, 5-8 rooms per floor, max ~20 enemies per room
- Designed ceiling: 60 FPS on mid-range hardware (GTX 1060 / M1 equivalent)
- First bottleneck: Enemy count per room (physics + AI ticks). Mitigated by capping at 20 enemies.
- Scaling strategy: Not applicable (local game, fixed scope)

## Security Posture

- **Authentication:** None (offline local game)
- **Authorization:** None
- **Secrets management:** None
- **Data sensitivity:** None (no PII, no network)
- **Network:** Localhost only (no network features)
