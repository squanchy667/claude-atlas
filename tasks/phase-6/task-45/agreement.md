# Agreement — T045: Phase 6 Integration Test

**Status:** APPROVED
**Approved:** 2026-03-20

## Scope
End-to-end integration testing of all Phase 6 co-op features. Test full co-op loop (join, select, play, revive, complete). Verify solo play regression. Test camera, leash, enemy scaling. Fix bugs found during testing. Document results.

## Checkpoint Parameters
- Full co-op loop works: P2 join, character select, dungeon run, revive, completion
- Solo play regression: no breakage from co-op code
- Camera zoom/leash verified with 2 players
- Enemy scaling verified (HP +30%, +1 enemy per room)
- All bugs found are fixed or documented as open issues
- No crashes or soft-locks

## Out of Scope
- New features beyond Phase 6 scope
- Polish, VFX, or audio (Phase 7)
- Online multiplayer testing

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
