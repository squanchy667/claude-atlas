# Agreement — T009: Health System
## Status: APPROVED
## Approved: 2026-03-12 (auto-approved by atlas-run --full-permission)

## Scope
- Create HealthSystem MonoBehaviour in `Assets/Scripts/Combat/HealthSystem.cs`
- Implement maxHealth (serialized), currentHealth (property), IsAlive (property)
- Implement TakeDamage(float amount, Vector2? knockbackSource = null) with invincibility check, clamping, event firing
- Implement Heal(float amount) with clamping and event firing
- Implement Die() with OnDeath event
- Wire OnHealthChanged(float current, float max) and OnDeath C# events
- Fire GameEvents.DamageTaken on damage application
- Check PlayerController.IsInvincible via GetComponent before applying damage

## Not In Scope
- Visual feedback on damage (that is T011: Hit Feedback System)
- Health bar UI (that is T013: Health Bar UI)
- Death animations or destroy logic (handled by owning systems)
- Health regeneration mechanics
- Damage types, armor, or resistance systems

## Checkpoint Parameters
- `Assets/Scripts/Combat/HealthSystem.cs` exists and compiles without errors
- maxHealth is serialized; currentHealth initializes to maxHealth in Awake
- TakeDamage reduces health, clamps to 0, fires OnHealthChanged, fires GameEvents.DamageTaken
- TakeDamage respects PlayerController.IsInvincible when component is present
- TakeDamage calls Die() at 0 health
- Heal increases health, clamps to maxHealth, fires OnHealthChanged
- Die fires OnDeath event
- Component is generic (no player-specific or enemy-specific assumptions beyond the invincibility check)

## Skills Used
- Singleton-Events pattern (GameEvents integration)
- Unity component architecture

## Risks
- PlayerController.IsInvincible property must exist from Phase 1 (T004); if not present, will need a null-safe check
- GameEvents.DamageTaken must be defined; if the event bus doesn't have this event yet, it must be added
