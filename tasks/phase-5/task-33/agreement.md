# Agreement — T033: Dog Rescue Mechanic

**Status:** APPROVED
**Approved:** 2026-03-20

## Scope
Implement the dog rescue mechanic: RescueDog entity in treasure rooms, trigger-based rescue interaction, run-time tracking in RunManager, end-of-run transfer to MetaProgressionManager, random name and breed generation.

## Checkpoint Parameters
- RescueDog MonoBehaviour with colored sprite, "!" marker, and trigger collider
- Treasure room spawning: 1 dog per treasure room
- RunManager tracks rescued dogs during active run
- End-of-run transfer to MetaProgressionManager.AddDog()
- Random name generator (20+ names) and random breed color (4+ colors)

## Out of Scope
- Dog roster UI and role assignment (T035)
- MetaProgressionManager implementation (T032) — this task only calls AddDog()
- Kennel scene display of rescued dogs (T034)
- Dog happiness mechanics (future phase)

## Acceptance Criteria
- [ ] RescueDog prefab has a colored sprite, "!" marker, and trigger collider
- [ ] Player entering trigger collider rescues the dog (collider disabled, visual feedback)
- [ ] Each treasure room spawns exactly 1 rescue dog at a designated spawn point
- [ ] Rescued dogs are tracked in RunManager during the run
- [ ] At run end, all rescued dogs are transferred to MetaProgressionManager roster
- [ ] Random name generator picks from a list of at least 20 dog names
- [ ] Random breed generates a visual color variation (at least 4 distinct colors)
