# Outcome — T049: Screen Transitions (Fade)

**Status:** DONE
**Date:** 2026-03-22

## What Was Built
ScreenFade lazy singleton with a full-screen black Image overlay on a Canvas set to Screen Space - Overlay with highest sort order. FadeOut lerps alpha from 0 to 1 over 0.5 seconds, FadeIn lerps alpha from 1 to 0 over 0.5 seconds, both using coroutines. Canvas uses DontDestroyOnLoad to persist across scene transitions. SceneTransitionManager updated to orchestrate FadeOut -> LoadScene -> FadeIn for all scene transitions (main menu to kennel, kennel to dungeon, dungeon to kennel, and all other transitions).

## Deliverables
- [x] ScreenFade component exists with a full-screen black Image overlay
- [x] FadeOut lerps alpha from 0 to 1 over 0.5 seconds
- [x] FadeIn lerps alpha from 1 to 0 over 0.5 seconds
- [x] SceneTransitionManager calls FadeOut -> LoadScene -> FadeIn
- [x] Transition works for main menu -> kennel
- [x] Transition works for kennel -> dungeon
- [x] Transition works for dungeon -> kennel
- [x] ScreenFade canvas persists across scene loads (DontDestroyOnLoad)
- [x] No visual glitches during transitions

## Files Changed
| File | Change |
|------|--------|
| Scripts/UI/ScreenFade.cs | New — lazy singleton with fade in/out coroutines, DontDestroyOnLoad canvas overlay |
| Scripts/Core/SceneTransitionManager.cs | Modified — all transition methods now use ScreenFade fade out/in sequence |

## Drift Events
None.
