# Outcome — T050: Particle Effects

**Status:** DONE
**Date:** 2026-03-22

## What Was Built
ParticleManager static utility class that spawns runtime-generated particle effects with no prefab dependencies. All ParticleSystems created programmatically using Unity's ParticleSystem API. Five effect types implemented: hit sparks (burst of 5-8 small white particles on enemy damage), dodge dust (small puff at feet when dodge starts), ability burst (ring burst for Ground Slam, trail for Dash Strike), death poof (burst of colored particles when enemy dies), and loot sparkle (small repeating sparkle on loot drops). ParticleEventListener MonoBehaviour hooks into GameEvents to automatically trigger particle effects on damage dealt, dodge performed, enemy death, and loot drops. Effects auto-destroy after their duration completes (except loot sparkle which loops).

## Deliverables
- [x] ParticleManager exists as a static utility class
- [x] SpawnEffect(type, position, color) spawns the correct effect
- [x] Hit sparks: burst of 5-8 small white particles on enemy damage
- [x] Dodge dust: small puff at feet when dodge roll starts
- [x] Ability VFX: ring burst for Ground Slam
- [x] Ability VFX: trail for Dash Strike
- [x] Death poof: burst of colored particles when enemy dies
- [x] Loot sparkle: small repeating sparkle on loot drops
- [x] All effects are runtime-generated (no prefab dependencies)
- [x] Effects auto-destroy after their duration completes

## Files Changed
| File | Change |
|------|--------|
| Scripts/Effects/ParticleManager.cs | New — static utility class with SpawnEffect API and runtime ParticleSystem creation |
| Scripts/Effects/ParticleEventListener.cs | New — MonoBehaviour that subscribes to GameEvents and triggers particle effects |

## Drift Events
None.
