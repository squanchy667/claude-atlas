# Agreement — T041: Shared Camera & Leash

**Status:** APPROVED
**Approved:** 2026-03-20

## Scope
Verify CameraController multi-target tracking with 2 players. Add max separation leash (12 units) with rubber-band velocity. Tune dynamic zoom for co-op (ortho size 7-14). Ensure leash is inactive during solo play.

## Checkpoint Parameters
- CameraController tracks 2 players and centers between them
- Dynamic zoom: ortho size range 7 (close) to 14 (far)
- Max separation leash at 12 units with rubber-band pull
- Leash inactive during solo play
- Camera reverts to single-target if P2 leaves

## Out of Scope
- CoopManager/join flow (T039)
- Co-op UI layout (T042)
- Camera shake or other effects (Phase 7)

## Acceptance Criteria
- [ ] CameraController correctly tracks 2 players (centers between them)
- [ ] Camera dynamically zooms out as players separate (ortho size 7-14 range)
- [ ] Camera dynamically zooms in as players come together
- [ ] Max separation leash activates at 12 units distance
- [ ] Rubber-band velocity pulls separated players toward each other
- [ ] Leash is inactive during solo play
- [ ] Camera reverts to single-target behavior if P2 leaves
