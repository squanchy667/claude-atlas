# Agreement — T048: Audio System (SFX + Music)

**Status:** APPROVED
**Approved:** 2026-03-22

## Scope
Create AudioManager singleton with SFX and music support. SoundBank ScriptableObject maps named clips with volume/pitch variance. SFX for all major actions (attack, hit, dodge, pickup, enemy death, boss phase, door open, ability). Music loops per scene (kennel calm, dungeon action, boss intense). AudioSource pooling with 5 SFX sources. Generate placeholder audio clips at runtime since no audio files exist.

## Checkpoint Parameters
- AudioManager singleton with SFX pool (5 sources) and music source
- SoundBank ScriptableObject with named clips, volume/pitch variance
- SFX triggers for 8 action types
- Music loops for 3 scene contexts (kennel, dungeon, boss)
- Runtime placeholder clip generation (sine/noise bursts)
- No audio errors in console

## Out of Scope
- Real audio asset creation or import
- Audio settings UI (options menu)
- Spatial/3D audio positioning
- Dynamic music layering

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
