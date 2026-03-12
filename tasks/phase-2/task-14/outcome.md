# Outcome — T014: Combat Test Scene Integration
## Status: DONE
## Completed: 2026-03-12

## What Was Built
Combat test scene fully wired: player attacks enemies, enemies chase and attack back, health bar updates in real time, hit feedback (flash, knockback, screen shake, hitstop) works in both directions.

## Files Changed
- `Assets/Scripts/Player/PlayerController.cs` — Moved PlayerSpawned event from OnEnable to Start (fixes subscription race condition)
- `Assets/Scripts/UI/PlayerHealthUI.cs` — Rewrote health bar to use RectTransform width scaling instead of Image.Type.Filled; added double-subscription guard
- `Assets/Scripts/Enemies/EnemyController.cs` — Added DamageFlash, Knockback, and screen shake when enemies hit the player
- `Assets/Scripts/Player/DodgeRoll.cs` — Reduced dodge cooldown from 0.5s to 0.2s
- `Assets/Scenes/TestRoom.unity` — Updated scene file

## Deviations from Agreement
1. Health bar uses RectTransform width scaling instead of Slider — Image.Type.Filled didn't render properly without a source sprite. Functionally equivalent.
2. Dodge cooldown reduced from 0.5s to 0.2s — user preference for snappier feel.
3. Enemy hit feedback (flash, knockback, screen shake on player) was not in original spec but necessary for combat to feel interactive.

## Bugs Fixed
- **OnPlayerSpawned race condition** (HIGH): Event fired in OnEnable before subscribers registered. Fixed by moving to Start().
- **Health bar not updating** (HIGH): Image.Type.Filled doesn't work without a source sprite. Replaced with width-based RectTransform scaling.
- **No feedback on enemy→player hits**: AttackTarget only called TakeDamage. Added DamageFlash, Knockback, and screen shake.

## Verification
- Player attacks enemies (C key / left click): enemies flash, get knocked back, screen shakes, health reduces ✓
- Enemies chase player, attack at close range: player flashes, gets knocked back, screen shakes, health bar decreases ✓
- Health bar visible in top-left, updates in real time ✓
- HitstopManager singleton exists and triggers on player attacks ✓
- All setup is programmatic via SceneSetup editor script ✓
