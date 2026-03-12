# Agreement — T008: Combat Data ScriptableObjects
## Status: APPROVED
## Approved: 2026-03-12 (auto-approved by atlas-run --full-permission)

## Scope
- Create WeaponType enum (Bite, Bark, Pounce, Howl) in `Assets/Scripts/Combat/WeaponType.cs`
- Create AttackPattern enum (Chase, Ranged, Patrol, Swarm, Boss) in `Assets/Scripts/Enemies/AttackPattern.cs`
- Create WeaponData ScriptableObject with 9 fields (weaponName, weaponType, damage, attackSpeed, range, cooldown, knockback, knockbackFalloff AnimationCurve, projectilePrefab GameObject) in `Assets/Scripts/Combat/WeaponData.cs`
- Create EnemyData ScriptableObject with 7 fields (enemyName, health, damage, moveSpeed, attackPattern, detectionRange, attackRange) in `Assets/Scripts/Enemies/EnemyData.cs`
- Both SOs use `[CreateAssetMenu]` with `menuName = "DogPack/[Category]/[Type]"` convention

## Not In Scope
- Actual ScriptableObject asset instances (those are created during integration task T014)
- Any MonoBehaviour logic that reads these SOs
- Projectile prefab implementation
- Animation or visual assets
- Runtime stat modification or buff systems

## Checkpoint Parameters
- All 4 files exist at the specified paths and compile without errors
- WeaponType has exactly 4 values; AttackPattern has exactly 5 values
- WeaponData has all 9 serialized fields with correct types (including AnimationCurve and GameObject)
- EnemyData has all 7 serialized fields with correct types
- `[CreateAssetMenu]` attributes present on both SOs with DogPack/ menu paths

## Skills Used
- ScriptableObject data pattern
- Unity project structure conventions

## Risks
- None significant; this is pure data definition with no runtime logic
