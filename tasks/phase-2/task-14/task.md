# T014: Combat Test Scene Integration
## Phase: 2 — Combat Core
## Status: PENDING
## Depends On: T008, T009, T010, T011, T012, T013
## Blocks: none

## Description
Update the existing test scene infrastructure from Phase 1 to integrate all Phase 2 combat systems. This task wires everything together for a playable combat test: the player can attack enemies, enemies fight back, health bars work, and hit feedback is visible. All test assets are created programmatically in SceneSetup.cs.

### SceneSetup.cs Updates
Add to the existing SceneSetup.cs (from Phase 1 T007) the following:

**Test WeaponData (Bite):**
- Create a WeaponData SO instance at runtime (`ScriptableObject.CreateInstance<WeaponData>()`)
- Stats: damage=10, attackSpeed=2, range=1.5f, cooldown=0.5f, knockback=5f, weaponType=Bite
- knockbackFalloff: default linear curve

**Player Combat Setup:**
- Add WeaponController component to player GameObject
- Assign test WeaponData to WeaponController
- Add HealthSystem component (maxHealth=100)
- Create attack point child Transform on player
- Add DamageFlash and Knockback components

**Test Enemy Prefab:**
- Create enemy GameObject programmatically with: SpriteRenderer (red square), Rigidbody2D (Dynamic, freeze rotation), BoxCollider2D, HealthSystem (maxHealth=30), EnemyController, DamageFlash, Knockback
- Create a test EnemyData SO instance: health=30, damage=5, moveSpeed=3, attackPattern=Chase, detectionRange=8, attackRange=1.5f
- Assign EnemyData to EnemyController
- Set enemy on "Enemy" layer for attack layer mask

**Enemy Spawning:**
- Spawn 3 test enemies at predefined positions within the test room
- Positions spread around the room (e.g., (3,3), (-3,2), (0,-3))

**Health Bar UI:**
- Create a Screen Space - Overlay Canvas programmatically
- Add a Slider as health bar
- Add PlayerHealthUI component, wire to player's HealthSystem

**HitstopManager:**
- Create HitstopManager singleton in the scene

### Layer Setup
- Ensure "Enemy" layer exists (or use a layer index) for attack layer mask filtering

## Deliverables
- Updated `Assets/Scripts/Core/SceneSetup.cs` — Extended with combat test setup
- Functional combat test: player attacks enemies, enemies chase and attack player, health bars update, hit feedback plays

## Acceptance Criteria
- SceneSetup.cs creates test WeaponData SO at runtime with Bite stats
- Player has WeaponController, HealthSystem, DamageFlash, Knockback components
- 3 test enemies spawn in the room with EnemyController, HealthSystem, EnemyData
- Enemies chase and attack the player
- Player can attack and damage enemies
- Health bar UI displays and updates with player health
- Hit feedback (flash, knockback, hitstop) triggers on damage
- HitstopManager singleton exists in scene
- All setup is programmatic (no pre-built prefabs or assets required)
- Scene is playable: enter Play mode and test combat immediately
