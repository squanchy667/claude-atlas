# Agreement — T031: Kennel Data Models

**Status:** APPROVED
**Approved:** 2026-03-20

## Scope
Define the complete data layer for the Kennel meta-progression system: DogData class, DogRole enum, UpgradeData SO, UpgradeCategory enum, BuildingData SO, and MetaProgressionSave class with JSON serialization.

## Checkpoint Parameters
- DogData class with all fields (dogName, breed, role, happiness, rescuedOnFloor), marked [System.Serializable]
- DogRole enum (None, Guard, Forager, Builder)
- UpgradeData and BuildingData ScriptableObjects with [CreateAssetMenu] and all required fields
- UpgradeCategory enum (Health, Damage, DodgeSpeed, AbilityCooldown, KennelBuilding)
- MetaProgressionSave class with JSON serialization via JsonUtility, containing totalBones, totalTreats, unlockedUpgrades, dogRoster, buildingsBuilt, runsCompleted, runsAttempted

## Out of Scope
- MetaProgressionManager singleton logic (T032)
- Dog rescue spawning logic (T033)
- Kennel scene setup (T034)
- UI for viewing/editing data (T035, T036)
- Concrete SO assets (created during integration)

## Acceptance Criteria
- [ ] DogData class is [System.Serializable] with all required fields (dogName, breed, role, happiness, rescuedOnFloor)
- [ ] DogRole enum defines None, Guard, Forager, Builder
- [ ] UpgradeData SO has [CreateAssetMenu] attribute and all fields (upgradeName, description, category, tier, boneCost, treatCost, prerequisite, statModifier)
- [ ] UpgradeCategory enum defines Health, Damage, DodgeSpeed, AbilityCooldown, KennelBuilding
- [ ] BuildingData SO has [CreateAssetMenu] attribute and all fields (buildingName, description, tier, boneCost, treatCost, prerequisite)
- [ ] MetaProgressionSave uses JsonUtility for serialization/deserialization
- [ ] MetaProgressionSave contains totalBones, totalTreats, unlockedUpgrades (List<string>), dogRoster (List<DogData>), buildingsBuilt (List<string>), runsCompleted, runsAttempted
