# Outcome — T026: Character Selection & Spawn

**Status:** DONE
**Date:** 2026-03-20

## What Was Built
Character selection screen with 2 character panels, PlayerManager singleton that applies selected character stats to player on spawn.

## Deliverables
- [x] CharacterSelectUI with 2 side-by-side panels showing stats
- [x] Keyboard selection (1/2 keys, Enter to confirm)
- [x] Mouse click selection
- [x] PlayerManager singleton stores and applies CharacterData
- [x] Stats applied on spawn: color, speed, dodge, health, ability, passive
- [x] DungeonStartTrigger shows select screen before run
- [x] Runtime fallback character creation if assets not found
- [x] GameEvents.OnCharacterSelected event

## Files Changed
| File | Change |
|------|--------|
| Scripts/Core/PlayerManager.cs | New singleton — character selection storage and application |
| Scripts/UI/CharacterSelectUI.cs | New — full-screen character select overlay |
| Scripts/Player/PlayerController.cs | Added SetMoveSpeed() |
| Scripts/Player/DodgeRoll.cs | Added SetDodgeStats() |
| Scripts/Combat/WeaponController.cs | Added DamageMultiplier property |
| Scripts/Core/GameEvents.cs | Added OnCharacterSelected event |
| Scripts/Dungeon/DungeonStartTrigger.cs | Shows character select before run |
| Scripts/UI/GameOverUI.cs | Destroys PlayerManager on restart |
| Editor/SceneSetup.cs | Added PlayerManager and CharacterSelectUI to scene |

## Drift Events
None.
