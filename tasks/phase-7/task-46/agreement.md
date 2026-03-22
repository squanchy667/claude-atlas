# Agreement — T046: Main Menu Scene

**Status:** APPROVED
**Approved:** 2026-03-22

## Scope
Create a main menu scene with title text "DogPack Roguelite", Start button (loads Kennel), Options button (placeholder), and Quit button. Dark background with colored accent. Add Editor menu item `CreateMainMenuScene()` to SceneSetup. Add the scene to Build Settings as index 0.

## Checkpoint Parameters
- MainMenu scene exists and is in Build Settings at index 0
- Title text "DogPack Roguelite" displayed
- Start button loads Kennel scene
- Options button logs placeholder message
- Quit button calls Application.Quit()
- Dark background with colored accent
- Editor menu item CreateMainMenuScene() in SceneSetup

## Out of Scope
- Options menu implementation (placeholder only)
- Character select screen
- Audio on menu buttons (T048)
- Screen transitions from menu (T049)

## Acceptance Criteria
- [ ] MainMenu scene exists and is in Build Settings
- [ ] Title text displays "DogPack Roguelite"
- [ ] Start button loads the Kennel scene
- [ ] Options button logs placeholder message to console
- [ ] Quit button calls Application.Quit()
- [ ] Background is dark with a colored accent
- [ ] Editor menu item CreateMainMenuScene() creates the scene
- [ ] Scene loads without errors
