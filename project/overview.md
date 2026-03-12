# DogPack Roguelite

## One-Line Description

A 2D top-down roguelite where players control dog characters through procedurally generated dungeon runs with melee/ranged combat, dodge-rolling, and a home base (The Kennel) where they manage and upgrade their pack of rescued dogs between runs.

## Problem

Cult of the Lamb fans want more games in the same genre — top-down action roguelites with base management — but with a fresh, lighter theme. Most roguelites are dark/gothic themed. This game replaces the cult aesthetic with a playful dog pack fantasy: you're the Alpha dog building a pack, rescuing strays, and fighting through dangerous territories. The co-op element adds replayability that Cult of the Lamb lacks — playing couch co-op with a friend in a roguelite with base building doesn't exist in a polished, accessible form.

## Solution

A 2D top-down roguelite with procedurally generated dungeon runs (3 floors, 5-8 rooms each), 4 weapon types, dodge-rolling with i-frames, and a home base (The Kennel) for permanent progression between runs. Players rescue dogs during runs, assign them to roles at base, and spend resources (Bones and Treats) on permanent upgrades. Local co-op support for 2 players with shared screen and dynamic camera.

## Target Users

### Primary

Fans of Cult of the Lamb, Hades, and Enter the Gungeon who want a lighter-themed, co-op-friendly roguelite. Ages 10+, casual to mid-core gamers.

### Secondary

Couch co-op players looking for a roguelite with base building to play together.

## Success Definition

- Player can select from 2 playable dog characters (Malinois Brawler, Vizsla Scout), each with a unique active ability and passive trait
- Dungeon runs have 3 floors with 5-8 rooms each, procedurally assembled from prefab room templates
- Combat feels responsive: attack, dodge roll with i-frames, and special ability on cooldown
- At least 4 weapon types (Bite/melee, Bark/ranged, Pounce/dash, Howl/AoE) that drop randomly during runs
- At least 6 enemy types across the 3 floors with distinct attack patterns
- Boss fight at the end of each floor (3 bosses total)
- Home base (The Kennel) where the player returns between runs to: rescue/recruit new pack dogs, assign dogs to roles (guard, forager, builder), spend resources on permanent upgrades
- Resource loop: runs yield Bones (currency) and Treats (rare currency) used for upgrades at The Kennel
- Permanent progression: upgrade paths for health, damage, dodge speed, ability cooldown, and kennel buildings
- Local co-op: second player joins with a controller, picks their own dog character, shared screen
- Run takes 10-15 minutes to complete
- Game feels complete: main menu, character select, pause menu, game over screen, victory screen

## Hard Failure Conditions

- Combat feels sluggish or unresponsive (>3 frame input delay, no hit feedback, no screen shake)
- Procedural generation produces unplayable or trivially easy rooms
- Co-op breaks single player (balance, camera, UI must work for both modes)
- Base management feels like a chore rather than a reward (too many clicks, unclear benefit)
- No sense of progression between runs (player doesn't feel stronger over time)
- Game crashes or has soft-locks during runs

## Non-Scope

- Online multiplayer (local co-op only, no netcode)
- Mobile or console builds (PC/Mac only)
- Story mode or cutscenes (emergent narrative through gameplay only)
- Crafting system (resource spending is direct upgrades, not crafting recipes)
- More than 3 floors per run (keep runs short and replayable)
- Procedural art generation (all art is hand-made or placeholder sprites)
- Save system beyond run persistence (roguelite: meta-progression saves, individual runs do not)
- Leaderboards or online features
- Mod support

## Core Constraints

| Constraint | Value | Reason |
|------------|-------|--------|
| Platform | PC/Mac | Scope control — no console/mobile porting |
| Team size | 1 (solo) | Solo developer project |
| Characters | 2 (Malinois, Vizsla) | Scope control — 3rd character deferred |
| Failed run penalty | Lose 30% resources | Stakes without frustration |
| Engine | Unity 2022.3 LTS | Stable, proven 2D support |
| Max players | 2 (local co-op) | No netcode complexity |
| Run length | 10-15 minutes | Roguelite replayability sweet spot |
| Floors per run | 3 | Scope control — short, repeatable runs |
| Base complexity | 3 buildings, 3 roles | Prevent scope creep from Cult of the Lamb depth |
