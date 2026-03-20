# Outcome — T024: Active Ability System

**Status:** DONE
**Date:** 2026-03-20

## What Was Built
AbilityController component with 2 concrete abilities (Ground Slam AoE, Dash Strike dash), cooldown tracking, and cooldown UI bar.

## Deliverables
- [x] AbilityController component on player
- [x] Ground Slam: AoE damage in radius, outward knockback, screen shake
- [x] Dash Strike: forward dash with i-frames and damage along path
- [x] Cooldown tracking with timer
- [x] Q key input via InputSystem
- [x] Cooldown UI bar below health bar (Pattern-002)
- [x] GameEvents.OnAbilityUsed event

## Files Changed
| File | Change |
|------|--------|
| Scripts/Player/AbilityController.cs | New — ability execution and cooldown |
| Scripts/UI/AbilityCooldownUI.cs | New — cooldown bar display |
| Scripts/Core/GameEvents.cs | Added OnAbilityUsed event |

## Drift Events
None.
