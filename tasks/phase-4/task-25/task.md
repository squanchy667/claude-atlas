# [T025] Passive Trait System

**Phase:** 4
**Status:** PENDING
**Complexity:** Low
**Estimated Scope:** 2 files, ~80 lines

## Objective
Implement passive traits that modify player stats at spawn time. Each character has one passive trait defined in their CharacterData. The PassiveTraitController reads PassiveTraitData and applies stat modifiers to the player's systems.

## Deliverables
- `PassiveTraitController.cs` — component that applies passive modifiers on initialization
- Malinois passive "Toughness": +20% max HP (applied to HealthSystem)
- Vizsla passive "Swiftness": +15% move speed (applied to PlayerController)

## Files Likely Touched
- `Scripts/Player/PassiveTraitController.cs` — new, reads PassiveTraitData and applies modifiers
- `Scripts/Player/PlayerController.cs` — add public method to modify base speed
- `Scripts/Combat/HealthSystem.cs` — ensure Initialize() can accept modified HP values

## Dependencies
- Depends On: T023 (PassiveTraitData SO must exist)
- Blocks: T026

## Acceptance Criteria
- [ ] Malinois starts with 144 HP (120 base * 1.2) instead of 120
- [ ] Vizsla starts with 8.05 move speed (7.0 base * 1.15) instead of 7.0
- [ ] Passive is applied once at spawn, not every frame
- [ ] PassiveTraitController reads from CharacterData reference

## Notes
- Keep it simple: stat modifiers applied during initialization only
- No runtime passive effects (those would be Phase 7 polish)
- HealthSystem.Initialize(int) already exists — just pass modified value
