# Agreement — T023: Character & Ability Data Models

**Status:** APPROVED
**Approved:** 2026-03-20

## Scope
Define the ScriptableObject data layer for playable characters, active abilities, and passive traits, and create concrete SO assets for Malinois (Brawler) and Vizsla (Scout) with their respective ability and passive references.

## Checkpoint Parameters
- CharacterData, AbilityData, and PassiveTraitData ScriptableObjects defined with all required fields and [CreateAssetMenu] attributes
- Enums created: CharacterClass (Brawler, Scout), AbilityType (GroundSlam, DashStrike), PassiveModifier (HealthBonus, SpeedBonus)
- 6 SO assets created: 2 CharacterData (Malinois_Brawler, Vizsla_Scout), 2 AbilityData (Ability_GroundSlam, Ability_DashStrike), 2 PassiveTraitData (Passive_Toughness, Passive_Swiftness)

## Out of Scope
- Ability execution logic (T024)
- Passive trait application logic (T025)
- Character selection UI (T026)
- Sprite art — placeholder colors only (Malinois=brown, Vizsla=golden)

## Acceptance Criteria
- [ ] CharacterData SO has all fields from data-model.md (characterName, characterClass, baseHealth, baseDamage, moveSpeed, dodgeSpeed, dodgeDuration, activeAbility, passiveTrait)
- [ ] AbilityData SO defines ability parameters (type, cooldown, damage, range, duration)
- [ ] PassiveTraitData SO defines modifier (type, value)
- [ ] 2 character assets exist with distinct stats (Malinois: high HP/damage, low speed; Vizsla: low HP, high speed/dodge)
- [ ] All SOs use [CreateAssetMenu] attribute
