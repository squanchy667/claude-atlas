# Agreement — T044: Revive Mechanic

**Status:** APPROVED
**Approved:** 2026-03-20

## Scope
Implement Downed state for co-op death: downed player is immobile with a shrinking 10-second revive circle. Partner holds E within range for 2 seconds to revive at 30% HP. Timer expiry means permanent death (solo continues). Both downed simultaneously triggers game over. Normal death behavior preserved for solo play.

## Checkpoint Parameters
- Downed PlayerState in PlayerController
- Player enters Downed on 0 HP in co-op (not full death)
- Downed player immobile, cannot attack
- Shrinking revive circle UI (10-second timer)
- Hold E within 2 units for 2 seconds to revive
- Revive at 30% max HP
- Timer expiry: permanent death, solo continues
- Both downed: game over
- Solo play: normal death behavior unchanged

## Out of Scope
- CoopManager/join flow (T039)
- Co-op UI bars (T042 — dependency, not scope)
- Revive animations or VFX (Phase 7 polish)
- Revive item pickups or cooldowns

## Acceptance Criteria
- [ ] Downed PlayerState exists in PlayerController
- [ ] Player enters Downed state instead of dying when HP reaches 0 in co-op
- [ ] Downed player is immobile and cannot attack
- [ ] Shrinking revive circle UI displays over downed player (10-second timer)
- [ ] Partner can hold E within range (2 units) for 2 seconds to revive
- [ ] Revived player returns at 30% max HP
- [ ] If revive timer expires, downed player permanently dies
- [ ] If one player permanently dies, remaining player continues solo
- [ ] If both players are downed simultaneously, game over triggers
- [ ] Revive mechanic is inactive during solo play (normal death behavior)
