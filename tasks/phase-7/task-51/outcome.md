# Outcome — T051: Difficulty Scaling (AnimationCurve)

**Status:** DONE
**Date:** 2026-03-22

## What Was Built
DifficultyConfig ScriptableObject with four AnimationCurve fields (enemyHP, enemyDamage, enemySpeed, enemyCount) where X axis represents floor number (1-3) and Y axis represents the multiplier. Default curves provide a gentle ramp: 1.0 at floor 1, ~1.3 at floor 2, ~1.8 at floor 3. Runtime fallback creates a default DifficultyConfig via ScriptableObject.CreateInstance if no asset exists. RoomController reads DifficultyConfig and applies multipliers when spawning enemies. EnemyController and BossController modified to accept and apply difficulty multipliers to their HP, damage, and speed stats.

## Deliverables
- [x] DifficultyConfig ScriptableObject exists with [CreateAssetMenu]
- [x] Four AnimationCurve fields: enemyHP, enemyDamage, enemySpeed, enemyCount
- [x] Curves use floor number (1-3) as X axis and multiplier as Y axis
- [x] RoomController reads DifficultyConfig to scale enemy stats on spawn
- [x] Default curves provide gentle ramp (1.0 at floor 1, ~1.3 at floor 2, ~1.8 at floor 3)
- [x] Runtime fallback creates default DifficultyConfig if no asset exists
- [x] Enemy HP, damage, speed, and count are visibly scaled per floor
- [x] Curves are editable in the Unity Inspector

## Files Changed
| File | Change |
|------|--------|
| Scripts/Core/DifficultyConfig.cs | New — ScriptableObject with AnimationCurve fields and default curve creation |
| Scripts/Dungeon/RoomController.cs | Modified — reads DifficultyConfig and applies multipliers on enemy spawn |
| Scripts/Enemies/EnemyController.cs | Modified — accepts and applies difficulty multipliers to HP, damage, speed |
| Scripts/Enemies/BossController.cs | Modified — accepts and applies difficulty multipliers to boss stats |

## Drift Events
None.
