# [T044] Revive Mechanic

**Phase:** 6
**Status:** PENDING
**Complexity:** High
**Estimated Scope:** 2-3 files, ~300 lines

## Objective
When a player dies in co-op, they enter a "Downed" state instead of full death. A shrinking revive circle appears over the downed player (10-second timer). The partner walks to the downed player and holds E for 2 seconds to revive them at 30% HP. If the timer expires, that player permanently dies and the remaining player continues solo. If both players are downed simultaneously, it is game over.

## Deliverables
- New `Downed` PlayerState added to PlayerController
- Downed player is immobile, shows shrinking revive circle (10 seconds)
- Partner holds E within range for 2 seconds to revive
- Revived player returns at 30% HP
- Timer expiry: permanent death for that player, solo continues
- Both players downed simultaneously: game over
- ReviveSystem component handles revive logic

## Files Likely Touched
- `Scripts/Player/ReviveSystem.cs` — new component handling revive logic
- `Scripts/Player/PlayerController.cs` — add Downed state, downed behavior
- `Scripts/UI/ReviveCircleUI.cs` — new or modified UI for the shrinking revive circle

## Dependencies
- Depends On: T039, T042
- Blocks: T045

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

## Notes
- Downed state depends on T042 for co-op UI (health bars need to reflect downed state)
- ReviveSystem should listen for player death events and intercept them during co-op
- The revive circle is a simple UI element anchored to world position of downed player
- 30% HP revive prevents trivial revival loops while keeping it worthwhile
