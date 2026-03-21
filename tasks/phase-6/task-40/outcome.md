# Outcome — T040: Co-op Character Select

**Status:** DONE
**Date:** 2026-03-20

## What Was Built
Co-op character selection with independent controls for each player. P1 selects with 1/2 keys and confirms with Enter. P2 selects with 9/0 keys and confirms with RightShift. Both players can independently browse and confirm their character choice. Game starts when all joined players have confirmed.

## Deliverables
- [x] CharacterSelectUI supports 2 independent player selections
- [x] P1 selects with keyboard (1/2 + Enter)
- [x] P2 selects with keyboard (9/0 + RightShift)
- [x] Game starts only when all joined players have confirmed
- [x] PlayerManager correctly tracks both selected characters
- [x] Solo play: game starts when P1 confirms alone (no P2 required)

## Files Changed
| File | Change |
|------|--------|
| Scripts/UI/CharacterSelectUI.cs | Modified — dual-player independent selection with P1/P2 key bindings |
| Scripts/Core/PlayerManager.cs | Modified — tracks two selected characters |

## Drift Events
None.
