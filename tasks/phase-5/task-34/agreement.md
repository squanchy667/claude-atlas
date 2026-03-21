# Agreement — T034: Kennel Scene & Navigation

**Status:** APPROVED
**Approved:** 2026-03-20

## Scope
Create the Kennel home base scene with walkable area, 3 building spots, player navigation reusing existing PlayerController, camera follow, and an Editor menu item for scene setup.

## Checkpoint Parameters
- Kennel scene: 20x16 unit walkable area with floor and fence walls
- KennelManager MonoBehaviour managing scene state, building spot references, player spawn
- 3 building spots as colored zones (Training Yard=red, Scavenger Den=green, Doghouse=blue)
- Player spawns at center, camera follows player
- No enemies in scene
- Editor/SceneSetup.cs CreateKennelScene() menu item

## Out of Scope
- Dog roster UI overlay (T035)
- Building interaction and upgrade UI (T036)
- Scene transition logic between Kennel and Dungeon (T037)
- MetaProgressionManager singleton (T032)

## Acceptance Criteria
- [ ] Kennel scene exists with a 20x16 unit walkable area
- [ ] Floor background and fence walls bound the play area
- [ ] Player spawns at center and can walk around using existing PlayerController
- [ ] Camera follows player (reuse existing CameraFollow or equivalent)
- [ ] 3 building spots visible as distinct colored zones (Training Yard, Scavenger Den, Doghouse)
- [ ] No enemy spawning in Kennel scene
- [ ] KennelManager holds references to building spots and player spawn point
- [ ] Editor menu item "DogPack/Create Kennel Scene" creates and configures the scene
