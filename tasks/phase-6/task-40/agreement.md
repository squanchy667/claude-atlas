# Agreement — T040: Co-op Character Select

**Status:** APPROVED
**Approved:** 2026-03-20

## Scope
Modify CharacterSelectUI for dual-player independent character selection. P1 uses keyboard (1/2 + Enter), P2 uses controller or J/K + Space. Show "Waiting for P2..." until P2 joins. Game starts when all joined players confirm. PlayerManager tracks both selections.

## Checkpoint Parameters
- CharacterSelectUI supports 2 independent player selections
- P1 keyboard controls (1/2 + Enter), P2 controller/keyboard controls (J/K + Space)
- "Waiting for P2..." state displayed until P2 joins
- Game start gated on all joined players confirming
- PlayerManager tracks both selected characters
- Solo play unaffected (P1 confirms alone)

## Out of Scope
- PlayerInputManager join flow (T039)
- Co-op UI bars (T042)
- New character definitions (Phase 4)

## Acceptance Criteria
- [ ] CharacterSelectUI supports 2 independent player selections
- [ ] P1 selects with keyboard (1/2 + Enter)
- [ ] P2 selects with controller D-pad or J/K + Space
- [ ] P2 panel shows "Waiting for P2..." until P2 joins
- [ ] P2 panel shows P2's selection once they join and browse
- [ ] Game starts only when all joined players have confirmed
- [ ] PlayerManager correctly tracks both selected characters
- [ ] Solo play: game starts when P1 confirms alone (no P2 required)
