# Outcome — T039: PlayerInputManager & P2 Join Flow

**Status:** DONE
**Date:** 2026-03-20

## What Was Built
CoopManager singleton that manages P2 join/leave via keyboard (Enter to join, Backspace to leave). P2 gets dedicated keyboard controls (IJKL movement, U/O/P for attack/dodge/ability). PlayerController updated with isPlayer2 flag to route input correctly. WeaponController and AbilityController updated to respect player index for independent combat input.

## Deliverables
- [x] CoopManager singleton exists and tracks active player count
- [x] P2 can join by pressing Enter key
- [x] P2 spawns at P1's current position
- [x] P2 has dedicated keyboard controls (IJKL/U/O/P)
- [x] PlayerSpawned event fires for P2 so CameraController auto-tracks
- [x] P2 can leave by pressing Backspace
- [x] CoopManager.IsCoopActive returns true when 2 players are present
- [x] Solo play works identically when P2 has not joined
- [x] PlayerController handles multi-player awareness via isPlayer2 flag

## Files Changed
| File | Change |
|------|--------|
| Scripts/Core/CoopManager.cs | New singleton — P2 join/leave, co-op state tracking |
| Scripts/Player/PlayerController.cs | Modified — isPlayer2 support, dual input routing |
| Scripts/Player/WeaponController.cs | Modified — player-index-aware attack input |
| Scripts/Player/AbilityController.cs | Modified — player-index-aware ability input |
| Scripts/Core/GameEvents.cs | Modified — added co-op join/leave events |

## Drift Events
None.
