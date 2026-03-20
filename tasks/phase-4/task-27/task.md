# [T027] Enemy AI Expansion (6 Types)

**Phase:** 4
**Status:** PENDING
**Complexity:** High
**Estimated Scope:** 6 files, ~400 lines

## Objective
Expand the existing EnemyController to support 6 distinct enemy types with unique AI behaviors. Each enemy type has a different AttackPattern that drives its behavior in combat. Add visual attack tells (white spark for light attacks, red spark for heavy attacks).

## Deliverables
- Refactored EnemyController with strategy-based AI dispatch
- 6 enemy behaviors:
  - **Stray Mutt** (Chase) — existing behavior, polish. Melee chaser, light attack.
  - **Barker** (Ranged) — stationary, fires projectile at player. Light attack.
  - **Armored Hound** (Patrol) — patrols area, shielded from front (reduced frontal damage). Heavy attack.
  - **Pack Runner** (Swarm) — fast, low HP, spawns in groups, flanks. Light attack.
  - **Shadow Dog** (Teleport) — teleports near player, attacks, teleports away. Heavy attack.
  - **Howler** (AoE) — stands at distance, creates damaging zone on ground. Heavy attack.
- `EnemyProjectile.cs` — simple projectile for Barker
- `DamageZone.cs` — timed area damage for Howler
- Visual attack tells: brief color flash before attack (white = light, red = heavy)
- 6 EnemyData SO assets with tuned stats per floor

## Files Likely Touched
- `Scripts/Enemies/EnemyController.cs` — refactor to dispatch behavior by AttackPattern
- `Scripts/Enemies/EnemyProjectile.cs` — new, ranged projectile
- `Scripts/Enemies/DamageZone.cs` — new, AoE ground zone
- `Scripts/Enemies/AttackPattern.cs` — add Teleport and AoE enum values
- `Scripts/Enemies/EnemyData.cs` — add attackTellColor, isHeavyAttack fields
- `Editor/SceneSetup.cs` — add EnemyData asset creation

## Dependencies
- Depends On: None (builds on existing EnemyController from Phase 2)
- Blocks: T028, T029, T030

## Acceptance Criteria
- [ ] All 6 enemy types exhibit distinct behavior
- [ ] Barker fires projectiles that deal damage on contact
- [ ] Armored Hound takes reduced damage from front (50%)
- [ ] Pack Runner moves 1.5x faster than base enemy speed
- [ ] Shadow Dog teleports within 2-unit radius of player, attacks, teleports back
- [ ] Howler creates damage zone that lasts 3 seconds
- [ ] Attack tells visible: white flash for light, red flash for heavy
- [ ] All enemies use HealthSystem and trigger GameEvents on death

## Notes
- AttackPattern enum needs 2 new values: Teleport, AoE
- Keep EnemyController as single class with behavior switch, not separate subclasses (simpler for SO-driven spawning)
- Projectile: simple GO with Rigidbody2D, constant velocity, destroys on contact or after 3s
- Damage zone: circle sprite with collider, deals damage per tick (0.5s), destroys after duration
