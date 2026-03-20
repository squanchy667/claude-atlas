# Agreement — T026: Character Selection & Spawn

**Status:** APPROVED
**Approved:** 2026-03-20

## Scope
Build a character selection screen displayed before the dungeon run where the player picks Malinois or Vizsla, store the selection in a PlayerManager singleton, and apply the chosen character's stats, ability, passive, and color to the player on spawn.

## Checkpoint Parameters
- CharacterSelectUI shows both characters with name, class, and stat previews; supports keyboard (1/2 keys) and mouse selection
- PlayerManager singleton persists across scenes and stores selected CharacterData
- Player prefab configured on spawn with selected character's HP, speed, damage, dodge stats, color, ability, and passive

## Out of Scope
- More than 2 playable characters
- Character unlock progression
- Visual character sprites (placeholder colors only)
- Co-op character selection (Phase 6)

## Acceptance Criteria
- [ ] Character select screen shows 2 characters with name, class, and stats
- [ ] Player can select a character (click or keyboard)
- [ ] Selected character's stats applied to player (HP, speed, damage, dodge, color)
- [ ] Selected character's ability and passive are activated
- [ ] Dungeon run starts after selection
- [ ] Works with keyboard (1/2 keys) and mouse
