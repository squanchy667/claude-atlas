# Agreement — T027: Enemy AI Expansion (6 Types)

**Status:** APPROVED
**Approved:** 2026-03-20

## Scope
Expand the existing EnemyController to support 6 distinct enemy types with unique AI behaviors driven by AttackPattern strategy dispatch, add EnemyProjectile and DamageZone components, implement visual attack tells, and create 6 EnemyData SO assets with tuned stats.

## Checkpoint Parameters
- 6 enemy behaviors implemented: Stray Mutt (Chase), Barker (Ranged), Armored Hound (Patrol), Pack Runner (Swarm), Shadow Dog (Teleport), Howler (AoE)
- Supporting components created: EnemyProjectile for Barker ranged attacks, DamageZone for Howler AoE zones
- Visual attack tells: white flash for light attacks, red flash for heavy attacks; all enemies use HealthSystem and fire GameEvents on death

## Out of Scope
- Boss fights (T028)
- Loot drops from enemies (T029)
- Enemy spawn balancing per floor (T030)
- Enemy animations or sprite art

## Acceptance Criteria
- [ ] All 6 enemy types exhibit distinct behavior
- [ ] Barker fires projectiles that deal damage on contact
- [ ] Armored Hound takes reduced damage from front (50%)
- [ ] Pack Runner moves 1.5x faster than base enemy speed
- [ ] Shadow Dog teleports within 2-unit radius of player, attacks, teleports back
- [ ] Howler creates damage zone that lasts 3 seconds
- [ ] Attack tells visible: white flash for light, red flash for heavy
- [ ] All enemies use HealthSystem and trigger GameEvents on death
