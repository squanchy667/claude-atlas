# [T031] Kennel Data Models

**Phase:** 5
**Status:** PENDING
**Complexity:** Medium
**Estimated Scope:** 6 files, ~250 lines

## Objective
Define the data layer for the Kennel meta-progression system: dog data, dog roles, upgrade definitions, upgrade categories, and building definitions. Also create the MetaProgressionSave class with JSON serialization for persisting player progress between sessions.

## Deliverables
- `DogData` class with dogName, breed, role, happiness, rescuedOnFloor fields
- `DogRole` enum (None, Guard, Forager, Builder)
- `UpgradeData` ScriptableObject with upgradeName, description, category, tier, boneCost, treatCost, prerequisite, statModifier
- `UpgradeCategory` enum (Health, Damage, DodgeSpeed, AbilityCooldown, KennelBuilding)
- `BuildingData` ScriptableObject with buildingName, description, tier, boneCost, treatCost, prerequisite
- `MetaProgressionSave` class with JSON serialization (totalBones, totalTreats, unlockedUpgrades, dogRoster, buildingsBuilt, runsCompleted, runsAttempted)

## Files Likely Touched
- `Scripts/Kennel/DogData.cs` — new data class
- `Scripts/Kennel/DogRole.cs` — new enum
- `Scripts/Kennel/UpgradeData.cs` — new SO definition
- `Scripts/Kennel/UpgradeCategory.cs` — new enum
- `Scripts/Kennel/BuildingData.cs` — new SO definition
- `Scripts/Core/MetaProgressionSave.cs` — new serializable save class

## Dependencies
- Depends On: None
- Blocks: T032, T033, T034

## Acceptance Criteria
- [ ] DogData class is [System.Serializable] with all required fields (dogName, breed, role, happiness, rescuedOnFloor)
- [ ] DogRole enum defines None, Guard, Forager, Builder
- [ ] UpgradeData SO has [CreateAssetMenu] attribute and all fields (upgradeName, description, category, tier, boneCost, treatCost, prerequisite, statModifier)
- [ ] UpgradeCategory enum defines Health, Damage, DodgeSpeed, AbilityCooldown, KennelBuilding
- [ ] BuildingData SO has [CreateAssetMenu] attribute and all fields (buildingName, description, tier, boneCost, treatCost, prerequisite)
- [ ] MetaProgressionSave uses JsonUtility for serialization/deserialization
- [ ] MetaProgressionSave contains totalBones, totalTreats, unlockedUpgrades (List<string>), dogRoster (List<DogData>), buildingsBuilt (List<string>), runsCompleted, runsAttempted

## Notes
- DogData is a plain C# class (not a MonoBehaviour or SO) so it can be serialized in save data
- UpgradeData and BuildingData are SOs for editor-tunable definitions, not save data
- MetaProgressionSave is the JSON-serializable container for all persistent player state
