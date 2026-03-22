# Outcome — T048: Audio System (SFX + Music)

**Status:** DONE
**Date:** 2026-03-22

## What Was Built
AudioManager singleton with SFX and music subsystems. SFX uses a SoundBank ScriptableObject that maps named clips to AudioClip references with volume and pitch variance settings. AudioSource pooling with 5 SFX sources cycles correctly. Music supports per-scene themes: kennel calm loop, dungeon action loop, boss intense loop via a separate music AudioSource. All audio clips are placeholder — generated at runtime using AudioClip.Create() with procedural sine wave and noise burst sample data. AudioManager subscribes to GameEvents for automatic SFX playback on attack, hit, dodge, pickup, enemy death, boss phase, door open, and ability use.

## Deliverables
- [x] AudioManager singleton exists and initializes on scene load
- [x] SoundBank ScriptableObject defines named clips with volume/pitch variance
- [x] SFX plays for: attack, hit, dodge, pickup, enemy death, boss phase, door open, ability
- [x] Music loops per scene: kennel (calm), dungeon (action), boss (intense)
- [x] AudioSource pool of 5 SFX sources cycles correctly
- [x] Placeholder clips are generated at runtime (sine waves, noise bursts)
- [x] Volume and pitch variance applied per-clip on playback
- [x] Music crossfades or switches when changing scenes/contexts
- [x] No audio errors or warnings in console

## Files Changed
| File | Change |
|------|--------|
| Scripts/Audio/AudioManager.cs | New — singleton for SFX pool, music playback, event subscriptions, runtime clip generation |
| Scripts/Audio/SoundBank.cs | New — ScriptableObject with [CreateAssetMenu] for named clip definitions with volume/pitch variance |

## Drift Events
None.
