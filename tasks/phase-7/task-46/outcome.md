# Outcome — T046: Main Menu Scene

**Status:** DONE
**Date:** 2026-03-22

## What Was Built
Main menu scene with "DogPack Roguelite" title text, Start/Quit buttons, and dark background with colored accent. Start button loads the Kennel scene via SceneTransitionManager. Options button logs placeholder message to console. Quit button calls Application.Quit(). Added CreateMainMenuScene editor menu item to SceneSetup for easy scene creation. SceneTransitionManager extended with GoToMainMenu method for returning to the main menu from other scenes.

## Deliverables
- [x] MainMenu scene exists and is in Build Settings (index 0)
- [x] Title text displays "DogPack Roguelite"
- [x] Start button loads the Kennel scene
- [x] Options button logs placeholder message to console
- [x] Quit button calls Application.Quit()
- [x] Dark background with colored accent
- [x] Editor menu item CreateMainMenuScene() creates the scene
- [x] Scene loads without errors

## Files Changed
| File | Change |
|------|--------|
| Scripts/UI/MainMenuUI.cs | New — MonoBehaviour for main menu button logic and layout |
| Editor/SceneSetup.cs | Modified — added CreateMainMenuScene() editor menu item |
| Scripts/Core/SceneTransitionManager.cs | Modified — added GoToMainMenu() method |

## Drift Events
None.
