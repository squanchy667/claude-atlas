# [T052] Game Feel Pass

**Phase:** 7
**Status:** PENDING
**Complexity:** Medium
**Estimated Scope:** 2 files, ~250 lines

## Objective
Tune all juice parameters for satisfying combat feel. Differentiate screen shake intensity: light hit (0.05 intensity, 0.05s), heavy hit (0.15 intensity, 0.12s), ability (0.25 intensity, 0.2s). Add hitstop — brief freeze frame (0.03s) on hit confirmation by setting Time.timeScale to 0 briefly. Add attack trail afterimage sprites during attack animations and dodge trail afterimages during dodge rolls. Add camera punch — quick directional camera offset on big hits. Hook into existing damage and dodge events.

## Deliverables
- Screen shake tuning: light hit (0.05, 0.05s), heavy hit (0.15, 0.12s), ability (0.25, 0.2s)
- Hitstop: 0.03s freeze frame on hit confirmation (Time.timeScale = 0 briefly)
- Attack trail: brief afterimage sprites during attack animation
- Dodge trail: brief afterimage sprites during dodge roll
- Camera punch: quick directional camera offset on big hits
- AfterimageEffect component for spawning trail sprites
- Hook into existing GameEvents for damage and dodge

## Files Likely Touched
- `Scripts/Effects/AfterimageEffect.cs` — new component for afterimage trails
- `Scripts/Camera/CameraController.cs` — modify for screen shake tuning and camera punch

## Dependencies
- Depends On: T050
- Blocks: T053

## Acceptance Criteria
- [ ] Screen shake differentiates light hit (0.05, 0.05s), heavy hit (0.15, 0.12s), ability (0.25, 0.2s)
- [ ] Hitstop freezes for 0.03s on hit confirmation
- [ ] Attack trail shows afterimage sprites during attack animation
- [ ] Dodge trail shows afterimage sprites during dodge roll
- [ ] Camera punch applies directional offset on big hits
- [ ] AfterimageEffect component exists and spawns semi-transparent sprite copies
- [ ] All effects hook into existing GameEvents (damage dealt, dodge performed)
- [ ] Effects are visually noticeable but not distracting
- [ ] No performance issues from afterimage sprites (they clean up promptly)

## Notes
- AfterimageEffect creates copies of the player's SpriteRenderer at intervals, fading alpha over time
- Hitstop uses a coroutine: set timeScale to 0, wait realtime, restore timeScale
- Camera punch is separate from screen shake — it's a directional offset that returns to center
- Screen shake parameters should be configurable (could use a ShakeConfig ScriptableObject)
- T050 particle effects are used alongside these juice effects for combined impact
