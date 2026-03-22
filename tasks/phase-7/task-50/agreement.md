# Agreement — T050: Particle Effects

**Status:** APPROVED
**Approved:** 2026-03-22

## Scope
Create ParticleManager static utility that spawns runtime-generated particle effects via `SpawnEffect(type, position, color)`. Five effect types: hit sparks (5-8 white particles), dodge dust (puff at feet), ability VFX (ring burst for Ground Slam, trail for Dash Strike), death poof (colored burst), loot sparkle (repeating loop). All ParticleSystems created programmatically — no prefabs.

## Checkpoint Parameters
- ParticleManager static class with SpawnEffect API
- 5 distinct effect types all runtime-generated
- Effects auto-destroy after completion (except loot sparkle which loops)
- No prefab dependencies
- Color parameter for flexible tinting

## Out of Scope
- Prefab-based particle systems
- GPU particles or complex shaders
- Particle pooling/recycling optimization
- Audio tied to particle effects (T048 handles audio)

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
