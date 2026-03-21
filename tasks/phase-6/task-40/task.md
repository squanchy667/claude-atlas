# [T040] Co-op Character Select

**Phase:** 6
**Status:** PENDING
**Complexity:** Medium
**Estimated Scope:** 2-3 files, ~200 lines

## Objective
Modify the existing CharacterSelectUI to support 2 players selecting characters independently. P1 selects with keyboard (1/2 + Enter), P2 selects with controller or J/K + Space. Each player panel shows "Waiting for P2..." until P2 joins and makes a selection. The game starts when all joined players have confirmed their selection. PlayerManager tracks both selected characters.

## Deliverables
- CharacterSelectUI modified for dual-player independent selection
- P1 controls: 1/2 to browse, Enter to confirm
- P2 controls: controller D-pad or J/K to browse, controller A or Space to confirm
- Player panel shows "Waiting for P2..." when P2 has not joined
- Game starts when all joined players have confirmed
- PlayerManager tracks 2 selected characters

## Files Likely Touched
- `Scripts/UI/CharacterSelectUI.cs` — modify for dual-player selection
- `Scripts/Core/PlayerManager.cs` — modify to track 2 selected characters
- `Scripts/UI/PlayerSelectPanel.cs` — new or modified panel component

## Dependencies
- Depends On: T039
- Blocks: T045

## Acceptance Criteria
- [ ] CharacterSelectUI supports 2 independent player selections
- [ ] P1 selects with keyboard (1/2 + Enter)
- [ ] P2 selects with controller D-pad or J/K + Space
- [ ] P2 panel shows "Waiting for P2..." until P2 joins
- [ ] P2 panel shows P2's selection once they join and browse
- [ ] Game starts only when all joined players have confirmed
- [ ] PlayerManager correctly tracks both selected characters
- [ ] Solo play: game starts when P1 confirms alone (no P2 required)

## Notes
- P2 join should work via CoopManager (T039) — the character select screen listens for player join events
- Each player must be able to select a different character (or the same one, if allowed by design)
