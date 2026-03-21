# Agreement — T042: Co-op UI (Dual Health/Ability Bars)

**Status:** APPROVED
**Approved:** 2026-03-20

## Scope
Add dual health bars (P1 top-left, P2 top-right) and dual ability cooldown bars (below respective health bars). Refactor PlayerHealthUI and AbilityCooldownUI to track a specific player by index. Create CoopHUDController to show/hide P2 UI on join/leave. P2 bars hidden during solo play.

## Checkpoint Parameters
- P1 health bar top-left, P2 health bar top-right
- P1 ability cooldown below P1 health, P2 ability cooldown below P2 health
- PlayerHealthUI and AbilityCooldownUI support player index tracking
- P2 UI hidden during solo, shown on join, hidden on leave
- CoopHUDController manages P2 UI visibility

## Out of Scope
- CoopManager/join flow (T039)
- Revive UI circle (T044)
- Menu UI changes (Phase 7)

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
