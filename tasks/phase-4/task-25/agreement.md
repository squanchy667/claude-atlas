# Agreement — T025: Passive Trait System

**Status:** APPROVED
**Approved:** 2026-03-20

## Scope
Implement passive traits that modify player stats at spawn time by reading PassiveTraitData from CharacterData, with two concrete passives: Toughness (+20% max HP for Malinois) and Swiftness (+15% move speed for Vizsla).

## Checkpoint Parameters
- PassiveTraitController component reads PassiveTraitData from CharacterData and applies stat modifiers once at initialization
- Malinois Toughness passive applies correctly (120 base HP * 1.2 = 144 HP)
- Vizsla Swiftness passive applies correctly (7.0 base speed * 1.15 = 8.05 speed)

## Out of Scope
- Runtime passive effects or buffs/debuffs
- Stacking passives or multiple passives per character
- Passive upgrades (Phase 7 polish)
- UI display of passive effects

## Acceptance Criteria
- [ ] Malinois starts with 144 HP (120 base * 1.2) instead of 120
- [ ] Vizsla starts with 8.05 move speed (7.0 base * 1.15) instead of 7.0
- [ ] Passive is applied once at spawn, not every frame
- [ ] PassiveTraitController reads from CharacterData reference
