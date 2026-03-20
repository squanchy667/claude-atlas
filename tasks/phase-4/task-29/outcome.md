# Outcome — T029: Loot & Weapon Drop System

**Status:** DONE
**Date:** 2026-03-20

## What Was Built
Loot drop system with LootTable SO, weapon and resource pickups, 4 weapon types, auto-pickup, and visual bobbing.

## Deliverables
- [x] LootTable ScriptableObject with weighted entries
- [x] LootDrop base with sinusoidal bobbing and auto-pickup
- [x] WeaponPickup swaps player weapon
- [x] ResourcePickup adds Bones/Treats to RunManager
- [x] LootDropper static utility with default and boss loot
- [x] 4 weapon types: Bite (melee), Bark (ranged), Pounce (dash), Howl (AoE)
- [x] Regular enemies: 50% bones, 15% weapon
- [x] Bosses: guaranteed bones + treats + 50% weapon
- [x] RunManager tracks CollectedBones/CollectedTreats
- [x] WeaponController.SwapWeapon() method

## Files Changed
| File | Change |
|------|--------|
| Scripts/Loot/LootTable.cs | New SO definition |
| Scripts/Loot/LootDrop.cs | New — base drop behavior |
| Scripts/Loot/WeaponPickup.cs | New — weapon swap on pickup |
| Scripts/Loot/ResourcePickup.cs | New — resource collection |
| Scripts/Loot/LootDropper.cs | New — static drop spawning utility |
| Scripts/Core/RunManager.cs | Added resource tracking |
| Scripts/Combat/WeaponController.cs | Added SwapWeapon() |
| Scripts/Core/GameEvents.cs | Added loot events |
| Scripts/Enemies/EnemyController.cs | Added loot drop on death |

## Drift Events
None.
