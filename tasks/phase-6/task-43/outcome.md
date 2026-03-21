# Outcome — T043: Enemy Scaling for Co-op

**Status:** DONE
**Date:** 2026-03-20

## What Was Built
Enemy scaling when co-op is active: +1 enemy count per room and +30% HP on spawned enemies. RoomController checks CoopManager.IsCoopActive at spawn time. Implementation was minimal — 3 lines added to RoomController. Solo play enemy count and HP remain unchanged.

## Deliverables
- [x] Enemies have +30% HP when CoopManager.IsCoopActive is true
- [x] +1 extra enemy spawns per room when co-op is active
- [x] RoomController checks CoopManager.IsCoopActive before spawning
- [x] HP scaling applied at enemy spawn time (not retroactively)
- [x] Solo play enemy count and HP are unchanged
- [x] If P2 leaves mid-run, new rooms use solo scaling (existing enemies unchanged)

## Files Changed
| File | Change |
|------|--------|
| Scripts/Dungeon/RoomController.cs | Modified — 3 lines: co-op check, +1 count, 1.3x HP multiplier |

## Drift Events
None.
