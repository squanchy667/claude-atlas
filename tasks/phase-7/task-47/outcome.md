# Outcome — T047: Pause Menu

**Status:** DONE
**Date:** 2026-03-22

## What Was Built
Pause menu overlay that toggles on Escape key press during dungeon runs. Semi-transparent background overlay with Resume, Restart Run, Quit to Kennel, and Quit to Main Menu buttons. Pausing sets Time.timeScale to 0, resuming restores it to 1. All button actions reset timeScale before loading scenes. Works in co-op mode where either player can pause. Game input blocked while paused (only menu input works). PauseMenuUI added to dungeon scenes via SceneSetup.

## Deliverables
- [x] Pressing Escape toggles the pause overlay
- [x] Pause overlay displays Resume, Restart Run, Quit to Kennel, Quit to Main Menu
- [x] Resume button unpauses and hides the overlay
- [x] Restart Run reloads the current dungeon scene
- [x] Quit to Kennel loads the Kennel scene
- [x] Quit to Main Menu loads the MainMenu scene
- [x] Time.timeScale is 0 while paused, 1 while unpaused
- [x] Either player can pause in co-op mode
- [x] Game input is blocked while paused (only menu input works)

## Files Changed
| File | Change |
|------|--------|
| Scripts/UI/PauseMenuUI.cs | New — MonoBehaviour for pause overlay toggle, buttons, and time scale management |
| Editor/SceneSetup.cs | Modified — PauseMenuUI creation in dungeon scene setup |

## Drift Events
None.
