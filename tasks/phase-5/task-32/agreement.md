# Agreement — T032: MetaProgressionManager (Save/Load)

**Status:** APPROVED
**Approved:** 2026-03-20

## Scope
Create the MetaProgressionManager singleton that persists between runs, manages all meta-progression state (resources, upgrades, dogs, buildings), provides JSON save/load to disk, and applies permanent upgrades to player stats on run start.

## Checkpoint Parameters
- MetaProgressionManager singleton with DontDestroyOnLoad, matching existing manager pattern
- Resource banking methods (AddBones, SpendBones, AddTreats, SpendTreats) with balance validation
- Upgrade tracking methods (UnlockUpgrade, HasUpgrade, GetUpgradesByCategory)
- Dog roster methods (AddDog, GetDogs, AssignRole)
- Building tracking methods (BuildBuilding, HasBuilding)
- JSON save/load using MetaProgressionSave to Application.persistentDataPath
- ApplyUpgradesToPlayer() method that modifies player stats from unlocked upgrades

## Out of Scope
- Dog rescue spawning (T033)
- Kennel scene and navigation (T034)
- Dog roster UI (T035)
- Building/upgrade purchase UI (T036)
- Scene transition orchestration (T037)

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
