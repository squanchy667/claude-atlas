# Outcome — T041: Shared Camera & Leash

**Status:** DONE
**Date:** 2026-03-20

## What Was Built
Camera leash system that prevents players from separating beyond 12 units. When separation exceeds the threshold, a rubber-band pull draws both players back toward each other. Dynamic zoom tuned to orthographic size range of 7-14, smoothly zooming out as players separate and zooming in as they reconverge. Leash is only active during co-op; solo play is unaffected.

## Deliverables
- [x] CameraController correctly tracks 2 players (centers between them)
- [x] Camera dynamically zooms out as players separate (ortho size 7-14 range)
- [x] Camera dynamically zooms in as players come together
- [x] Max separation leash activates at 12 units distance
- [x] Rubber-band velocity pulls separated players toward each other
- [x] Leash is inactive during solo play
- [x] Camera reverts to single-target behavior if P2 leaves

## Files Changed
| File | Change |
|------|--------|
| Scripts/Core/CameraController.cs | Modified — leash logic (12 unit max), rubber-band pull, dynamic zoom range 7-14 |

## Drift Events
None.
