# [T046] Main Menu Scene

**Phase:** 7
**Status:** PENDING
**Complexity:** Medium
**Estimated Scope:** 2 files, ~150 lines

## Objective
Create the main menu scene with title text "DogPack Roguelite", a Start button that loads the Kennel scene, an Options button (placeholder — logs to console), and a Quit button. Background should be dark with a colored accent. Add an Editor menu item `CreateMainMenuScene()` for easy scene setup. Add the scene to Build Settings.

## Deliverables
- Main menu scene with title text, Start/Options/Quit buttons
- Start button loads Kennel scene
- Options button is a placeholder (logs "Options not implemented")
- Quit button calls Application.Quit()
- Dark background with colored accent
- Editor menu item `CreateMainMenuScene()` in SceneSetup
- Scene added to Build Settings

## Files Likely Touched
- `Scripts/UI/MainMenuUI.cs` — new MonoBehaviour for menu logic
- `Editor/SceneSetup.cs` — add CreateMainMenuScene() menu item

## Dependencies
- Depends On: None
- Blocks: T053

## Acceptance Criteria
- [ ] MainMenu scene exists and is in Build Settings
- [ ] Title text displays "DogPack Roguelite"
- [ ] Start button loads the Kennel scene
- [ ] Options button logs placeholder message to console
- [ ] Quit button calls Application.Quit()
- [ ] Background is dark with a colored accent
- [ ] Editor menu item CreateMainMenuScene() creates the scene
- [ ] Scene loads without errors

## Notes
- MainMenuUI follows the same UI pattern as other UI scripts in the project
- Scene should be index 0 in Build Settings (first scene loaded)
