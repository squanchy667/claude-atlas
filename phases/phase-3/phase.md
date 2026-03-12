# Phase 3 — Dungeon Generation

## Goal
Room prefab system, procedural floor generator using pyramid/branching DAG structure (player starts at one room, chooses paths, all paths converge to boss), room types (combat, treasure, shop, boss), floor progression (3 floors), minimap. Player can run through a generated dungeon with meaningful path choices.

## Key Deliverables
- RoomTemplate ScriptableObject system
- Room prefab creation workflow (tilemap-based rooms with doors, spawn points)
- Procedural floor generator: builds pyramid DAG (start → branching paths → converge at boss)
- Room types: Combat, Treasure, Shop, Boss, Start
- Door system: lock on room enter (combat), unlock on clear
- Floor transition: stairs/portal to next floor after boss defeat
- 3-floor progression with increasing difficulty
- Minimap UI showing explored rooms
- At least 5 room templates per floor (15 total minimum)

## Entry Criteria
- Phase 2 complete: combat system works, enemies can spawn and be defeated

## Exit Criteria
- Floors generate procedurally with 5-8 rooms each
- Rooms connect correctly as a pyramid DAG (branching paths, no dead ends, all converge to boss)
- Door locks/unlocks work for combat rooms
- Player can progress through 3 floors
- Minimap shows explored vs unexplored rooms
- Room templates provide visual variety within a floor

## Dependencies
- Phase 2 (combat, enemies, health system)
