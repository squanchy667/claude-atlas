# [T051] Difficulty Scaling (AnimationCurve)

**Phase:** 7
**Status:** PENDING
**Complexity:** Medium
**Estimated Scope:** 2 files, ~150 lines

## Objective
Replace flat difficulty multipliers with AnimationCurve-based scaling. Create a DifficultyConfig ScriptableObject with curves for enemy HP, enemy damage, enemy speed, and enemy count. The X axis represents floor number (1-3) and the Y axis represents the multiplier. Applied in RoomController when spawning enemies. Default curves provide a gentle ramp (e.g., 1.0 -> 1.3 -> 1.8 for HP). If no DifficultyConfig asset exists at runtime, create one with default curves.

## Deliverables
- DifficultyConfig ScriptableObject with AnimationCurve fields
- Curves for: enemyHP, enemyDamage, enemySpeed, enemyCount
- X axis = floor number (1-3), Y axis = multiplier
- RoomController applies multipliers when spawning enemies
- Default curves: gentle ramp (1.0 -> 1.3 -> 1.8 for HP, similar for others)
- Runtime creation of default config if no asset exists

## Files Likely Touched
- `Scripts/Core/DifficultyConfig.cs` — new ScriptableObject
- `Scripts/Dungeon/RoomController.cs` — modify to apply difficulty curves

## Dependencies
- Depends On: None
- Blocks: T053

## Acceptance Criteria
- [ ] DifficultyConfig ScriptableObject exists with [CreateAssetMenu]
- [ ] Four AnimationCurve fields: enemyHP, enemyDamage, enemySpeed, enemyCount
- [ ] Curves use floor number (1-3) as X axis and multiplier as Y axis
- [ ] RoomController reads DifficultyConfig to scale enemy stats on spawn
- [ ] Default curves provide gentle ramp (1.0 at floor 1, ~1.3 at floor 2, ~1.8 at floor 3)
- [ ] Runtime fallback creates default DifficultyConfig if no asset exists
- [ ] Enemy HP, damage, speed, and count are visibly scaled per floor
- [ ] Curves are editable in the Unity Inspector

## Notes
- AnimationCurve is natively supported by Unity's Inspector — no custom editor needed
- DifficultyConfig follows the ScriptableObject data pattern used throughout the project
- RoomController already handles enemy spawning — this adds scaling on top
- Evaluate curves with `curve.Evaluate(floorNumber)` to get the multiplier
