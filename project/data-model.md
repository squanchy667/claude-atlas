# Data Model — DogPack Roguelite

## ScriptableObject Entities (Static Data)

### CharacterData

| Field | Type | Required | Description | Constraints |
|-------|------|----------|-------------|-------------|
| characterName | string | Yes | Display name (e.g., "Rex", "Luna", "Biscuit") | Unique |
| characterClass | CharacterClass enum | Yes | Brawler, Scout, or Support | One of 3 values |
| baseHealth | int | Yes | Starting HP | Min 1 |
| baseDamage | float | Yes | Base attack multiplier | Min 0.1 |
| moveSpeed | float | Yes | Movement speed | Min 1 |
| dodgeSpeed | float | Yes | Dodge roll velocity | Min 1 |
| dodgeDuration | float | Yes | I-frame duration during dodge (seconds) | 0.1–1.0 |
| activeAbility | AbilityData | Yes | Reference to unique ability SO | Must exist |
| passiveTrait | PassiveTraitData | Yes | Reference to passive trait SO | Must exist |
| sprites | SpriteSet | Yes | 8-directional sprite references | All 8 directions required |

### WeaponData

| Field | Type | Required | Description | Constraints |
|-------|------|----------|-------------|-------------|
| weaponName | string | Yes | Display name | Unique |
| weaponType | WeaponType enum | Yes | Bite, Bark, Pounce, or Howl | One of 4 values |
| baseDamage | float | Yes | Damage value | Min 0 |
| attackSpeed | float | Yes | Attacks per second | Min 0.1 |
| range | float | Yes | Attack reach (world units) | Min 0.5 |
| cooldown | float | Yes | Time between attacks (seconds) | Min 0 |
| knockback | float | Yes | Knockback force applied to target | Min 0 |
| projectilePrefab | GameObject | No | For ranged weapons only | Null for melee |
| attackAnimation | AnimationClip | Yes | Animation to play on attack | Must exist |

### EnemyData

| Field | Type | Required | Description | Constraints |
|-------|------|----------|-------------|-------------|
| enemyName | string | Yes | Display name | Unique |
| health | int | Yes | Hit points | Min 1 |
| damage | float | Yes | Contact/attack damage | Min 0 |
| moveSpeed | float | Yes | Movement speed | Min 0 |
| attackPattern | AttackPattern enum | Yes | Chase, Ranged, Patrol, Swarm, Boss | One of 5 values |
| detectionRange | float | Yes | Aggro radius (world units) | Min 1 |
| attackRange | float | Yes | Distance to initiate attack | Min 0.5 |
| lootTable | LootTable | Yes | What drops on death | Must exist |
| sprites | SpriteSet | Yes | Visual references | All required |
| floorAppearance | int[] | Yes | Which floors this enemy appears on | Values 1-3 |

### RoomTemplate

| Field | Type | Required | Description | Constraints |
|-------|------|----------|-------------|-------------|
| roomType | RoomType enum | Yes | Combat, Treasure, Shop, Boss, Start, Corridor | One of 6 values |
| tilemap | Tilemap | Yes | Room layout | Must exist |
| spawnPoints | Vector2[] | Yes | Enemy spawn locations | Min 0 |
| doorPositions | DoorConfig[] | Yes | Door locations and directions | Min 1 |
| minEnemies | int | Yes | Minimum enemies to spawn | Min 0 |
| maxEnemies | int | Yes | Maximum enemies to spawn | Min >= minEnemies |
| enemyPool | EnemyData[] | No | Allowed enemy types for this room | Null for non-combat rooms |
| floorLevel | int | Yes | Which floor this room is for | 1-3 |

### UpgradeData

| Field | Type | Required | Description | Constraints |
|-------|------|----------|-------------|-------------|
| upgradeName | string | Yes | Display name | Unique |
| description | string | Yes | What it does | — |
| category | UpgradeCategory enum | Yes | Health, Damage, DodgeSpeed, AbilityCooldown, KennelBuilding | One of 5 values |
| tier | int | Yes | Upgrade level | 1-3 |
| boneCost | int | Yes | Bones required | Min 0 |
| treatCost | int | Yes | Treats required | Min 0 |
| prerequisite | UpgradeData | No | Previous tier upgrade required | Null for tier 1 |
| statModifier | float | Yes | Amount to modify the stat | — |

## Runtime Entities (In-Memory)

### DogData

| Field | Type | Required | Description | Constraints |
|-------|------|----------|-------------|-------------|
| dogName | string | Yes | Generated name | — |
| breed | string | Yes | Visual variety identifier | — |
| role | DogRole enum | Yes | None, Guard, Forager, Builder | Default: None |
| happiness | int | Yes | Affects role efficiency | 0-100 |
| rescuedOnFloor | int | Yes | Which floor they were found on | 1-3 |

### RunState

| Field | Type | Required | Description | Constraints |
|-------|------|----------|-------------|-------------|
| currentFloor | int | Yes | Current floor number | 1-3 |
| roomsCleared | int | Yes | Rooms completed this floor | Min 0 |
| totalRooms | int | Yes | Total rooms on this floor | 5-8 |
| collectedBones | int | Yes | Bones earned this run | Min 0 |
| collectedTreats | int | Yes | Treats earned this run | Min 0 |
| rescuedDogs | List\<DogData\> | Yes | Dogs rescued this run | — |
| equippedWeapon | WeaponData | Yes | Current weapon | Must exist |
| currentHealth | int | Yes | Player's current HP | Min 0 |

## Persisted State (JSON)

### MetaProgressionSave

| Field | Type | Required | Description | Constraints |
|-------|------|----------|-------------|-------------|
| totalBones | int | Yes | Banked Bones currency | Min 0 |
| totalTreats | int | Yes | Banked Treats currency | Min 0 |
| unlockedUpgrades | string[] | Yes | IDs of purchased upgrades | — |
| dogRoster | DogData[] | Yes | All rescued dogs | — |
| buildingsBuilt | string[] | Yes | IDs of constructed buildings | — |
| runsCompleted | int | Yes | Total successful runs | Min 0 |
| runsAttempted | int | Yes | Total runs started | Min 0 |

## Relationships

```
CharacterData ──1:1──▶ AbilityData
CharacterData ──1:1──▶ PassiveTraitData
RoomTemplate  ──1:N──▶ EnemyData (via enemyPool)
EnemyData     ──1:1──▶ LootTable ──1:N──▶ WeaponData, Resources
UpgradeData   ──1:1──▶ UpgradeData (prerequisite chain, self-referencing)
DogData       ──N:1──▶ DogRole
MetaProgressionSave ──1:N──▶ UpgradeData (via IDs)
MetaProgressionSave ──1:N──▶ DogData (roster)
```

## Entity Relationship Diagram

```
┌──────────────┐       ┌──────────────┐
│ CharacterData │──1:1──│  AbilityData  │
│              │──1:1──│PassiveTraitData│
└──────────────┘       └──────────────┘

┌──────────────┐       ┌──────────────┐       ┌──────────────┐
│ RoomTemplate  │──N:M──│  EnemyData    │──1:1──│  LootTable   │
└──────────────┘       └──────────────┘       └──────────────┘
                                                      │
                                                     1:N
                                                      │
                                               ┌──────────────┐
                                               │  WeaponData   │
                                               └──────────────┘

┌──────────────┐       ┌──────────────┐
│ UpgradeData   │──1:1──│ UpgradeData   │ (prerequisite)
└──────────────┘       └──────────────┘

┌────────────────────┐       ┌──────────────┐
│MetaProgressionSave  │──1:N──│   DogData     │
└────────────────────┘       └──────────────┘
```

## Invariants

1. Every `UpgradeData` at tier > 1 must have a non-null prerequisite pointing to the same category at tier - 1.
2. Every `RoomTemplate` of type Combat must have at least 1 spawn point and a non-empty enemy pool.
3. `MetaProgressionSave.totalBones` and `totalTreats` can never go negative.
4. A `DogData` can only be assigned one role at a time.
5. `RunState.currentFloor` must be between 1 and 3 inclusive.
6. Every `RoomTemplate` must have at least one door position.
