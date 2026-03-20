# Agreement — T029: Loot & Weapon Drop System

**Status:** APPROVED
**Approved:** 2026-03-20

## Scope
Implement a loot drop system where enemies drop weapons and resources (Bones/Treats) on death, driven by configurable LootTable ScriptableObjects, with pickup components for weapons and resources, and 4 weapon type SO assets.

## Checkpoint Parameters
- LootTable SO defines possible drops with weights; configurable per enemy type with distinct drop rates (15% weapon, 50% bones for regulars; guaranteed bones + treats for bosses)
- LootDrop, WeaponPickup, and ResourcePickup components handle item spawning, visual bob animation, and auto-pickup on proximity
- 4 weapon types exist as SO assets: Bite (melee, balanced), Bark (ranged), Pounce (dash, high damage), Howl (AoE, medium damage)

## Out of Scope
- Weapon upgrades or crafting
- Inventory system (weapon swap replaces current weapon)
- Resource spending (Phase 5 Kennel)
- Loot rarity tiers or scaling

## Acceptance Criteria
- [ ] Regular enemies have a chance to drop weapons (15%) or bones (50%)
- [ ] Bosses always drop bones and treats
- [ ] Dropped items visually float and bob
- [ ] Walking over a drop picks it up automatically
- [ ] Weapon pickup replaces current weapon and shows weapon name briefly
- [ ] Resource pickup adds to run totals and shows "+X Bones" feedback
- [ ] 4 weapon types exist as SO assets with distinct stats
- [ ] LootTable is configurable per enemy type
