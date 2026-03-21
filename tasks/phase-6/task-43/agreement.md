# Agreement — T043: Enemy Scaling for Co-op

**Status:** APPROVED
**Approved:** 2026-03-20

## Scope
Scale enemy HP by +30% and add +1 extra enemy per room when co-op is active. RoomController reads CoopManager.IsCoopActive to adjust spawning. Scaling only applies during co-op and reverts for solo.

## Checkpoint Parameters
- Enemy HP +30% multiplier during co-op
- +1 extra enemy per room during co-op
- RoomController checks CoopManager.IsCoopActive at spawn time
- Solo play unaffected
- Mid-run P2 leave: new rooms use solo scaling

## Out of Scope
- CoopManager/join flow (T039)
- Boss scaling (may be addressed in Phase 7 tuning)
- Difficulty curves beyond co-op scaling

## Acceptance Criteria
- [ ] Enemies have +30% HP when CoopManager.IsCoopActive is true
- [ ] +1 extra enemy spawns per room when co-op is active
- [ ] RoomController checks CoopManager.IsCoopActive before spawning
- [ ] HP scaling applied at enemy spawn time (not retroactively)
- [ ] Solo play enemy count and HP are unchanged
- [ ] If P2 leaves mid-run, new rooms use solo scaling (existing enemies unchanged)
