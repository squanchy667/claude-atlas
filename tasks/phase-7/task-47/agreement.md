# Agreement — T047: Pause Menu

**Status:** APPROVED
**Approved:** 2026-03-22

## Scope
Implement a pause menu overlay toggled by Escape/P during dungeon runs. Shows Resume, Restart Run, Quit to Kennel, and Quit to Main Menu buttons. Sets Time.timeScale to 0 on pause, 1 on resume. Either player can pause in co-op mode. Game input is blocked while paused.

## Checkpoint Parameters
- Pause overlay toggles on Escape/P key press
- Resume, Restart Run, Quit to Kennel, Quit to Main Menu buttons functional
- Time.timeScale = 0 while paused, 1 while unpaused
- Either player can trigger pause in co-op
- Game input blocked during pause

## Out of Scope
- Settings/options within pause menu
- Audio pause/resume (T048)
- Screen transitions on scene load (T049)

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
