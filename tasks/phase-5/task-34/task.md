# [T034] Kennel Scene & Navigation

**Phase:** 5
**Status:** PENDING
**Complexity:** Medium
**Estimated Scope:** 2 files, ~250 lines

## Objective
Create the Kennel scene — the home base where players manage dogs, build structures, and start runs. The scene features a walkable area with building spots, reuses the existing PlayerController for movement, and includes an Editor menu item for scene setup.

## Deliverables
- Kennel scene: 20x16 unit walkable area with fence walls and floor background
- `KennelManager` MonoBehaviour: manages Kennel scene state, building spot references, player spawn
- 3 building spots (Training Yard, Scavenger Den, Doghouse) shown as colored zones
- Camera follows player (reuse existing camera follow logic)
- No enemies in Kennel scene
- Player spawns at center when entering Kennel after a run
- Editor script: `CreateKennelScene()` menu item under DogPack menu

## Files Likely Touched
- `Scripts/Kennel/KennelManager.cs` — new MonoBehaviour managing Kennel scene
- `Editor/SceneSetup.cs` — add CreateKennelScene() method

## Dependencies
- Depends On: T031
- Blocks: T035, T036, T037

## Acceptance Criteria
- [ ] Kennel scene exists with a 20x16 unit walkable area
- [ ] Floor background and fence walls bound the play area
- [ ] Player spawns at center and can walk around using existing PlayerController
- [ ] Camera follows player (reuse existing CameraFollow or equivalent)
- [ ] 3 building spots visible as distinct colored zones (Training Yard, Scavenger Den, Doghouse)
- [ ] No enemy spawning in Kennel scene
- [ ] KennelManager holds references to building spots and player spawn point
- [ ] Editor menu item "DogPack/Create Kennel Scene" creates and configures the scene

## Notes
- Building spot colors: Training Yard (red zone), Scavenger Den (green zone), Doghouse (blue zone)
- Building spots are trigger colliders that the player walks into to interact
- Kennel scene is separate from dungeon scenes — loaded via SceneManager
- PlayerController should work without modification (disable dodge in Kennel if needed)
- No combat in Kennel — weapon systems can be inactive
