# Room Prefab Conventions

**Tier:** Foundation
**Category:** Level Design
**Created:** 2026-03-11
**Status:** Active

## What It Solves
Establishes standards for creating room prefabs that the procedural dungeon generator can assemble. Ensures rooms are interchangeable, connect correctly, and contain the necessary metadata for spawning and gameplay.

## Approach

### Room Prefab Structure
Every room prefab follows this hierarchy:
```
Room_[FloorN]_[Type]_[Number] (GameObject)
├── Tilemap_Floor          — Ground tiles
├── Tilemap_Walls          — Wall tiles with colliders
├── Tilemap_Decoration     — Non-collision visual tiles
├── Doors                  — Parent for door GameObjects
│   ├── Door_North
│   ├── Door_South
│   ├── Door_East
│   └── Door_West
├── SpawnPoints            — Parent for enemy spawn markers
│   ├── SpawnPoint_0
│   ├── SpawnPoint_1
│   └── ...
├── LootPoints             — Parent for loot drop locations
│   ├── LootPoint_0
│   └── ...
└── RoomController         — MonoBehaviour with RoomTemplate SO reference
```

### Naming Convention
- `Room_F1_Combat_01` — Floor 1, Combat room, variant 1
- `Room_F2_Treasure_01` — Floor 2, Treasure room, variant 1
- `Room_F3_Boss_01` — Floor 3, Boss room, variant 1
- `Room_Any_Start_01` — Start room (usable on any floor)
- `Room_Any_Shop_01` — Shop room (usable on any floor)

### Door System
- Doors are positioned at fixed grid-aligned positions on the room boundary.
- Each door has a `DoorController` component with: direction (N/S/E/W), locked state, and connected room reference.
- When a room is entered, combat rooms lock all doors. When all enemies are defeated, doors unlock.
- Non-combat rooms (treasure, shop, start) never lock doors.

### Room Sizing
- Standard room: 16x12 tiles (can vary, but doors must align to a grid)
- Boss room: 24x18 tiles (larger arena)
- All rooms use the same tile size (16x16 pixels per tile at 100 PPU)

### Spawn Point Rules
- Combat rooms: minimum 3 spawn points, maximum 8
- Spawn points placed away from doors (minimum 3 tiles distance)
- Spawn points placed with line-of-sight consideration (not behind walls)
- Boss rooms: 1 boss spawn point (center) + 4 add spawn points (corners)

## When To Use
- Creating any new room prefab
- Modifying room layouts
- Adding new room types
- Debugging dungeon generation connection issues

## When NOT To Use
- The Kennel scene (not procedurally generated)
- UI layout

## Gotchas
- Door alignment is critical. If doors don't align between rooms, the corridor connection will fail. Always verify door positions match the grid.
- Tilemap colliders: use `TilemapCollider2D` with `CompositeCollider2D` on wall tilemaps for performance. Individual tile colliders are expensive.
- Room prefab variants should have the SAME door positions but DIFFERENT internal layouts. This ensures any variant can replace any other during generation.
- Always test new rooms by running the dungeon generator multiple times. A room that works in isolation may cause layout failures during procedural assembly.
