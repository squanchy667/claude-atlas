# Agreement — T012: Enemy AI
## Status: APPROVED
## Approved: 2026-03-12 (auto-approved by atlas-run --full-permission)

## Scope
- Create EnemyController MonoBehaviour in `Assets/Scripts/Enemies/EnemyController.cs`
- Implement 4-state AI: Idle (detect player), Chasing (move toward player), Attacking (deal damage), Dead (cleanup and destroy)
- Read all stats from EnemyData ScriptableObject (detectionRange, attackRange, moveSpeed, damage)
- Use Rigidbody2D.MovePosition for physics-based movement
- Use distance-based player detection (no line-of-sight)
- Subscribe to HealthSystem.OnDeath for death transition
- Fire GameEvents.EnemyDefeated on death
- Use `[RequireComponent(typeof(HealthSystem))]`

## Not In Scope
- Pathfinding or obstacle avoidance (straight-line movement for Phase 2)
- Line-of-sight detection
- Multiple attack patterns (Chase pattern only; Ranged, Patrol, Swarm, Boss behaviors are Phase 4)
- Death animations or visual effects
- Loot drops on death
- Enemy spawning system (spawning is handled by scene setup or dungeon generation)

## Checkpoint Parameters
- `Assets/Scripts/Enemies/EnemyController.cs` exists and compiles without errors
- 4 states implemented: Idle, Chasing, Attacking, Dead
- All stats read from EnemyData SO (enemyData.detectionRange, attackRange, moveSpeed, damage)
- Idle detects player and transitions to Chasing
- Chasing moves toward player via Rigidbody2D and transitions to Attacking at attackRange
- Attacking deals damage to player HealthSystem with cooldown
- Dead fires GameEvents.EnemyDefeated and destroys after delay
- `[RequireComponent(typeof(HealthSystem))]` present

## Skills Used
- State machine pattern
- ScriptableObject data pattern
- Singleton-Events pattern (GameEvents)

## Risks
- Player reference acquisition strategy (tag lookup vs. singleton) must align with Phase 1 conventions
- GameEvents.EnemyDefeated must be defined in the event bus; will need to add if not present
- Rigidbody2D movement may conflict with NavMesh or other movement systems added later
