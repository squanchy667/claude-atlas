# Agreement — T036: Building & Upgrade System

**Status:** APPROVED
**Approved:** 2026-03-20

## Scope
Implement building construction (3 buildings x 3 tiers) and permanent player upgrades (4 paths x 3 tiers) with walk-to-interact building spots, purchase UI, and resource deduction through MetaProgressionManager.

## Checkpoint Parameters
- BuildingSpot MonoBehaviour with trigger collider, interaction prompt, and BuildingUI activation
- BuildingUI Canvas panel showing tier info, costs, effects, and purchase button
- UpgradeManager managing available upgrades and purchase logic
- 3 buildings: Doghouse (capacity 5/10/15), Training Yard (Guard bonus +5/10/15%), Scavenger Den (Forager income 2/5/8)
- 4 permanent upgrades: Health (+10/20/30), Damage (+5/10/15%), Dodge Speed (+5/10/15%), Ability Cooldown (-10/20/30%)
- Resource deduction and balance validation on purchase

## Out of Scope
- Dog roster UI (T035)
- Scene transitions (T037)
- Builder role construction speed bonus (simplified — buildings are instant for now)
- Animated construction sequences (future polish)

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
