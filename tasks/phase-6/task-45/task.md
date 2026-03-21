# [T045] Phase 6 Integration Test

**Phase:** 6
**Status:** PENDING
**Complexity:** Medium
**Estimated Scope:** 0 new files, testing and bug fixes across all Phase 6 files

## Objective
Test the full co-op loop end-to-end: P2 joins, both players select characters, play through a dungeon run together, test revive mechanic, and complete a run. Verify solo play still works without P2. Test camera zoom and leash behavior. Test enemy scaling. Fix any bugs found during integration testing.

## Deliverables
- Full co-op loop tested: join, character select, dungeon run, revive, run completion
- Solo play regression test: confirm no P2 required, all systems work solo
- Camera zoom/leash tested with 2 players
- Enemy scaling verified (HP and count)
- Bug fixes for any issues found

## Files Likely Touched
- Any file from T039-T044 that has bugs
- No new files expected (testing and fixes only)

## Dependencies
- Depends On: T040, T041, T042, T043, T044
- Blocks: None

## Acceptance Criteria
- [ ] P2 can join, both players select characters, and a dungeon run starts
- [ ] Both players can move, attack, dodge, and use abilities independently
- [ ] Camera correctly tracks both players with dynamic zoom
- [ ] Camera leash prevents players from separating beyond 12 units
- [ ] Enemy HP and count are scaled during co-op
- [ ] Revive mechanic works: downed player can be revived by partner
- [ ] Solo play works identically to pre-Phase 6 behavior
- [ ] P2 can leave mid-run and game continues for P1
- [ ] No crashes or soft-locks during co-op play
- [ ] All Phase 6 acceptance criteria from T039-T044 verified in Unity

## Notes
- This is an integration/testing task, not a feature task
- Expected to find and fix 3-8 bugs during integration
- Document any bugs found and fixed in outcome.md
- Document any open issues that need Phase 7 polish in outcome.md
