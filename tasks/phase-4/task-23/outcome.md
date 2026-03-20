# Outcome — T023: Character & Ability Data Models

**Status:** DONE
**Date:** 2026-03-20

## What Was Built
ScriptableObject data layer for playable characters, abilities, and passive traits. 6 concrete assets created.

## Deliverables
- [x] CharacterData SO with all fields (name, class, health, damage, speed, dodge, ability, passive, color)
- [x] AbilityData SO (name, type, cooldown, damage, range, duration, effectColor)
- [x] PassiveTraitData SO (name, modifierType, modifierValue)
- [x] CharacterClass enum (Brawler, Scout)
- [x] AbilityType enum (GroundSlam, DashStrike)
- [x] PassiveModifier enum (HealthBonus, SpeedBonus)
- [x] Malinois_Brawler asset (120HP, 1.2x dmg, 5 speed, Ground Slam, Toughness)
- [x] Vizsla_Scout asset (80HP, 1.0x dmg, 7 speed, Dash Strike, Swiftness)
- [x] Editor menu item for asset creation

## Files Changed
| File | Change |
|------|--------|
| Scripts/Player/CharacterData.cs | New SO definition |
| Scripts/Player/AbilityData.cs | New SO definition |
| Scripts/Player/PassiveTraitData.cs | New SO definition |
| Scripts/Player/CharacterClass.cs | New enum |
| Scripts/Player/AbilityType.cs | New enum |
| Scripts/Player/PassiveModifier.cs | New enum |
| Editor/SceneSetup.cs | Added CreateCharacterAssets() menu item |

## Drift Events
None.
