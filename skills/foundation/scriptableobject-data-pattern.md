# ScriptableObject Data Pattern

**Tier:** Foundation
**Category:** Data
**Created:** 2026-03-11
**Status:** Active

## What It Solves
Establishes the convention for defining, creating, and using ScriptableObjects as the data layer for all game configuration. Prevents magic numbers, enables designer-friendly tuning, and supports the asset-swap workflow for placeholder art.

## Approach

### Defining a ScriptableObject
```csharp
[CreateAssetMenu(fileName = "New Weapon", menuName = "DogPack/Weapons/WeaponData")]
public class WeaponData : ScriptableObject
{
    [Header("Identity")]
    public string weaponName;
    public WeaponType weaponType;

    [Header("Stats")]
    public float baseDamage;
    public float attackSpeed;
    public float range;
    public float cooldown;
    public float knockback;

    [Header("References")]
    public GameObject projectilePrefab;  // null for melee
    public AnimationClip attackAnimation;

    [Header("Tuning")]
    public AnimationCurve knockbackFalloff;  // force vs distance
}
```

### Conventions
1. **Menu path:** All SOs use `DogPack/[Category]/[TypeName]` for the CreateAssetMenu.
2. **Headers:** Group related fields with `[Header("Section")]`.
3. **Tooltips:** Add `[Tooltip("...")]` for non-obvious fields.
4. **AnimationCurves:** Use for any value that needs designer tuning (knockback, difficulty scaling, screen shake).
5. **Asset naming:** `{Type}_{Name}` (e.g., `Weapon_Bite`, `Enemy_Chaser`, `Character_Rex`).

### Using ScriptableObjects in MonoBehaviours
```csharp
public class WeaponController : MonoBehaviour
{
    [SerializeField] private WeaponData weaponData;

    public void Attack()
    {
        // Read from SO, never hardcode
        float damage = weaponData.baseDamage;
        float range = weaponData.range;
        // ...
    }
}
```

### Runtime Copies
When a ScriptableObject's values might change at runtime (e.g., applying upgrades to character stats):
```csharp
private CharacterData runtimeStats;

void Start()
{
    runtimeStats = Instantiate(baseCharacterData); // creates a runtime copy
    ApplyUpgrades(runtimeStats);
}
```

## When To Use
- Defining any game data: characters, weapons, enemies, upgrades, rooms, loot tables, sound banks
- Any numeric value that a designer might want to tune
- Any reference that might change (sprite, animation, prefab)

## When NOT To Use
- Runtime-only state (current health, position, active buffs) — use regular C# classes or structs
- One-off configuration that will never change — a const in code is fine

## Gotchas
- ScriptableObjects persist changes made in Play Mode in the Editor. This is useful for tuning but dangerous if you accidentally modify them in code without `Instantiate()`.
- Large arrays in ScriptableObjects can cause serialization overhead. For truly large datasets, consider JSON or binary files.
- ScriptableObject references in prefabs: if a prefab references a SO and the SO is deleted, Unity leaves a null reference that compiles but crashes at runtime. Always validate references.
