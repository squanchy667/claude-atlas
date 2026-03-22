# [T048] Audio System (SFX + Music)

**Phase:** 7
**Status:** PENDING
**Complexity:** High
**Estimated Scope:** 2 files, ~350 lines

## Objective
Create an AudioManager singleton with SFX and music support. SFX uses a SoundBank ScriptableObject that maps named clips to AudioClip references with volume and pitch variance. Music supports per-scene themes (kennel calm loop, dungeon action loop, boss intense loop). Uses AudioSource pooling with 5 SFX sources. Since the project has no audio files, generate placeholder audio clips at runtime using sine wave and noise bursts.

## Deliverables
- AudioManager singleton with SFX and music subsystems
- SoundBank ScriptableObject: named clips with volume/pitch variance settings
- SFX playback for: attack, hit, dodge, pickup, enemy death, boss phase, door open, ability
- Music playback: kennel theme (calm loop), dungeon theme (action loop), boss theme (intense loop)
- AudioSource pooling (5 SFX sources)
- Placeholder audio clip generation at runtime (sine/noise bursts)

## Files Likely Touched
- `Scripts/Audio/AudioManager.cs` — new singleton for audio playback
- `Scripts/Audio/SoundBank.cs` — new ScriptableObject for clip definitions

## Dependencies
- Depends On: None
- Blocks: T053

## Acceptance Criteria
- [ ] AudioManager singleton exists and initializes on scene load
- [ ] SoundBank ScriptableObject defines named clips with volume/pitch variance
- [ ] SFX plays for: attack, hit, dodge, pickup, enemy death, boss phase, door open, ability
- [ ] Music loops per scene: kennel (calm), dungeon (action), boss (intense)
- [ ] AudioSource pool of 5 SFX sources cycles correctly
- [ ] Placeholder clips are generated at runtime (sine waves, noise bursts)
- [ ] Volume and pitch variance applied per-clip on playback
- [ ] Music crossfades or switches when changing scenes/contexts
- [ ] No audio errors or warnings in console

## Notes
- AudioManager follows the Singleton pattern consistent with GameManager, etc.
- SoundBank uses [CreateAssetMenu] attribute for easy creation
- Placeholder clips use AudioClip.Create() with procedural sample data
- Music source is separate from SFX pool sources
