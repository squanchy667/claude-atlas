# [T026] Character Selection & Spawn

**Phase:** 4
**Status:** PENDING
**Complexity:** Medium
**Estimated Scope:** 5 files, ~200 lines

## Objective
Build a character selection screen shown before the dungeon run starts. Player picks Malinois or Vizsla, selection is stored in PlayerManager, and the chosen character's stats/ability/passive are applied to the player when spawning into the dungeon.

## Deliverables
- `CharacterSelectUI.cs` — UI screen showing 2 character options with stats preview
- `PlayerManager.cs` — singleton storing selected CharacterData, applying it on spawn
- Player prefab updated to accept CharacterData and configure stats/color/ability/passive
- Flow: Character Select → Dungeon Run (replaces direct DungeonStartTrigger)
- Support for default selection (skip select for quick testing)

## Files Likely Touched
- `Scripts/UI/CharacterSelectUI.cs` — new, character selection screen
- `Scripts/Core/PlayerManager.cs` — new singleton, stores selection
- `Scripts/Player/PlayerController.cs` — accept CharacterData to set stats
- `Scripts/Dungeon/DungeonStartTrigger.cs` — modified to wait for character selection
- `Editor/SceneSetup.cs` — add CharacterSelectUI to scene setup

## Dependencies
- Depends On: T024 (ability system), T025 (passive system)
- Blocks: T030

## Acceptance Criteria
- [ ] Character select screen shows 2 characters with name, class, and stats
- [ ] Player can select a character (click or keyboard)
- [ ] Selected character's stats applied to player (HP, speed, damage, dodge, color)
- [ ] Selected character's ability and passive are activated
- [ ] Dungeon run starts after selection
- [ ] Works with keyboard (1/2 keys) and mouse

## Notes
- Simple UI: two panels side by side, highlight on hover/select, press Enter/click to confirm
- PlayerManager persists across scenes (DontDestroyOnLoad via Singleton<T>)
- Default to Malinois if no selection made (quick-test mode)
