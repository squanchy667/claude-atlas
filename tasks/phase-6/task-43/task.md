# [T043] Enemy Scaling for Co-op

**Phase:** 6
**Status:** PENDING
**Complexity:** Low
**Estimated Scope:** 1-2 files, ~80 lines

## Objective
When 2 players are active, enemies get +30% HP and +1 extra enemy spawns per room. RoomController reads CoopManager.IsCoopActive to adjust spawning. Scaling only applies during co-op and reverts for solo play.

## Deliverables
- Enemy HP scaled by +30% when co-op is active
- +1 extra enemy per room spawn when co-op is active
- RoomController reads CoopManager.IsCoopActive for spawn adjustments
- Scaling reverts to normal values when playing solo

## Files Likely Touched
- `Scripts/Dungeon/RoomController.cs` — modify enemy spawning to check co-op status
- `Scripts/Enemies/EnemyHealth.cs` — modify to apply HP scaling at spawn time

## Dependencies
- Depends On: T039
- Blocks: T045

## Acceptance Criteria
- [ ] Enemies have +30% HP when CoopManager.IsCoopActive is true
- [ ] +1 extra enemy spawns per room when co-op is active
- [ ] RoomController checks CoopManager.IsCoopActive before spawning
- [ ] HP scaling applied at enemy spawn time (not retroactively)
- [ ] Solo play enemy count and HP are unchanged
- [ ] If P2 leaves mid-run, new rooms use solo scaling (existing enemies unchanged)

## Notes
- +30% HP is a simple multiplier at spawn time — no need for complex scaling curves
- Extra enemy is additive: if a room normally spawns 3, it spawns 4 in co-op
- Scaling values should ideally live in a ScriptableObject or constants for easy tuning
