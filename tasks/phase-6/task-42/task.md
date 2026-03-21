# [T042] Co-op UI (Dual Health/Ability Bars)

**Phase:** 6
**Status:** PENDING
**Complexity:** Medium
**Estimated Scope:** 2-3 files, ~200 lines

## Objective
Show P1 health bar top-left and P2 health bar top-right. Show P1 ability cooldown below P1 health, P2 ability cooldown below P2 health. PlayerHealthUI and AbilityCooldownUI need to support tracking a specific player (not just "the first spawned"). P2 bars are hidden when playing solo.

## Deliverables
- P1 health bar positioned top-left
- P2 health bar positioned top-right
- P1 ability cooldown bar below P1 health
- P2 ability cooldown bar below P2 health
- PlayerHealthUI supports tracking a specific player by index
- AbilityCooldownUI supports tracking a specific player by index
- P2 bars hidden when solo (no P2 joined)

## Files Likely Touched
- `Scripts/UI/PlayerHealthUI.cs` — modify to track specific player by index
- `Scripts/UI/AbilityCooldownUI.cs` — modify to track specific player by index
- `Scripts/UI/CoopHUDController.cs` — new controller for showing/hiding P2 UI elements

## Dependencies
- Depends On: T039
- Blocks: T044, T045

## Acceptance Criteria
- [ ] P1 health bar displays at top-left of screen
- [ ] P2 health bar displays at top-right of screen
- [ ] P1 ability cooldown displays below P1 health bar
- [ ] P2 ability cooldown displays below P2 health bar
- [ ] PlayerHealthUI can track a specific player (not hardcoded to first spawned)
- [ ] AbilityCooldownUI can track a specific player (not hardcoded to first spawned)
- [ ] P2 UI elements are hidden when playing solo
- [ ] P2 UI elements appear when P2 joins
- [ ] P2 UI elements disappear when P2 leaves

## Notes
- Existing UI components likely assume a single player — refactor to accept a player index or reference
- CoopHUDController listens to CoopManager events for P2 join/leave to show/hide UI
