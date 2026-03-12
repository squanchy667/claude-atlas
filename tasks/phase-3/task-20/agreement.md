# Agreement — T020: Floor Progression
## Status: APPROVED
## Approved: 2026-03-12 (auto-approved by atlas-run --full-permission)

## Scope
- FloorPortal MonoBehaviour (trigger, visual, floor transition)
- RunManager singleton (run state tracking)
- Floor transition flow: boss dies → portal spawns → player enters → new floor generated
- Difficulty scaling via FloorConfig.difficultyMultiplier
- 3 FloorConfig assets (gray/brown/purple floors)

## Not In Scope
- Resource collection (Phase 5)
- Kennel return (Phase 5)
- Run failure handling (future)

## Checkpoint Parameters
- Portal spawns after boss defeat
- Floor transition works for all 3 floors
- Difficulty scales between floors
- RunManager state is accurate
- Run completes after Floor 3 boss

## Skills Used
- singleton-events-pattern
- scriptableobject-data-pattern
