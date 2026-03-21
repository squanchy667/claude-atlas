# Outcome — T031: Kennel Data Models

**Status:** DONE
**Date:** 2026-03-20

## What Was Built
ScriptableObject and serializable data models for the Kennel meta-progression system: dog data, roles, upgrades, buildings, save state, and a procedural dog name generator.

## Deliverables
- [x] DogData SO with name, role, stats, sprite fields
- [x] DogRole enum (Fighter, Healer, Scout, Guardian)
- [x] UpgradeData SO with name, category, tiers, costs
- [x] UpgradeCategory enum for upgrade classification
- [x] BuildingData SO with name, description, upgrade references
- [x] MetaProgressionSave serializable class for JSON persistence
- [x] DogNameGenerator utility for procedural dog naming

## Files Changed
| File | Change |
|------|--------|
| Scripts/Kennel/DogData.cs | New SO definition |
| Scripts/Kennel/DogRole.cs | New enum |
| Scripts/Kennel/UpgradeData.cs | New SO definition |
| Scripts/Kennel/UpgradeCategory.cs | New enum |
| Scripts/Kennel/BuildingData.cs | New SO definition |
| Scripts/Core/MetaProgressionSave.cs | New serializable save class |
| Scripts/Kennel/DogNameGenerator.cs | New utility class |

## Drift Events
None.
