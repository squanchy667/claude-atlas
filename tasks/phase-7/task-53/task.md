# [T053] Phase 7 Integration Test

**Phase:** 7
**Status:** PENDING
**Complexity:** Medium
**Estimated Scope:** 0 new files, integration testing and bug fixes

## Objective
Perform a full integration test of all Phase 7 systems together. Test the complete flow: Main Menu -> Kennel -> Dungeon -> Pause -> Resume -> Complete Run -> Results -> Kennel. Verify that audio plays for all actions, particles spawn on hits/dodge/death, difficulty scales per floor, screen fades work between scenes, and game feel effects fire correctly. Fix any bugs discovered during integration.

## Deliverables
- Full flow test: Main Menu -> Kennel -> Dungeon -> Pause -> Resume -> Complete -> Kennel
- Verify audio plays for all major actions
- Verify particles spawn on hits, dodge, death, loot
- Verify difficulty scaling applies per floor
- Verify screen fades work for all scene transitions
- Verify game feel effects (screen shake, hitstop, afterimages, camera punch)
- Bug fixes for any issues found

## Files Likely Touched
- Any files from T046-T052 that need bug fixes
- No new files expected

## Dependencies
- Depends On: T046, T047, T048, T049, T050, T051, T052
- Blocks: None

## Acceptance Criteria
- [ ] Full flow works: Main Menu -> Kennel -> Dungeon -> Pause -> Resume -> Complete -> Kennel
- [ ] Main menu buttons all function correctly
- [ ] Pause menu toggles correctly during dungeon runs
- [ ] Audio SFX plays for: attack, hit, dodge, pickup, enemy death
- [ ] Music plays appropriate theme per scene (kennel, dungeon, boss)
- [ ] Particles spawn on: hit, dodge, enemy death, loot drop
- [ ] Difficulty visibly scales across floors 1-3
- [ ] Screen fades work for all scene transitions
- [ ] Game feel effects fire: screen shake, hitstop, afterimages, camera punch
- [ ] No crashes or soft-locks in full play-through
- [ ] No console errors during full flow
- [ ] Co-op mode works through the full flow

## Notes
- This is primarily a testing and bug-fixing task, not new feature development
- Document any bugs found and fixed in the outcome
- If critical bugs cannot be resolved, document them as known issues
- Test both solo and co-op paths through the full flow
