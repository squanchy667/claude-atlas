# Singleton-Events-ScriptableObject Pattern

**Tier:** Foundation
**Category:** Architecture
**Created:** 2026-03-11
**Status:** Active

## What It Solves
Defines the core architectural pattern for the project: how managers are accessed (singletons), how systems communicate (events), and how data is configured (ScriptableObjects). This is the "trinity" pattern that prevents spaghetti references and enables decoupled systems.

## Approach

### Singleton Base Class
```csharp
public abstract class Singleton<T> : MonoBehaviour where T : MonoBehaviour
{
    public static T Instance { get; private set; }

    protected virtual void Awake()
    {
        if (Instance != null && Instance != this)
        {
            Destroy(gameObject);
            return;
        }
        Instance = (T)this;
        DontDestroyOnLoad(gameObject);
    }
}
```
- All managers inherit from `Singleton<T>`.
- Only use for true manager classes: GameManager, RunManager, AudioManager, MetaProgressionManager, PlayerManager.
- Do NOT make everything a singleton. Room-level and entity-level components are regular MonoBehaviours.

### GameEvents (Static Event Bus)
```csharp
public static class GameEvents
{
    // Combat
    public static event Action<GameObject, float> OnDamageTaken;
    public static event Action<GameObject> OnEnemyDefeated;
    public static event Action<GameObject> OnPlayerDeath;

    // Run
    public static event Action<int> OnFloorStarted;
    public static event Action OnRunComplete;
    public static event Action OnRunFailed;

    // Room
    public static event Action<RoomTemplate> OnRoomEntered;
    public static event Action OnRoomCleared;

    // Resources
    public static event Action<int> OnBonesCollected;
    public static event Action<int> OnTreatsCollected;
    public static event Action<DogData> OnDogRescued;

    // Invoke methods (only the owning system calls these)
    public static void DamageTaken(GameObject target, float amount) => OnDamageTaken?.Invoke(target, amount);
    public static void EnemyDefeated(GameObject enemy) => OnEnemyDefeated?.Invoke(enemy);
    // ... etc
}
```
- Events are the ONLY way systems communicate. No system holds a reference to another system's internal state.
- Each event has a clear owner (the system that invokes it).
- Subscribers handle null checks via `?.Invoke()`.

### ScriptableObject Data
- All game-tunable values live in ScriptableObjects, not in MonoBehaviour inspectors.
- MonoBehaviours reference ScriptableObjects to get their configuration.
- Example: `PlayerController` has a `CharacterData characterData` field, not individual `float moveSpeed`, `int health` fields.

## When To Use
- Creating any new manager class → inherit from Singleton<T>
- Any time system A needs to react to something in system B → use GameEvents
- Any time you need configurable game data → create a ScriptableObject

## When NOT To Use
- Don't make a singleton for per-entity components (enemies, projectiles, room instances)
- Don't use events for parent-child communication within the same prefab (direct reference is fine)
- Don't put runtime-mutable state in ScriptableObjects (they reset between play sessions in Editor)

## Gotchas
- Singleton race conditions: if two singletons depend on each other in Awake(), use `[DefaultExecutionOrder]` to control initialization order.
- Event memory leaks: always unsubscribe from GameEvents in `OnDestroy()`. Scene-scoped objects WILL leak if they subscribe without unsubscribing.
- ScriptableObject shared state: if you modify a ScriptableObject at runtime, ALL references see the change. Use runtime copies (`Instantiate(data)`) for mutable per-instance data.
