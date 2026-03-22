# Agreement — T049: Screen Transitions (Fade)

**Status:** APPROVED
**Approved:** 2026-03-22

## Scope
Implement ScreenFade canvas overlay utility that fades to/from black over 0.5s. Modify SceneTransitionManager to use FadeOut -> LoadScene -> FadeIn sequence for all scene transitions (main menu to kennel, kennel to dungeon, dungeon to kennel). ScreenFade persists across scenes via DontDestroyOnLoad.

## Checkpoint Parameters
- ScreenFade with full-screen black Image overlay
- FadeOut (0->1 alpha) and FadeIn (1->0 alpha) over 0.5s each
- SceneTransitionManager orchestrates FadeOut -> LoadScene -> FadeIn
- Works for all 3 transition paths
- Canvas persists across scene loads

## Out of Scope
- Wipe transitions or other transition styles
- Loading screen or progress bar
- Async scene loading with progress callback

## Acceptance Criteria
- [ ] ScreenFade component exists with a full-screen black Image overlay
- [ ] FadeOut lerps alpha from 0 to 1 over 0.5 seconds
- [ ] FadeIn lerps alpha from 1 to 0 over 0.5 seconds
- [ ] SceneTransitionManager calls FadeOut -> LoadScene -> FadeIn
- [ ] Transition works for main menu -> kennel
- [ ] Transition works for kennel -> dungeon
- [ ] Transition works for dungeon -> kennel
- [ ] ScreenFade canvas persists across scene loads (DontDestroyOnLoad)
- [ ] No visual glitches during transitions
