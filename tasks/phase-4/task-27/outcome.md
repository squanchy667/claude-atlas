# Outcome — T027: Enemy AI Expansion (6 Types)

**Status:** DONE
**Date:** 2026-03-20

## What Was Built
Refactored EnemyController with 6 distinct AI behaviors, projectile system, AoE damage zones, and visual attack tells.

## Deliverables
- [x] Stray Mutt (Chase) — melee chaser, light attack
- [x] Barker (Ranged) — stationary, fires projectiles, maintains distance
- [x] Armored Hound (Patrol) — slow, frontal shield (50% damage reduction)
- [x] Pack Runner (Swarm) — 1.5x speed, flanking behavior
- [x] Shadow Dog (Teleport) — teleport near player, attack, teleport back
- [x] Howler (AoE) — places damage zones at player position from distance
- [x] EnemyProjectile for ranged attacks
- [x] DamageZone for AoE ground hazards
- [x] Attack tells: white flash (light), red flash (heavy)
- [x] All enemies use HealthSystem and fire GameEvents on death

## Files Changed
| File | Change |
|------|--------|
| Scripts/Enemies/EnemyController.cs | Major refactor — pattern-based behavior dispatch |
| Scripts/Enemies/EnemyProjectile.cs | New — ranged projectile |
| Scripts/Enemies/DamageZone.cs | New — AoE ground zone |
| Scripts/Enemies/AttackPattern.cs | Added Teleport, AoE enum values |
| Scripts/Enemies/EnemyData.cs | Added isHeavyAttack, projectileSpeed, specialCooldown |

## Drift Events
None.
