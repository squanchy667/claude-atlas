# Phase 7 — Polish & UI

## Goal
Main menu, character select screen, pause menu, game over / victory screens, audio system (SFX + music), screen transitions, particle effects, difficulty scaling (AnimationCurve-based), game feel pass (juice: screenshake, hitstop, trails).

## Key Deliverables
- Main menu scene (Start, Options, Quit)
- Character select screen (works for 1-2 players)
- Pause menu (resume, restart, quit to menu)
- Game over screen (stats summary, return to kennel or retry)
- Victory screen (run complete, loot summary)
- Audio system: SFX manager with ScriptableObject sound banks
- Music system: per-scene music with crossfade transitions
- Screen transitions (fade, wipe)
- Particle effects: hit sparks, dodge dust, ability VFX, death poof
- Difficulty scaling: AnimationCurve-based enemy stats per floor
- Game feel pass: screen shake tuning, hitstop refinement, attack trails
- Overall polish: consistent placeholder art, clear UI readability

## Entry Criteria
- Phase 6 complete: co-op works, full game loop for 1-2 players

## Exit Criteria
- Complete menu flow: main menu → character select → run → game over/victory → kennel → repeat
- Audio plays for all major actions (attack, hit, dodge, pickup, menu navigation)
- Music loops per scene with transitions
- All screens are functional and navigable
- Game feel is responsive and satisfying (subjective quality gate)
- No crashes or soft-locks in full play-through
- Difficulty curve feels fair across 3 floors

## Dependencies
- Phase 6 (co-op, all gameplay systems)
