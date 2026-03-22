# Agreement — T053: Phase 7 Integration Test

**Status:** APPROVED
**Approved:** 2026-03-22

## Scope
Full integration test of all Phase 7 systems. Test complete flow: Main Menu -> Kennel -> Dungeon -> Pause -> Resume -> Complete -> Kennel. Verify audio, particles, difficulty scaling, screen fades, and game feel all work together. Fix bugs discovered during testing. Test both solo and co-op paths.

## Checkpoint Parameters
- Full game flow completes without crashes or soft-locks
- Audio (SFX + music) plays correctly throughout
- Particles spawn on all trigger events
- Difficulty scales across floors 1-3
- Screen fades work for all transitions
- Game feel effects fire on appropriate triggers
- No console errors during full flow
- Both solo and co-op tested

## Out of Scope
- New feature development
- Performance optimization beyond fixing obvious issues
- Art or audio asset replacement (placeholders are acceptable)

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
