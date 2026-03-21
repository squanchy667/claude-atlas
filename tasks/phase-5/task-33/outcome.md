# Outcome — T033: Dog Rescue Mechanic

**Status:** DONE
**Date:** 2026-03-20

## What Was Built
In-run dog rescue system where RescueDog components spawn in treasure rooms, players interact to rescue them, RunManager tracks rescued dogs for the current run, and GameEvents.OnDogRescued fires for UI/audio hooks.

## Deliverables
- [x] RescueDog component with interaction trigger and rescue flow
- [x] RunManager tracking of rescued dogs per run
- [x] GameEvents.OnDogRescued event for system-wide notification
- [x] RoomController integration for treasure room dog spawning

## Files Changed
| File | Change |
|------|--------|
| Scripts/Kennel/RescueDog.cs | New component |
| Scripts/Core/GameEvents.cs | Added OnDogRescued event |
| Scripts/Core/RunManager.cs | Added rescued dog tracking |
| Scripts/Dungeon/RoomController.cs | Added treasure room dog spawn logic |

## Drift Events
None.
