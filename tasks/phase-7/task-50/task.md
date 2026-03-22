# [T050] Particle Effects

**Phase:** 7
**Status:** PENDING
**Complexity:** Medium
**Estimated Scope:** 1 file, ~200 lines

## Objective
Create a ParticleManager static utility that spawns simple runtime-generated particle effects. No prefabs needed — all ParticleSystems are created programmatically at runtime. Effects include: hit sparks (burst of 5-8 small white particles on enemy damage), dodge dust (small puff at feet when dodge starts), ability VFX (ring burst for Ground Slam, trail for Dash Strike), death poof (burst of colored particles when enemy dies), and loot sparkle (small repeating sparkle on loot drops).

## Deliverables
- ParticleManager static utility class
- `SpawnEffect(type, position, color)` public API
- Hit sparks: burst of 5-8 small white particles on enemy damage
- Dodge dust: small puff at feet when dodge starts
- Ability VFX: ring burst for Ground Slam, trail for Dash Strike
- Death poof: burst of colored particles when enemy dies
- Loot sparkle: small repeating sparkle on loot drops
- All ParticleSystems created at runtime (no prefabs)

## Files Likely Touched
- `Scripts/Effects/ParticleManager.cs` — new static utility class

## Dependencies
- Depends On: None
- Blocks: T052, T053

## Acceptance Criteria
- [ ] ParticleManager exists as a static utility class
- [ ] SpawnEffect(type, position, color) spawns the correct effect
- [ ] Hit sparks: burst of 5-8 small white particles on enemy damage
- [ ] Dodge dust: small puff at feet when dodge roll starts
- [ ] Ability VFX: ring burst for Ground Slam
- [ ] Ability VFX: trail for Dash Strike
- [ ] Death poof: burst of colored particles when enemy dies
- [ ] Loot sparkle: small repeating sparkle on loot drops
- [ ] All effects are runtime-generated (no prefab dependencies)
- [ ] Effects auto-destroy after their duration completes

## Notes
- Uses Unity's ParticleSystem API to configure modules at runtime
- Each effect type has hardcoded defaults for size, lifetime, speed, and emission
- Color parameter overrides the default color for flexibility
- Effects are one-shot except loot sparkle which loops until destroyed
