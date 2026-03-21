# [T037] Scene Transitions & Run Economy

**Phase:** 5
**Status:** PENDING
**Complexity:** High
**Estimated Scope:** 3 files, ~350 lines

## Objective
Implement the full scene transition flow and run economy. The game loop flows: Kennel -> Start Run -> Character Select -> Dungeon -> Run End -> Results Screen -> Kennel. Resources are banked based on run outcome (100% on success, 70% on failure). Results screen shows run statistics. Forager income is applied on return to Kennel.

## Deliverables
- `SceneTransitionManager` singleton: orchestrates scene loading between Kennel, Character Select, Dungeon, and Results scenes
- `RunResultsUI` Canvas overlay: displays run statistics (floors cleared, enemies killed, bones/treats earned, dogs rescued) with "Return to Kennel" button
- RunManager modifications: handle run end flow, resource banking with success/failure multiplier, Forager income calculation
- Singleton cleanup on scene transitions (ensure managers survive correctly)
- Scene loading via SceneManager.LoadScene with proper state handoff

## Files Likely Touched
- `Scripts/Core/SceneTransitionManager.cs` — new singleton for scene flow
- `Scripts/UI/RunResultsUI.cs` — new results screen UI
- `Scripts/Core/RunManager.cs` — modify run end flow for resource banking

## Dependencies
- Depends On: T032, T034
- Blocks: T038

## Acceptance Criteria
- [ ] Scene flow works: Kennel -> Character Select -> Dungeon -> Results -> Kennel
- [ ] SceneTransitionManager loads scenes correctly via SceneManager.LoadScene
- [ ] On run complete (all floors cleared): 100% of collected resources banked
- [ ] On run fail (player dies): 70% of collected resources banked, 30% lost
- [ ] Results screen shows: floors cleared, enemies killed, bones earned, treats earned, dogs rescued
- [ ] "Return to Kennel" button on results screen loads Kennel scene
- [ ] Forager income added when returning to Kennel (based on assigned Forager count and Scavenger Den tier)
- [ ] Singletons (MetaProgressionManager, SceneTransitionManager) survive scene transitions
- [ ] Non-persistent managers are properly cleaned up on scene unload
- [ ] Player spawns correctly in Kennel after returning from a run

## Notes
- SceneTransitionManager is DontDestroyOnLoad, persists for entire session
- Resource banking formula: earnedResources * (runComplete ? 1.0f : 0.7f)
- Forager income: numberOfForagers * scavengerDenIncomePerForager (from building tier)
- Character Select scene already exists from Phase 4 — reuse it
- Consider a brief fade-to-black transition between scenes (optional, can be simple)
- RunManager.EndRun() should trigger the results flow instead of directly restarting
