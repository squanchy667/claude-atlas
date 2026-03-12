# Atlas Setup Example — Unity 2D Game (Flappy Bird)

Based on the FlappyKookaburra project: 33 tasks, 6 phases, 35 scripts, 2,193 LOC, completed in 2 sessions.

---

## Q1 — Project Name
```
FlappyBird
```

## Q2 — Description
```
A Flappy Bird clone built in Unity — tap to flap, dodge pipes, chase high scores. Simple, polished, and juicy.
```

## Q3 — Problem
```
Flappy Bird is the gold standard for "simple to learn, impossible to master" mobile games. This project is a learning exercise in building a complete, polished 2D game with Unity — covering core gameplay, difficulty progression, object pooling, UI flow, audio, and visual juice. Target audience: the developer building it (learning Unity patterns) and casual players who enjoy high-score chasing.
```

## Q4 — Stack
```
Engine: Unity 2022.3 LTS (2D). Language: C#. Architecture: Singleton-Events-ScriptableObject trinity pattern. Physics: Unity 2D Physics (Rigidbody2D, CircleCollider2D for bird, BoxCollider2D for pipes). Input: Unity legacy Input (Input.GetMouseButtonDown for tap). UI: Canvas-based UI. Animation: Unity Animator for bird, scale-based squash/stretch via code. Audio: Unity AudioSource with ScriptableObject-based AudioConfig. Data: ScriptableObjects for bird stats, difficulty curves, audio config. Art Style: 2D pixel art (placeholder sprites, designed for asset swap). Version Control: Git.
```

## Q5 — Team Size
```
1
```

## Q6 — Success Criteria
```
- Tap to flap with responsive physics (instant upward force, gravity pulls down)
- Pipes spawn endlessly with randomized gap positions
- Score increments when passing through a pipe gap
- High score persists between sessions (PlayerPrefs)
- Difficulty increases over time via AnimationCurve (pipe speed, gap size, spawn rate)
- Object pooling for pipes and particles (zero runtime allocations)
- Complete UI flow: Title screen → Playing → Game Over (with score, high score, restart)
- Screen shake and flash on death
- Audio: flap SFX, score SFX, death SFX, background ambient
- Parallax scrolling background (2-3 layers)
- Game feels polished: squash/stretch on flap, score punch animation, smooth transitions
```

## Q7 — Failure Conditions
```
- Flap feels floaty or unresponsive
- Pipes overlap or spawn in unplayable configurations
- No sense of progression (game feels the same at score 1 and score 50)
- UI transitions are jarring (hard cuts, no animation)
- Game crashes or freezes during play
```

## Q8 — Non-Scope
```
- Multiple characters or skins
- Online leaderboards
- Mobile deployment (desktop only for now)
- Level editor
- Power-ups or items
- Multiplayer
- Ads or monetization
```

## Q9 — Phases
```
Phase 1 — Foundation: Unity project setup, GameManager singleton, ScriptableObject definitions (BirdStats, DifficultyConfig, AudioConfig), object pool utility, camera and world bounds. Result: empty scene with infrastructure ready.

Phase 2 — Core Gameplay: Player controller (tap-to-flap, gravity, rotation toward velocity), pipe spawner with object pooling, score zone trigger, score manager with high score persistence, basic UI (title, HUD, game over). Result: playable game loop.

Phase 3 — Polish: Difficulty manager with AnimationCurve progression (pipe speed, gap size, spawn rate), audio manager (flap/score/death SFX, ambient), parallax scrolling background, pipe art (placeholder sprites), bird animation (squash/stretch on flap, tilt toward velocity). Result: game feels good.

Phase 4 — Production: UI polish (score punch animation, screen shake on death, flash on death, smooth transitions between states), performance optimization (Camera.main caching, pool sizing), final tuning pass (gravity, flap force, difficulty curve, grace period on start). Result: shippable game.
```

## Q10 — Risks
```
- Flap physics tuning: too floaty or too snappy. Mitigation: expose all values via BirdStats ScriptableObject, tune in Inspector.
- Difficulty curve balance: too easy or too punishing. Mitigation: AnimationCurve in DifficultyConfig SO, visual editor in Inspector.
- Unity Editor tasks can't be done via CLI: scenes, prefabs, sprite import. Mitigation: use Editor/ setup scripts to programmatically create scenes and wire prefabs.
- Object pool sizing: too small causes runtime allocation, too large wastes memory. Mitigation: dedicated performance task to profile and tune.
```

## Q11 — Integrations
```
No external services. Fully offline. No Unity packages beyond defaults (2D Sprite already included). No environment variables, no auth, no cloud.
```

---

## What Was Actually Built (FlappyKookaburra Stats)

| Metric | Value |
|--------|-------|
| Total tasks | 33 (20 original + 13 premium upgrade) |
| Phases | 6 (4 planned + 2 art/UI premium) |
| C# scripts | 35 |
| Lines of code | 2,193 |
| Test files | 7 (4 PlayMode + 3 EditMode) |
| Agent types | 9 specialized |
| Sessions | 2 |
| ScriptableObjects | 5 (BirdStats, DifficultyConfig, AudioConfig, UIColorPalette, MedalConfig) |

## Key Patterns Discovered

- **Singleton-Events-SO Trinity** — GameManager, ScoreManager, AudioManager all follow the same template
- **AnimationCurve difficulty** — Designers tune progression visually in Inspector, no code changes
- **Object pooling from Phase 1** — Zero GC allocations during gameplay
- **Scale-based animation** — Simpler and more robust than multi-part rig rotation
- **Grace period on start** — 2s delay before first pipe spawns, massively improves first-play experience
- **Editor/ setup scripts** — Programmatically create scenes and wire prefabs when CLI can't use Unity Editor

## Gotchas

- Parallel agents on the same repo cause branch contention — use sequential execution or git worktrees
- Unity Editor tasks (sprites, scenes, prefabs) can't complete via CLI — mark DONE* with manual steps noted
- Tests can be written but not executed from CLI — quality assessed by code review only
- Placeholder sprites need consistent style (colored shapes with clear silhouettes) to judge game feel
