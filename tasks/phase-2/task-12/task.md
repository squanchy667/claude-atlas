# T012: Enemy AI
## Phase: 2 — Combat Core
## Status: PENDING
## Depends On: T008, T009
## Blocks: T014

## Description
Implement the base enemy AI controller that drives enemy behavior using a simple state machine. The EnemyController reads stats from an EnemyData ScriptableObject and uses the HealthSystem for damage/death. This is the foundational enemy behavior that all enemy types will build on.

### EnemyController MonoBehaviour
| Member | Type | Purpose |
|--------|------|---------|
| enemyData | EnemyData (serialized) | Stats and behavior configuration |
| EnemyState | enum (Idle, Chasing, Attacking, Dead) | Current AI state |

### State Machine

**Idle:**
- Default state on spawn
- Checks for player within `enemyData.detectionRange` each frame
- Uses Physics2D.OverlapCircle or distance check to player transform
- Transitions to Chasing when player is detected

**Chasing:**
- Moves toward player position at `enemyData.moveSpeed`
- Uses Rigidbody2D.MovePosition for physics-based movement
- Transitions to Attacking when within `enemyData.attackRange`
- Transitions back to Idle when player leaves `enemyData.detectionRange`

**Attacking:**
- Deals `enemyData.damage` to player's HealthSystem
- Has attack cooldown (derived from enemyData or hardcoded minimum)
- Transitions back to Chasing when player moves outside `enemyData.attackRange`
- Transitions to Idle when player leaves detectionRange

**Dead:**
- Entered when HealthSystem.OnDeath fires
- Fires `GameEvents.EnemyDefeated` with enemy reference
- Disables AI processing (movement, detection)
- Destroys GameObject after a configurable delay (e.g., 1 second for death animation)

### Player Detection
- Finds player via tag ("Player") or cached reference
- Distance-based detection using `enemyData.detectionRange`
- No line-of-sight check (simple distance only for Phase 2)

### Integration Points
- Requires HealthSystem component on the same GameObject (use `[RequireComponent]`)
- Requires Rigidbody2D for movement
- Requires Collider2D for physics interactions
- Fires GameEvents.EnemyDefeated on death

## Deliverables
- `Assets/Scripts/Enemies/EnemyController.cs` — EnemyController MonoBehaviour

## Acceptance Criteria
- EnemyController has 4 states: Idle, Chasing, Attacking, Dead
- Reads all stats from EnemyData ScriptableObject (no hardcoded stats)
- Idle state detects player within detectionRange and transitions to Chasing
- Chasing state moves toward player at enemyData.moveSpeed using Rigidbody2D
- Attacking state deals enemyData.damage to player's HealthSystem with cooldown
- Dead state fires GameEvents.EnemyDefeated and destroys after delay
- HealthSystem.OnDeath triggers transition to Dead state
- `[RequireComponent(typeof(HealthSystem))]` attribute is present
- File compiles without errors
