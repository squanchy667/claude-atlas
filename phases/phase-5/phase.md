# Phase 5 — The Kennel (Base)

## Goal
Home base scene, rescued dog management (recruit from runs), role assignment system, building/upgrade system, resource economy (Bones + Treats), permanent meta-progression upgrades.

## Key Deliverables
- Kennel scene with walkable base area
- Dog rescue mechanic: find dogs during runs, they appear at Kennel after
- Dog roster UI: view all rescued dogs, assign roles
- 3 role types: Guard (+damage bonus via Training Yard), Forager (passive Bones/Treats income via Scavenger Den), Builder (construction speed only)
- 3 building types with 3 tiers each: Doghouse (capacity 5/10/15), Training Yard (Guard bonus +5/10/15% damage), Scavenger Den (Forager income 2/5/8 Bones)
- Failed run penalty: keep 70% of collected resources, lose 30%
- Resource economy: Bones (common, from enemies) and Treats (rare, from bosses/treasure)
- Permanent upgrade paths: health, damage, dodge speed, ability cooldown, kennel buildings
- MetaProgressionManager with JSON save/load
- Scene transition: Kennel → Dungeon run → Kennel

## Entry Criteria
- Phase 4 complete: full dungeon runs possible with characters and enemies

## Exit Criteria
- Player returns to Kennel after each run
- Dogs rescued during runs appear in roster
- Roles can be assigned and affect gameplay
- Buildings can be constructed and upgraded with resources
- Permanent upgrades persist between runs
- Save/load works correctly
- Resource economy feels balanced (runs yield meaningful progress)

## Dependencies
- Phase 4 (characters, enemies, complete runs)
