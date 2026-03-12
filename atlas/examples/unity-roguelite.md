# Atlas Setup Example — Unity Roguelite (Cult of the Lamb-inspired)

Based on the DogPack Roguelite project setup: 7 phases, ~35 tasks estimated, complex scope with co-op.

---

## Q1 — Project Name
```
DogPack Roguelite
```

## Q2 — Description
```
A 2D top-down roguelite game inspired by Cult of the Lamb where players control dog characters through procedurally generated dungeon runs with melee/ranged combat, dodge-rolling, and a home base (The Kennel) where they manage and upgrade their pack of rescued dogs between runs. Single player core with local co-op support for 2 players.
```

## Q3 — Problem
```
Cult of the Lamb fans want more games in the same genre — top-down action roguelites with base management — but with a fresh, lighter theme. Most roguelites are dark/gothic themed. This game replaces the cult aesthetic with a playful dog pack fantasy: you're the Alpha dog building a pack, rescuing strays, and fighting through dangerous territories. The co-op element adds replayability that Cult of the Lamb lacks — playing couch co-op with a friend in a roguelite with base building doesn't exist in a polished, accessible form. Target audience: fans of Cult of the Lamb, Hades, and Enter the Gungeon who want a lighter-themed, co-op-friendly roguelite. Ages 10+, casual to mid-core gamers, couch co-op players.
```

## Q4 — Stack
```
Engine: Unity 2022.3 LTS (2D URP). Language: C#. Architecture: Singleton-Events-ScriptableObject trinity pattern. Physics: Unity 2D Physics (Rigidbody2D, BoxCollider2D). Input: Unity Input System (new) with PlayerInputManager for co-op. UI: Canvas-based UI. Animation: Unity Animator with blend trees for 8-directional movement. Audio: Unity Audio with ScriptableObject-based sound bank. Level Generation: Room-based procedural generation using prefab rooms connected by corridors. Data: ScriptableObjects for all game config (characters, weapons, enemies, upgrades). Art Style: 2D pixel art top-down (placeholder sprites initially, designed for asset swap). Version Control: Git.
```

## Q5 — Team Size
```
1
```

## Q6 — Success Criteria
```
- Player can select from 3 playable dog characters, each with a unique active ability and passive trait
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
```

## Q7 — Failure Conditions
```
- Combat feels sluggish or unresponsive (>3 frame input delay, no hit feedback, no screen shake)
- Procedural generation produces unplayable or trivially easy rooms
- Co-op breaks single player (balance, camera, UI must work for both modes)
- Base management feels like a chore rather than a reward (too many clicks, unclear benefit)
- No sense of progression between runs (player doesn't feel stronger over time)
- Game crashes or has soft-locks during runs
```

## Q8 — Non-Scope
```
- Online multiplayer (local co-op only, no netcode)
- Mobile or console builds (PC/Mac only)
- Story mode or cutscenes (emergent narrative through gameplay only)
- Crafting system (resource spending is direct upgrades, not crafting recipes)
- More than 3 floors per run (keep runs short and replayable)
- Procedural art generation (all art is hand-made or placeholder sprites)
- Save system beyond run persistence (roguelite: meta-progression saves, individual runs do not)
- Leaderboards or online features
- Mod support
```

## Q9 — Phases
```
Phase 1 — Foundation: Project setup, input system, player controller (movement, dodge roll), camera system, basic room with placeholder art. Player can move around a test room and dodge.

Phase 2 — Combat Core: Weapon system (4 types as ScriptableObjects), attack animations, hit detection, damage system, health system with UI, enemy AI (basic chase + attack), hit feedback (screen shake, flash, knockback). Player can fight enemies in a test room.

Phase 3 — Dungeon Generation: Room prefab system, procedural floor generator (connect rooms with corridors/doors), room types (combat, treasure, shop, boss), floor progression (3 floors), minimap. Player can run through a generated dungeon.

Phase 4 — Characters & Enemies: 3 playable dog characters with unique abilities and stats (ScriptableObject-driven), 6 enemy types with distinct behaviors, 3 boss fights, enemy spawning system per room.

Phase 5 — The Kennel (Base): Home base scene, rescued dog management (recruit from runs), role assignment system, building/upgrade system, resource economy (Bones + Treats), permanent meta-progression upgrades.

Phase 6 — Co-op: PlayerInputManager for 2-player local co-op, split character select, shared camera with dynamic zoom, co-op balancing (enemy scaling), shared resource pool, revive mechanic.

Phase 7 — Polish & UI: Main menu, character select screen, pause menu, game over / victory screens, audio system (SFX + music), screen transitions, particle effects, difficulty scaling (AnimationCurve-based), game feel pass (juice: screenshake, hitstop, trails).
```

## Q10 — Risks
```
- Procedural generation quality: rooms may feel repetitive or produce bad layouts. Mitigation: hand-design 15-20 room templates per floor and randomize composition, not structure.
- Co-op camera: shared screen with two players moving independently is hard. Mitigation: dynamic camera zoom that pulls back when players separate, with a max separation leash.
- Combat feel: making top-down melee combat feel good requires extensive tuning. Mitigation: dedicate Phase 7 to game feel, use AnimationCurve-based tuning for all combat parameters.
- Scope creep on base management: Cult of the Lamb's base is deep. Mitigation: keep it to 3 building types and 3 role types max. Functional, not deep.
- Unity Editor tasks can't be done via CLI: sprites, scenes, prefabs need Editor. Mitigation: use Editor setup scripts (C# in Editor/) to programmatically create scenes and wire prefabs.
- Placeholder art may make it hard to judge game feel. Mitigation: use consistent style (colored shapes with clear silhouettes) so gameplay reads clearly even without final art.
```

## Q11 — Integrations
```
No external services or APIs. Fully offline, local game. Unity packages needed: com.unity.inputsystem (new Input System for co-op controller support), com.unity.2d.animation (sprite animation), com.unity.2d.tilemap (tilemap for room construction), com.unity.2d.tilemap.extras (rule tiles for auto-tiling). No environment variables, no auth, no cloud services.
```

---

## Expected Output

| Metric | Estimate |
|--------|----------|
| Total tasks | 30-40 |
| Phases | 7 |
| C# scripts | 50-70 |
| Lines of code | 4,000-6,000 |
| ScriptableObjects | 8-12 definitions |
| Sessions | 3-5 |

## Key Design Decisions

- **Singleton-Events-SO Trinity** — Same proven pattern from FlappyKookaburra, scaled up
- **Room-based procedural generation** — Prefab rooms, not tile-by-tile generation. Guarantees playable layouts.
- **ScriptableObject-driven everything** — Characters, weapons, enemies, upgrades all defined as SO assets. Swap stats without touching code.
- **Co-op as a late phase** — Build single-player first, add co-op after core is solid. Prevents co-op concerns from polluting the foundation.
- **Base management kept simple** — 3 building types, 3 roles. Resist the urge to match Cult of the Lamb's depth.

## Gotchas

- Unity Input System (new) requires PlayerInputManager component for multi-player — can't use the old Input class for co-op
- 8-directional blend trees need specific parameter naming (MoveX, MoveY) and threshold setup in Animator
- Room transitions need to disable player input briefly to prevent movement during door animations
- Boss rooms should lock doors until boss is defeated — needs a room state machine
- Co-op camera zoom needs clamping (min/max) to prevent infinite zoom-out when players separate
