# Outcome — T025: Passive Trait System

**Status:** DONE
**Date:** 2026-03-20

## What Was Built
PassiveTraitController that applies stat modifiers at spawn time. Malinois gets +20% HP, Vizsla gets +15% speed.

## Deliverables
- [x] PassiveTraitController component
- [x] HealthBonus modifier (Malinois: 120 → 144 HP)
- [x] SpeedBonus modifier (Vizsla: 7.0 → 8.05 speed)
- [x] Applied once at spawn, not every frame
- [x] PlayerController.ModifyMoveSpeed() method added

## Files Changed
| File | Change |
|------|--------|
| Scripts/Player/PassiveTraitController.cs | New — passive stat application |
| Scripts/Player/PlayerController.cs | Added ModifyMoveSpeed() method |

## Drift Events
None.
