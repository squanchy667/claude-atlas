# T009: Health System
## Phase: 2 — Combat Core
## Status: PENDING
## Depends On: none
## Blocks: T010, T011, T012, T013

## Description
Implement a shared health system component that works for both player characters and enemies. This is the universal damage receiver in the game — anything that can take damage or die has a HealthSystem component.

### HealthSystem MonoBehaviour
| Member | Type | Purpose |
|--------|------|---------|
| maxHealth | float (serialized) | Maximum HP, set per entity |
| currentHealth | float (read-only property) | Current HP, starts at maxHealth |
| IsAlive | bool (read-only property) | True if currentHealth > 0 |

### Public Methods
| Method | Signature | Behavior |
|--------|-----------|----------|
| TakeDamage | `void TakeDamage(float amount, Vector2? knockbackSource = null)` | Reduces currentHealth by amount. Clamps to 0. Fires OnHealthChanged. If health reaches 0, calls Die(). Checks PlayerController.IsInvincible before applying (if on player). Fires GameEvents.DamageTaken. |
| Heal | `void Heal(float amount)` | Increases currentHealth by amount. Clamps to maxHealth. Fires OnHealthChanged. |
| Die | `void Die()` | Called when health reaches 0. Fires OnDeath event. Does NOT destroy the GameObject (leave that to the owning system). |

### C# Events
| Event | Signature | When |
|-------|-----------|------|
| OnHealthChanged | `event Action<float, float>` | (currentHealth, maxHealth) — fires on any health change |
| OnDeath | `event Action` | Fires once when health reaches 0 |

### Integration Points
- Respects `PlayerController.IsInvincible` property when the HealthSystem is on a player GameObject (check via GetComponent)
- Fires `GameEvents.DamageTaken` static event when damage is applied (for global listeners like UI, analytics)
- knockbackSource parameter is passed through for downstream knockback systems (T011)

### Initialization
- `currentHealth` initializes to `maxHealth` in `Awake()`

## Deliverables
- `Assets/Scripts/Combat/HealthSystem.cs` — HealthSystem MonoBehaviour

## Acceptance Criteria
- HealthSystem is a MonoBehaviour with serialized maxHealth field
- currentHealth initializes to maxHealth on Awake
- TakeDamage reduces health, clamps to 0, fires OnHealthChanged
- TakeDamage checks PlayerController.IsInvincible when present on the same GameObject
- TakeDamage fires GameEvents.DamageTaken
- TakeDamage calls Die() when health reaches 0
- Heal increases health, clamps to maxHealth, fires OnHealthChanged
- Die fires OnDeath event exactly once
- OnHealthChanged provides (current, max) values
- knockbackSource parameter is available on TakeDamage for downstream use
- Component works on any GameObject (player or enemy) without modification
- File compiles without errors
