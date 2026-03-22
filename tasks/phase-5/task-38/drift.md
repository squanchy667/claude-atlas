# Drift Log — T038: Phase 5 Integration Test

## Drift Events

### Drift-001: UpgradeManager NullReferenceException
- **Date:** 2026-03-20
- **Severity:** High
- **What happened:** Pressing E near building spot crashed with NullRef in UpgradeManager.
- **Root cause:** C# array initializers evaluate all elements before assignment. Tier 2 prerequisite lookup accessed the array before it was assigned.
- **Resolution:** Build arrays element-by-element instead of using initializer syntax.

### Drift-002: UI buttons not clickable (no EventSystem)
- **Date:** 2026-03-20
- **Severity:** High
- **What happened:** Start Run button and all other UI buttons didn't respond to mouse clicks.
- **Root cause:** Unity UI buttons require EventSystem + InputSystemUIInputModule. Neither scene had one.
- **Resolution:** Added EventSystem to both Kennel and Dungeon scene setups.

### Drift-003: Scene not in Build Settings
- **Date:** 2026-03-20
- **Severity:** High
- **What happened:** Transitioning to DungeonTest scene failed with "Scene couldn't be loaded."
- **Root cause:** SceneManager.LoadScene requires scenes registered in Build Settings.
- **Resolution:** Added editor menu item "Add Scenes to Build Settings" that registers all game scenes.
