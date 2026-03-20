# [T030] Phase 4 Integration Test

**Phase:** 4
**Status:** PENDING
**Complexity:** Medium
**Estimated Scope:** 2 files, ~100 lines

## Objective
Wire all Phase 4 systems together and verify they work in Unity. Update SceneSetup to include character selection, configure per-floor enemy pools with the 6 enemy types and 3 bosses, and test the full run flow: select character → fight through 3 floors → encounter all enemy types → defeat bosses → collect loot.

## Deliverables
- Updated DungeonTest scene setup with character selection flow
- Per-floor enemy pool configuration:
  - Floor 1: Stray Mutt, Barker. Boss: Big Brutus
  - Floor 2: Stray Mutt, Barker, Armored Hound, Pack Runner. Boss: The Catcher
  - Floor 3: Armored Hound, Pack Runner, Shadow Dog, Howler. Boss: Feral King
- LootTable assets per floor
- Full integration test checklist
- Fix any bugs discovered during testing

## Files Likely Touched
- `Editor/SceneSetup.cs` — update CreateDungeonTestScene with character select, enemy pools, loot tables
- `Scripts/Dungeon/DungeonGenerator.cs` — use per-floor enemy pools from FloorConfig
- `Scripts/Dungeon/FloorConfig.cs` — add enemyPool and bossData fields

## Dependencies
- Depends On: T026 (character select), T028 (bosses), T029 (loot)
- Blocks: None (final task of phase)

## Acceptance Criteria
- [ ] Character select screen appears before dungeon run
- [ ] Malinois and Vizsla have visibly different stats and abilities
- [ ] Floor 1 spawns Stray Mutts and Barkers
- [ ] Floor 2 adds Armored Hounds and Pack Runners
- [ ] Floor 3 adds Shadow Dogs and Howlers
- [ ] Each floor's boss appears in the boss room with correct behavior
- [ ] Loot drops from enemies and can be picked up
- [ ] Weapon pickups change the player's weapon
- [ ] Resource pickups increment run counters
- [ ] Full 3-floor run completable without crashes

## Notes
- This is the iterative testing and bug-fixing task, similar to T022 for Phase 3
- Expect 3-5 bugs based on Phase 3 experience (Mistake-005: non-serialized fields, Pattern-001: event timing)
- Floor 3 enemies appearing rarely on Floor 2: add 10% chance to spawn Shadow Dog or Howler on Floor 2
