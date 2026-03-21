# [T038] Phase 5 Integration Test

**Phase:** 5
**Status:** PENDING
**Complexity:** Medium
**Estimated Scope:** 2+ files, varies (bug fixes)

## Objective
Full integration test of the entire Kennel meta-progression loop. Verify the complete game flow works end-to-end: start in Kennel, begin a run, play through the dungeon, return to Kennel, manage dogs and resources, build/upgrade, start another run, and confirm permanent upgrades apply correctly.

## Deliverables
- Full loop test execution and bug documentation
- Editor/SceneSetup.cs updates if needed for test scene configuration
- Bug fixes across any Phase 5 files as discovered during testing
- Verification that all Phase 5 systems integrate correctly

## Test Plan
1. Start in Kennel scene, walk around, verify 3 building spots visible
2. Open dog roster UI (Tab/E), verify empty roster displays correctly
3. Start a run via "Start Run" button, verify character select loads
4. Play through dungeon, rescue a dog in a treasure room
5. Complete the run (or die), verify results screen shows correct stats
6. Return to Kennel, verify resources were banked (100% or 70%)
7. Open dog roster, verify rescued dog appears with correct name/breed
8. Assign a role to the dog, verify role persists
9. Walk to a building spot, interact, verify BuildingUI shows correctly
10. Purchase a building/upgrade, verify resources deducted
11. Start another run, verify permanent upgrades apply to player stats
12. Quit and restart, verify save/load preserves all progress

## Files Likely Touched
- `Editor/SceneSetup.cs` — updates for test configuration
- Various Phase 5 files — bug fixes as discovered

## Dependencies
- Depends On: T035, T036, T037
- Blocks: None

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

## Notes
- This is the final validation task for Phase 5
- Focus on integration between systems, not individual system correctness
- Document any bugs found with reproduction steps before fixing
- If critical bugs cannot be fixed, document them as blockers for Phase 6
