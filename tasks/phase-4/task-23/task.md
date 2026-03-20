# [T023] Character & Ability Data Models

**Phase:** 4
**Status:** PENDING
**Complexity:** Medium
**Estimated Scope:** 5 files, ~200 lines

## Objective
Define the ScriptableObject data layer for playable characters, active abilities, and passive traits. Create concrete assets for Malinois (Brawler) and Vizsla (Scout) with their ability/passive references.

## Deliverables
- `CharacterData.cs` ScriptableObject with stats, ability reference, passive reference, sprite color
- `AbilityData.cs` ScriptableObject with ability type, cooldown, damage, range, duration
- `PassiveTraitData.cs` ScriptableObject with modifier type, modifier value
- `CharacterClass` enum (Brawler, Scout)
- `AbilityType` enum (GroundSlam, DashStrike)
- `PassiveModifier` enum (HealthBonus, SpeedBonus)
- 2 CharacterData assets: Malinois_Brawler, Vizsla_Scout
- 2 AbilityData assets: Ability_GroundSlam, Ability_DashStrike
- 2 PassiveTraitData assets: Passive_Toughness, Passive_Swiftness

## Files Likely Touched
- `Scripts/Player/CharacterData.cs` — new SO definition
- `Scripts/Player/AbilityData.cs` — new SO definition
- `Scripts/Player/PassiveTraitData.cs` — new SO definition
- `ScriptableObjects/Characters/` — new asset files (created via Editor script)
- `Editor/SceneSetup.cs` — add asset creation methods

## Dependencies
- Depends On: None
- Blocks: T024, T025, T026

## Acceptance Criteria
- [ ] CharacterData SO has all fields from data-model.md (characterName, characterClass, baseHealth, baseDamage, moveSpeed, dodgeSpeed, dodgeDuration, activeAbility, passiveTrait)
- [ ] AbilityData SO defines ability parameters (type, cooldown, damage, range, duration)
- [ ] PassiveTraitData SO defines modifier (type, value)
- [ ] 2 character assets exist with distinct stats (Malinois: high HP/damage, low speed; Vizsla: low HP, high speed/dodge)
- [ ] All SOs use [CreateAssetMenu] attribute

## Notes
- Malinois: 120 HP, 1.2x damage, 5.0 speed, 7.0 dodge speed, 0.3s dodge duration, Ground Slam ability, +20% HP passive
- Vizsla: 80 HP, 1.0x damage, 7.0 speed, 9.0 dodge speed, 0.35s dodge duration, Dash Strike ability, +15% speed passive
- Sprites field deferred (placeholder colors for now: Malinois=brown, Vizsla=golden)
