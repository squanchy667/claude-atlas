# Outcome — T042: Co-op UI (Dual Health/Ability Bars)

**Status:** DONE
**Date:** 2026-03-20

## What Was Built
Dual health bars with P1 positioned top-left and P2 positioned top-right (blue tint). Dual cooldown bars displayed below their respective health bars. P1/P2 labels on each health bar for clarity. P2 UI elements automatically show when P2 joins and hide when P2 leaves, driven by CoopManager events.

## Deliverables
- [x] P1 health bar displays at top-left of screen
- [x] P2 health bar displays at top-right of screen with blue tint
- [x] P1 ability cooldown displays below P1 health bar
- [x] P2 ability cooldown displays below P2 health bar
- [x] P1/P2 labels on health bars
- [x] P2 UI elements are hidden when playing solo
- [x] P2 UI elements appear when P2 joins
- [x] P2 UI elements disappear when P2 leaves

## Files Changed
| File | Change |
|------|--------|
| Scripts/UI/PlayerHealthUI.cs | Modified — player-index-aware tracking, P1/P2 labels, P2 blue tint |
| Scripts/UI/AbilityCooldownUI.cs | Modified — player-index-aware tracking, auto show/hide |

## Drift Events
None.
