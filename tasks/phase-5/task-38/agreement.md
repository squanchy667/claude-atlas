# Agreement — T038: Phase 5 Integration Test

**Status:** APPROVED
**Approved:** 2026-03-20

## Scope
Full integration test of the Kennel meta-progression loop: Kennel navigation, dog roster management, building/upgrade purchase, scene transitions, run economy, save/load persistence. Fix all bugs discovered during testing.

## Checkpoint Parameters
- Full loop test: Kennel -> Start Run -> Dungeon -> Results -> Kennel -> Manage -> Run Again
- Dog rescue, roster display, and role assignment verified working
- Building purchase and permanent upgrades verified working
- Resource banking (100%/70%) and Forager income verified working
- Save/load persistence verified across sessions
- All discovered bugs fixed or documented as blockers

## Out of Scope
- Performance optimization (Phase 7)
- Multiplayer Kennel features (Phase 6)
- Visual polish, animations, audio (Phase 7)
- Balance tuning beyond basic verification

## Acceptance Criteria
- [ ] Full Kennel -> Run -> Results -> Kennel loop completes without errors
- [ ] Dog rescue during run transfers to roster in Kennel
- [ ] Role assignment persists and displays correctly
- [ ] Building purchase deducts resources and updates building state
- [ ] Permanent upgrades apply to player stats on next run start
- [ ] Resource banking works (100% on success, 70% on failure)
- [ ] Forager income added on Kennel return
- [ ] Save/load preserves all meta-progression state across sessions
- [ ] No console errors or exceptions during full loop
- [ ] All discovered bugs documented and fixed
