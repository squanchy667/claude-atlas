# [T036] Building & Upgrade System

**Phase:** 5
**Status:** PENDING
**Complexity:** High
**Estimated Scope:** 3 files, ~400 lines

## Objective
Implement the building construction and upgrade purchase system. Players walk to building spots in the Kennel and interact to view/purchase buildings and permanent upgrades. Buildings have 3 tiers each, and 4 permanent player upgrade paths exist.

## Deliverables
- `BuildingSpot` MonoBehaviour: trigger collider at each building location, shows interaction prompt, opens BuildingUI on E key press
- `BuildingUI` Canvas panel: shows building name, current tier, next tier cost, effects, purchase button
- `UpgradeManager` MonoBehaviour: manages available upgrades, handles purchase logic, integrates with MetaProgressionManager
- 3 buildings x 3 tiers: Doghouse (capacity 5/10/15 dogs), Training Yard (Guard damage bonus +5/10/15%), Scavenger Den (Forager income 2/5/8 Bones per run)
- 4 permanent player upgrades: Health (+10/+20/+30), Damage (+5/+10/+15%), Dodge Speed (+5/+10/+15%), Ability Cooldown (-10/-20/-30%)

## Files Likely Touched
- `Scripts/Kennel/BuildingSpot.cs` — new MonoBehaviour for building interaction zones
- `Scripts/UI/BuildingUI.cs` — new Canvas UI for building/upgrade display and purchase
- `Scripts/Kennel/UpgradeManager.cs` — new manager for upgrade logic and data

## Dependencies
- Depends On: T032, T034
- Blocks: T038

## Acceptance Criteria
- [ ] Walking to a building spot shows an interaction prompt ("Press E to interact")
- [ ] Pressing E opens the BuildingUI panel for that specific building
- [ ] BuildingUI shows: building name, current tier, next tier description, cost (Bones/Treats), effects
- [ ] Purchase button deducts resources via MetaProgressionManager and unlocks the building/tier
- [ ] Purchase button disabled when insufficient resources or max tier reached
- [ ] Doghouse tiers: capacity 5/10/15 dogs (limits roster size)
- [ ] Training Yard tiers: Guard damage bonus +5/10/15%
- [ ] Scavenger Den tiers: Forager income 2/5/8 Bones per run
- [ ] 4 permanent upgrades purchasable: Health (+10/+20/+30), Damage (+5/+10/+15%), Dodge Speed (+5/+10/+15%), Ability Cooldown (-10/-20/-30%)
- [ ] BuildingUI closes on E key or clicking outside
- [ ] Visual feedback on successful purchase (building spot color changes or tier indicator)

## Notes
- Building costs should escalate: Tier 1 (~50 Bones), Tier 2 (~150 Bones + 10 Treats), Tier 3 (~300 Bones + 30 Treats)
- Permanent upgrade costs: Tier 1 (~30 Bones), Tier 2 (~100 Bones + 5 Treats), Tier 3 (~200 Bones + 15 Treats)
- BuildingSpot references its BuildingData SO for configuration
- UpgradeManager holds references to all UpgradeData SOs
- Player movement disabled while BuildingUI is open
