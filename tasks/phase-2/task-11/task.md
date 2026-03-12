# T011: Hit Feedback System
## Phase: 2 — Combat Core
## Status: PENDING
## Depends On: T009, T010
## Blocks: T014

## Description
Implement the game-feel layer for combat: visual flash on hit, physics knockback, and hitstop (brief time freeze). These systems make attacks feel impactful and are critical for roguelite combat feel. All parameters are serialized for designer tuning.

### DamageFlash MonoBehaviour
| Member | Type | Purpose |
|--------|------|---------|
| spriteRenderer | SpriteRenderer (serialized) | Target sprite to flash |
| flashMaterial | Material (serialized) | White flash material |
| flashDuration | float (serialized, default 0.1f) | How long the flash lasts |

**Behavior:**
- Listens to HealthSystem.OnHealthChanged on the same GameObject
- On damage, swaps SpriteRenderer.material to flashMaterial for flashDuration seconds
- Restores original material after flash
- Uses coroutine for timing

### Knockback MonoBehaviour
| Member | Type | Purpose |
|--------|------|---------|
| rb | Rigidbody2D (cached) | Physics body to push |
| knockbackForce | float (serialized, default 5f) | Base knockback strength |
| knockbackDuration | float (serialized, default 0.15f) | How long knockback lasts |

**Behavior:**
- Receives knockback direction from HealthSystem.TakeDamage knockbackSource parameter
- Applies force to Rigidbody2D away from damage source
- Knockback force is modulated by WeaponData.knockback and knockbackFalloff curve (if available)
- Disables movement input during knockback duration
- Uses coroutine for duration timing

### HitstopManager MonoBehaviour (Singleton)
| Member | Type | Purpose |
|--------|------|---------|
| hitstopDuration | float (serialized, default 0.05f) | Duration of time freeze |
| hitstopTimeScale | float (serialized, default 0f) | Time.timeScale during hitstop |

**Behavior:**
- Singleton pattern (one instance in scene)
- Called when damage is dealt (listens to GameEvents.DamageTaken or called directly)
- Sets `Time.timeScale = hitstopTimeScale` for hitstopDuration
- Uses coroutine with `WaitForSecondsRealtime` (unscaled time) to restore timeScale
- Prevents overlapping hitstops (ignores new requests while one is active)

### Screen Shake Integration
- On hit, fires `GameEvents.RequestScreenShake` (event already exists from Phase 1 camera system)
- Screen shake magnitude can be proportional to damage dealt

## Deliverables
- `Assets/Scripts/Combat/DamageFlash.cs` — DamageFlash MonoBehaviour
- `Assets/Scripts/Combat/Knockback.cs` — Knockback MonoBehaviour
- `Assets/Scripts/Combat/HitstopManager.cs` — HitstopManager singleton MonoBehaviour

## Acceptance Criteria
- DamageFlash swaps sprite material to white on damage, restores after flashDuration
- DamageFlash listens to HealthSystem events on the same GameObject
- Knockback pushes Rigidbody2D away from damage source position
- Knockback duration and force are serialized and tunable
- HitstopManager briefly sets Time.timeScale to 0 (or configured value) on hit
- HitstopManager uses WaitForSecondsRealtime (not WaitForSeconds) for restoration
- HitstopManager prevents overlapping hitstop coroutines
- GameEvents.RequestScreenShake is fired on hit
- All parameters are serialized (no hardcoded magic numbers)
- All 3 files compile without errors
