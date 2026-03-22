# [T047] Pause Menu

**Phase:** 7
**Status:** PENDING
**Complexity:** Low
**Estimated Scope:** 1 file, ~120 lines

## Objective
Implement a pause menu overlay that toggles when the player presses Escape or P during dungeon runs. The overlay shows Resume, Restart Run, Quit to Kennel, and Quit to Main Menu buttons. Pausing sets `Time.timeScale = 0` and resuming sets it back to `1`. In co-op mode, either player can pause the game.

## Deliverables
- Pause menu overlay UI with semi-transparent background
- Toggle on Escape or P key press
- Resume button (unpauses)
- Restart Run button (reloads dungeon scene)
- Quit to Kennel button (loads Kennel scene)
- Quit to Main Menu button (loads MainMenu scene)
- Time.timeScale set to 0 on pause, 1 on resume
- Works in co-op (either player can pause)

## Files Likely Touched
- `Scripts/UI/PauseMenuUI.cs` — new MonoBehaviour for pause overlay

## Dependencies
- Depends On: None
- Blocks: T053

## Acceptance Criteria
- [ ] Pressing Escape or P toggles the pause overlay
- [ ] Pause overlay displays Resume, Restart Run, Quit to Kennel, Quit to Main Menu
- [ ] Resume button unpauses and hides the overlay
- [ ] Restart Run reloads the current dungeon scene
- [ ] Quit to Kennel loads the Kennel scene
- [ ] Quit to Main Menu loads the MainMenu scene
- [ ] Time.timeScale is 0 while paused, 1 while unpaused
- [ ] Either player can pause in co-op mode
- [ ] Game input is blocked while paused (only menu input works)

## Notes
- Uses a Canvas overlay that is disabled by default and enabled on pause
- Time.timeScale = 0 freezes all physics and time-dependent logic
- Button actions should reset timeScale before loading any scene
