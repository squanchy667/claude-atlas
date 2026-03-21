# [T033] Dog Rescue Mechanic

**Phase:** 5
**Status:** PENDING
**Complexity:** Medium
**Estimated Scope:** 2 files, ~200 lines

## Objective
Implement the dog rescue mechanic: spawn rescueable dogs in treasure rooms during dungeon runs. Player walks near a dog to rescue it. Rescued dogs are stored in RunManager during the run and transferred to the MetaProgressionManager roster when the run ends.

## Deliverables
- `RescueDog` MonoBehaviour: colored sprite with "!" marker above head, trigger collider for rescue detection, random name and breed generation
- Treasure room spawning: 1 rescueable dog per treasure room, spawned at a designated point
- Run-time tracking: rescued dogs stored in RunManager during active run
- End-of-run transfer: rescued dogs moved to MetaProgressionManager.AddDog() when run completes
- Random name generator with a list of dog names
- Random breed assignment (visual color variation)

## Files Likely Touched
- `Scripts/Kennel/RescueDog.cs` — new MonoBehaviour for rescueable dog entity
- `Scripts/Dungeon/RoomController.cs` — modify treasure room logic to spawn rescue dogs

## Dependencies
- Depends On: T031
- Blocks: T035

## Acceptance Criteria
- [ ] RescueDog prefab has a colored sprite, "!" marker, and trigger collider
- [ ] Player entering trigger collider rescues the dog (collider disabled, visual feedback)
- [ ] Each treasure room spawns exactly 1 rescue dog at a designated spawn point
- [ ] Rescued dogs are tracked in RunManager during the run
- [ ] At run end, all rescued dogs are transferred to MetaProgressionManager roster
- [ ] Random name generator picks from a list of at least 20 dog names
- [ ] Random breed generates a visual color variation (at least 4 distinct colors)

## Notes
- Dog names: Rex, Luna, Max, Bella, Charlie, Daisy, Rocky, Sadie, Duke, Molly, Bear, Maggie, Tucker, Chloe, Jack, Sophie, Cooper, Bailey, Buddy, Rosie
- Breed colors: Brown (#8B4513), Golden (#DAA520), White (#F5F5DC), Black (#2C2C2C)
- "!" marker uses TextMeshPro or simple sprite above the dog
- Rescue triggers GameEvents for UI notification
