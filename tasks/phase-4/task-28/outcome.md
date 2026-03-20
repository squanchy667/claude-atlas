# Outcome — T028: Boss Controller (3 Bosses)

**Status:** DONE
**Date:** 2026-03-20

## What Was Built
BossController with multi-phase attack patterns for 3 bosses, boss health bar UI, net projectile with slow debuff.

## Deliverables
- [x] Big Brutus (F1): charge + slam, summons 2 adds at 50% HP
- [x] The Catcher (F2): net projectiles with slow debuff, arena shrink at 50% HP
- [x] Feral King (F3): 3-hit combo, shadow clones at 60%, enrage at 30%
- [x] Boss health bar at top of screen with name
- [x] Phase transitions with 1s invulnerability and flash
- [x] 2x scale for visual distinction
- [x] Boss death unlocks doors and spawns floor portal
- [x] NetProjectile with SlowDebuff component
- [x] GameEvents: OnBossPhaseChanged, OnBossSpawned

## Files Changed
| File | Change |
|------|--------|
| Scripts/Enemies/BossController.cs | New — boss phase state machine |
| Scripts/Enemies/NetProjectile.cs | New — net projectile + slow debuff |
| Scripts/UI/BossHealthBarUI.cs | New — top-screen boss health display |
| Scripts/Core/GameEvents.cs | Added boss events |
| Scripts/Dungeon/RoomController.cs | Added CreateBoss() for boss rooms |

## Drift Events
None.
