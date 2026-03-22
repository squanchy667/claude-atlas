# Agreement — T051: Difficulty Scaling (AnimationCurve)

**Status:** APPROVED
**Approved:** 2026-03-22

## Scope
Create DifficultyConfig ScriptableObject with AnimationCurve fields for enemyHP, enemyDamage, enemySpeed, and enemyCount. X axis = floor number (1-3), Y axis = multiplier. Modify RoomController to apply these multipliers when spawning enemies. Default curves provide a gentle ramp. Runtime fallback creates default config if no asset exists.

## Checkpoint Parameters
- DifficultyConfig ScriptableObject with 4 AnimationCurve fields
- Curves map floor number (1-3) to multiplier values
- RoomController applies multipliers to enemy stats on spawn
- Default gentle ramp curves (1.0 -> 1.3 -> 1.8 range)
- Runtime fallback for missing asset
- Curves editable in Unity Inspector

## Out of Scope
- Per-enemy-type difficulty curves
- Dynamic difficulty adjustment based on player performance
- Difficulty settings UI (easy/normal/hard)
- Co-op difficulty scaling (handled by existing co-op enemy scaling)

## Acceptance Criteria
- [ ] DifficultyConfig ScriptableObject exists with [CreateAssetMenu]
- [ ] Four AnimationCurve fields: enemyHP, enemyDamage, enemySpeed, enemyCount
- [ ] Curves use floor number (1-3) as X axis and multiplier as Y axis
- [ ] RoomController reads DifficultyConfig to scale enemy stats on spawn
- [ ] Default curves provide gentle ramp (1.0 at floor 1, ~1.3 at floor 2, ~1.8 at floor 3)
- [ ] Runtime fallback creates default DifficultyConfig if no asset exists
- [ ] Enemy HP, damage, speed, and count are visibly scaled per floor
- [ ] Curves are editable in the Unity Inspector
