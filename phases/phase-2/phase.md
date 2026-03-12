# Phase 2 — Combat Core

## Goal
Weapon system (4 types as ScriptableObjects), attack animations, hit detection, damage system, health system with UI, enemy AI (basic chase + attack), hit feedback (screen shake, flash, knockback). Player can fight enemies in a test room.

## Key Deliverables
- WeaponData ScriptableObject with 4 weapon types (Bite, Bark, Pounce, Howl)
- Attack system with hit detection (melee collider, projectile for ranged)
- HealthSystem component with damage, healing, death
- Health bar UI (player HUD)
- Basic enemy AI: chase player, attack when in range
- EnemyData ScriptableObject
- Hit feedback: screen shake, sprite flash, knockback force
- Hitstop (brief pause on hit for impact feel)
- At least 1 test enemy with chase + attack pattern

## Entry Criteria
- Phase 1 complete: player can move and dodge in a test room

## Exit Criteria
- Player can attack with at least one weapon type
- Enemies chase and attack the player
- Damage is applied correctly (player and enemy)
- Health bars display and update in real time
- Hit feedback is visible (shake, flash, knockback)
- Player can die (game over state)
- Enemy can die (removed from scene)

## Dependencies
- Phase 1 (player controller, input system, camera)
