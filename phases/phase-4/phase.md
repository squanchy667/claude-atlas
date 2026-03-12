# Phase 4 — Characters & Enemies

## Goal
2 playable dog characters — Malinois (Brawler) and Vizsla (Scout) — with unique abilities and stats (ScriptableObject-driven), 6 enemy types with distinct behaviors and visual attack tells, 3 boss fights, enemy spawning system per room.

## Key Deliverables
- 2 CharacterData ScriptableObjects: Malinois (Brawler) and Vizsla (Scout)
- Character selection system (pre-run, works for 1-2 players)
- AbilityData system: active ability with cooldown, UI indicator (static, no upgrade scaling)
- PassiveTraitData system: always-on stat modifier or behavior
- Malinois kit: Ground Slam/Frenzy/Shield Bash (pick 1 active), +HP/DR/lifesteal (pick 1 passive)
- Vizsla kit: Dash Strike/Trap/Stealth (pick 1 active), +speed/dodge distance/crit-after-dodge (pick 1 passive)
- 6 enemy types with distinct AI patterns and visual attack tells (white spark = light, red spark = heavy):
  - Floor 1: Stray Mutt (melee chaser), Barker (stationary ranged)
  - Floor 2: Armored Hound (shielded front), Pack Runner (fast swarm)
  - Floor 3: Shadow Dog (teleporter), Howler (AoE zone denial)
  - Floor 3 enemies appear rarely on Floor 2
- 3 boss fights (one per floor) with multi-phase patterns:
  - F1: "Big Brutus" — charge + slam, summons adds at 50%
  - F2: "The Catcher" — nets + shrinking arena at 50%
  - F3: "Feral King" — combo, shadow clones at 60%, enrage at 30%
- Bosses drop floor key only (no unique weapons)
- Enemy spawning system: per-room spawn rules based on floor and room type
- Loot drop system: enemies drop weapons and resources on death

## Entry Criteria
- Phase 3 complete: dungeon generation works, rooms load with enemies

## Exit Criteria
- Player can choose from 2 characters (Malinois, Vizsla) with distinct playstyles
- Each character has a working active ability and passive trait
- 6 enemy types appear across 3 floors with unique behaviors
- 3 bosses are defeatable with distinct attack patterns
- Loot drops function (weapons and resources)
- Character selection screen works

## Dependencies
- Phase 3 (dungeon generation, room system)
