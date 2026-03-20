# [T029] Loot & Weapon Drop System

**Phase:** 4
**Status:** PENDING
**Complexity:** Medium
**Estimated Scope:** 5 files, ~200 lines

## Objective
Implement a loot drop system where enemies drop weapons and resources (Bones/Treats) on death. Create a LootTable ScriptableObject, a drop spawning system, and pickup components for weapons and resources.

## Deliverables
- `LootTable.cs` ScriptableObject — defines possible drops with weights
- `LootDrop.cs` — component for dropped items (floats, bobs, auto-pickup on proximity)
- `WeaponPickup.cs` — dropped weapon that replaces player's current weapon
- `ResourcePickup.cs` — Bones/Treats that add to RunState
- Weapon drop: 4 weapon types (Bite, Bark, Pounce, Howl) with SO assets
- Resource drop: Bones (common), Treats (rare, boss only)
- Visual: dropped items have color-coded sprites and slight bounce animation
- Integration with EnemyController death event

## Files Likely Touched
- `Scripts/Loot/LootTable.cs` — new SO, drop definitions
- `Scripts/Loot/LootDrop.cs` — new, base drop behavior (bob, proximity pickup)
- `Scripts/Loot/WeaponPickup.cs` — new, weapon swap on pickup
- `Scripts/Loot/ResourcePickup.cs` — new, resource collection
- `Scripts/Enemies/EnemyController.cs` — trigger loot drop on death
- `Scripts/Combat/WeaponData.cs` — create 3 additional weapon assets (Bark, Pounce, Howl)
- `Scripts/Core/GameEvents.cs` — add OnWeaponPickup, OnResourceCollected events

## Dependencies
- Depends On: T027 (enemies must die to drop loot)
- Blocks: T030

## Acceptance Criteria
- [ ] Regular enemies have a chance to drop weapons (15%) or bones (50%)
- [ ] Bosses always drop bones and treats
- [ ] Dropped items visually float and bob
- [ ] Walking over a drop picks it up automatically
- [ ] Weapon pickup replaces current weapon and shows weapon name briefly
- [ ] Resource pickup adds to run totals and shows "+X Bones" feedback
- [ ] 4 weapon types exist as SO assets with distinct stats
- [ ] LootTable is configurable per enemy type

## Notes
- Weapon types: Bite (melee, balanced), Bark (ranged, lower damage), Pounce (dash, high damage, slow), Howl (AoE, medium damage, long cooldown)
- Bark weapon: fires projectile reusing EnemyProjectile pattern but player-owned
- Pounce weapon: short dash + hit, similar to Dash Strike ability
- Howl weapon: AoE around player, similar to Ground Slam but weaker
- Drop bob: sinusoidal Y offset, 0.3 units amplitude, auto-pickup within 1.5 units
- Resources tracked in RunManager (add collectedBones/collectedTreats fields)
