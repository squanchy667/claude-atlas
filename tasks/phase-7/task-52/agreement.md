# Agreement — T052: Game Feel Pass

**Status:** APPROVED
**Approved:** 2026-03-22

## Scope
Tune juice parameters for satisfying combat. Differentiate screen shake by intensity tier (light/heavy/ability). Add hitstop (0.03s freeze on hit). Add afterimage trails for attacks and dodges via new AfterimageEffect component. Add camera punch (directional offset on big hits). Modify CameraController for shake tuning and punch. Hook into existing damage/dodge GameEvents.

## Checkpoint Parameters
- Screen shake: 3 tiers (light 0.05/0.05s, heavy 0.15/0.12s, ability 0.25/0.2s)
- Hitstop: 0.03s Time.timeScale freeze on hit confirmation
- AfterimageEffect: semi-transparent sprite copies during attack/dodge
- Camera punch: directional offset on big hits
- All hooked into existing GameEvents
- Afterimages clean up promptly (no performance issues)

## Out of Scope
- Audio integration with game feel (T048)
- New particle effects (T050 — already complete as dependency)
- UI shake or screen flash
- Controller rumble/haptics

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
