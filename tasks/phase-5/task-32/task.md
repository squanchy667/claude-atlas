# [T032] MetaProgressionManager (Save/Load)

**Phase:** 5
**Status:** PENDING
**Complexity:** High
**Estimated Scope:** 1 file, ~300 lines

## Objective
Create the MetaProgressionManager singleton that persists between runs and manages all meta-progression state: resource banking, upgrade tracking, dog roster management, building tracking, and JSON save/load to disk.

## Deliverables
- `MetaProgressionManager` singleton (DontDestroyOnLoad)
- Resource banking: AddBones(int), SpendBones(int), AddTreats(int), SpendTreats(int) with balance validation
- Upgrade tracking: UnlockUpgrade(string), HasUpgrade(string), GetUpgradesByCategory(UpgradeCategory)
- Dog roster: AddDog(DogData), GetDogs(), AssignRole(int dogIndex, DogRole role)
- Building tracking: BuildBuilding(string), HasBuilding(string)
- JSON save/load to Application.persistentDataPath using MetaProgressionSave
- Apply permanent upgrades to player stats on run start (health, damage, dodge speed, ability cooldown modifiers)

## Files Likely Touched
- `Scripts/Core/MetaProgressionManager.cs` — new singleton manager

## Dependencies
- Depends On: T031
- Blocks: T035, T036, T037

## Acceptance Criteria
- [ ] MetaProgressionManager is a singleton with DontDestroyOnLoad
- [ ] AddBones/SpendBones/AddTreats/SpendTreats correctly modify balances with validation (cannot spend more than available)
- [ ] UnlockUpgrade/HasUpgrade/GetUpgradesByCategory correctly track purchased upgrades
- [ ] AddDog/GetDogs/AssignRole correctly manage the dog roster
- [ ] BuildBuilding/HasBuilding correctly track constructed buildings
- [ ] Save() writes MetaProgressionSave as JSON to Application.persistentDataPath
- [ ] Load() reads JSON from disk and restores state; creates default save if file missing
- [ ] ApplyUpgradesToPlayer() modifies player stats based on unlocked permanent upgrades
- [ ] Auto-saves after every state change (resource spend, upgrade unlock, etc.)

## Notes
- Singleton pattern matches existing managers (GameManager, RunManager)
- Save file path: Application.persistentDataPath + "/meta_save.json"
- ApplyUpgradesToPlayer called by RunManager at run start
- GameEvents integration: fire events on resource change, dog added, upgrade unlocked for UI updates
