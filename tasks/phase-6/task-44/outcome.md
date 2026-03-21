# Outcome — T044: Revive Mechanic

**Status:** DONE
**Date:** 2026-03-20

## What Was Built
ReviveSystem that intercepts player death during co-op and puts the player into a downed state instead. Downed players are immobile with a 10-second bleedout timer. The partner can hold their revive key within range for 2 seconds to revive at 30% HP with 2 seconds of invincibility. If both players are downed simultaneously, game over triggers. Revive mechanic is inactive during solo play (normal death behavior).

## Deliverables
- [x] Downed state: player is immobile, cannot attack
- [x] 10-second bleedout timer on downed player
- [x] Partner holds revive key within range for 2 seconds to revive
- [x] Revived player returns at 30% max HP
- [x] 2-second invincibility on revive
- [x] Timer expiry: downed player permanently dies, remaining player continues solo
- [x] Both players downed simultaneously: game over
- [x] Revive mechanic inactive during solo play (normal death behavior)

## Files Changed
| File | Change |
|------|--------|
| Scripts/Player/ReviveSystem.cs | New component — downed state, bleedout timer, revive logic, invincibility |
| Scripts/Player/HealthSystem.cs | Modified — death intercept for co-op downed state |
| Scripts/Player/PlayerController.cs | Modified — downed state behavior (immobile, no attack) |
| Scripts/Core/GameEvents.cs | Modified — player downed/revived events |
| Scripts/Core/CoopManager.cs | Modified — both-down game over check |
| Scripts/Player/WeaponController.cs | Modified — block attack input when downed |
| Scripts/Player/AbilityController.cs | Modified — block ability input when downed |

## Drift Events
None.
