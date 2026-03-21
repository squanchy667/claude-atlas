# [T041] Shared Camera & Leash

**Phase:** 6
**Status:** PENDING
**Complexity:** Medium
**Estimated Scope:** 1-2 files, ~150 lines

## Objective
CameraController already supports multi-target tracking — verify it works correctly with 2 players. Add a max separation leash: if players are more than 12 units apart, apply a rubber-band velocity pulling them toward each other. Tune the existing dynamic zoom for co-op play with min/max orthographic size of 7-14.

## Deliverables
- Verify CameraController multi-target tracking works with 2 players
- Max separation leash (12 units) with rubber-band velocity
- Dynamic zoom tuning for co-op: min ortho size 7, max ortho size 14
- Leash only active during co-op (solo play unaffected)

## Files Likely Touched
- `Scripts/Core/CameraController.cs` — modify for leash logic and zoom tuning
- `Scripts/Player/PlayerController.cs` — add rubber-band velocity when leash triggers

## Dependencies
- Depends On: T039
- Blocks: T045

## Acceptance Criteria
- [ ] CameraController correctly tracks 2 players (centers between them)
- [ ] Camera dynamically zooms out as players separate (ortho size 7-14 range)
- [ ] Camera dynamically zooms in as players come together
- [ ] Max separation leash activates at 12 units distance
- [ ] Rubber-band velocity pulls separated players toward each other
- [ ] Leash is inactive during solo play
- [ ] Camera reverts to single-target behavior if P2 leaves

## Notes
- CameraController already has multi-target support from Phase 1 — this task is primarily verification and tuning
- Rubber-band should feel smooth, not jarring — use a gradual force, not a hard teleport
- Ortho size range may need further tuning during Phase 6 integration (T045)
