# T008: Combat Data ScriptableObjects
## Phase: 2 — Combat Core
## Status: PENDING
## Depends On: none
## Blocks: T010, T012

## Description
Define the foundational data types and ScriptableObject definitions for the combat system. These SOs will be read by all combat-related MonoBehaviours (weapon controllers, enemy AI, hit feedback) and must be created before any combat logic is implemented.

### Enums
- **WeaponType** — `Bite`, `Bark`, `Pounce`, `Howl`
- **AttackPattern** — `Chase`, `Ranged`, `Patrol`, `Swarm`, `Boss`

### WeaponData ScriptableObject
| Field | Type | Purpose |
|-------|------|---------|
| weaponName | string | Display name |
| weaponType | WeaponType | Category for logic branching |
| damage | float | Base damage per hit |
| attackSpeed | float | Attacks per second |
| range | float | Melee reach or projectile max distance |
| cooldown | float | Minimum seconds between attacks |
| knockback | float | Force applied to target on hit |
| knockbackFalloff | AnimationCurve | Knockback strength over distance |
| projectilePrefab | GameObject | Null for melee, assigned for ranged |

### EnemyData ScriptableObject
| Field | Type | Purpose |
|-------|------|---------|
| enemyName | string | Display name |
| health | float | Max HP |
| damage | float | Base contact/attack damage |
| moveSpeed | float | Movement speed |
| attackPattern | AttackPattern | AI behavior type |
| detectionRange | float | Distance to detect player |
| attackRange | float | Distance to start attacking |

### Conventions
- All SOs use `[CreateAssetMenu]` with `menuName = "DogPack/[Category]/[Type]"` (e.g., `DogPack/Combat/Weapon Data`, `DogPack/Enemies/Enemy Data`)
- All SOs use `fileName` defaults matching the type (e.g., `New WeaponData`, `New EnemyData`)

## Deliverables
- `Assets/Scripts/Combat/WeaponType.cs` — WeaponType enum
- `Assets/Scripts/Combat/WeaponData.cs` — WeaponData ScriptableObject
- `Assets/Scripts/Enemies/EnemyData.cs` — EnemyData ScriptableObject
- `Assets/Scripts/Enemies/AttackPattern.cs` — AttackPattern enum

## Acceptance Criteria
- WeaponType enum contains exactly 4 values: Bite, Bark, Pounce, Howl
- AttackPattern enum contains exactly 5 values: Chase, Ranged, Patrol, Swarm, Boss
- WeaponData inherits from ScriptableObject and has all 9 fields listed above with correct types
- EnemyData inherits from ScriptableObject and has all 7 fields listed above with correct types
- Both SOs have `[CreateAssetMenu]` with `menuName` following `DogPack/` convention
- knockbackFalloff field is of type AnimationCurve
- projectilePrefab field is of type GameObject (nullable reference)
- All files compile without errors
