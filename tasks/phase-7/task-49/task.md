# [T049] Screen Transitions (Fade)

**Phase:** 7
**Status:** PENDING
**Complexity:** Medium
**Estimated Scope:** 2 files, ~120 lines

## Objective
Implement a fade-to-black screen transition system. A ScreenFade canvas overlay with an Image component lerps alpha from 0 to 1 (fade out) and 1 to 0 (fade in) over 0.5 seconds. SceneTransitionManager orchestrates the flow: FadeOut, LoadScene, FadeIn. Used for all scene transitions: kennel to dungeon, dungeon to kennel, and main menu to kennel.

## Deliverables
- ScreenFade utility: canvas overlay with black Image that lerps alpha
- Fade out (0 to 1 alpha) over 0.5s
- Fade in (1 to 0 alpha) over 0.5s
- SceneTransitionManager integration: FadeOut -> LoadScene -> FadeIn sequence
- Works for: main menu -> kennel, kennel -> dungeon, dungeon -> kennel transitions

## Files Likely Touched
- `Scripts/UI/ScreenFade.cs` — new MonoBehaviour for fade overlay
- `Scripts/Core/SceneTransitionManager.cs` — modify to use fade transitions

## Dependencies
- Depends On: None
- Blocks: T053

## Acceptance Criteria
- [ ] ScreenFade component exists with a full-screen black Image overlay
- [ ] FadeOut lerps alpha from 0 to 1 over 0.5 seconds
- [ ] FadeIn lerps alpha from 0 to 1 over 0.5 seconds (reverse)
- [ ] SceneTransitionManager calls FadeOut -> LoadScene -> FadeIn
- [ ] Transition works for main menu -> kennel
- [ ] Transition works for kennel -> dungeon
- [ ] Transition works for dungeon -> kennel
- [ ] ScreenFade canvas persists across scene loads (DontDestroyOnLoad)
- [ ] No visual glitches during transitions

## Notes
- ScreenFade uses a Canvas set to Screen Space - Overlay with highest sort order
- Uses coroutines for the lerp timing
- SceneTransitionManager may already exist — modify rather than replace
- Canvas uses DontDestroyOnLoad to persist across scene transitions
