# Agreement — T011: Hit Feedback System
## Status: APPROVED
## Approved: 2026-03-12 (auto-approved by atlas-run --full-permission)

## Scope
- Create DamageFlash MonoBehaviour in `Assets/Scripts/Combat/DamageFlash.cs` — sprite flash white on hit via material swap, configurable duration
- Create Knockback MonoBehaviour in `Assets/Scripts/Combat/Knockback.cs` — push Rigidbody2D away from damage source, configurable force and duration
- Create HitstopManager singleton in `Assets/Scripts/Combat/HitstopManager.cs` — brief Time.timeScale = 0 on hit, uses WaitForSecondsRealtime, prevents overlapping hitstops
- Fire GameEvents.RequestScreenShake on hit for camera shake integration

## Not In Scope
- Creating the white flash material asset (will be created at integration time or use a runtime-generated material)
- Particle effects on hit (Phase 7 polish)
- Sound effects on hit (Phase 7 polish)
- Damage numbers / floating text
- Different feedback per weapon type (uniform feedback for now)

## Checkpoint Parameters
- All 3 files exist at specified paths and compile without errors
- DamageFlash: swaps material on damage, restores after duration, uses coroutine
- Knockback: applies Rigidbody2D force away from source, respects duration, force is serialized
- HitstopManager: sets Time.timeScale on hit, uses WaitForSecondsRealtime, prevents overlap
- GameEvents.RequestScreenShake is called on damage
- All tuning parameters (flashDuration, knockbackForce, knockbackDuration, hitstopDuration) are serialized

## Skills Used
- Combat feel tuning
- Singleton-Events pattern
- Unity coroutine timing

## Risks
- Time.timeScale = 0 affects all systems including physics and animation; must use unscaledDeltaTime in the restore coroutine
- Knockback integration depends on how PlayerController handles movement override; may need a flag or state
- GameEvents.RequestScreenShake must exist; if not defined yet, must be added to GameEvents
