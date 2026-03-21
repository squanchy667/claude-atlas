# Agreement — T037: Scene Transitions & Run Economy

**Status:** APPROVED
**Approved:** 2026-03-20

## Scope
Implement the full scene transition loop (Kennel -> Character Select -> Dungeon -> Results -> Kennel), run economy with success/failure resource multipliers, results screen UI, Forager income on return, and proper singleton lifecycle management across scene loads.

## Checkpoint Parameters
- SceneTransitionManager singleton (DontDestroyOnLoad) orchestrating all scene loads
- RunResultsUI showing floors cleared, enemies killed, bones/treats earned, dogs rescued
- Resource banking: 100% on success, 70% on failure
- Forager income applied on Kennel return
- Proper singleton survival and non-persistent manager cleanup across transitions

## Out of Scope
- Dog roster UI (T035)
- Building/upgrade UI (T036)
- Fade transitions or loading screens (optional polish, not required)
- Multiplayer scene sync (Phase 6)

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
