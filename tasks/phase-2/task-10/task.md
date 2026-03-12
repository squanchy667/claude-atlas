# T010: Attack System
## Phase: 2 — Combat Core
## Status: PENDING
## Depends On: T008, T009
## Blocks: T011, T014

## Description
Implement the weapon controller that lets the player attack enemies. The WeaponController reads its stats from a WeaponData ScriptableObject and uses Physics2D for hit detection, making combat data-driven and tunable without code changes.

### WeaponController MonoBehaviour
| Member | Type | Purpose |
|--------|------|---------|
| weaponData | WeaponData (serialized) | Current weapon stats SO |
| attackPoint | Transform (serialized) | Point from which attacks originate |
| attackLayerMask | LayerMask (serialized) | Layers that can be hit (enemies) |

### Attack Flow
1. Player presses Attack input (LMB / Gamepad West button) — read via PlayerInput component
2. WeaponController checks cooldown timer (based on `weaponData.cooldown`)
3. If off cooldown, enter Attacking state on PlayerController state machine
4. Perform melee hit detection: `Physics2D.OverlapCircleAll(attackPoint.position, weaponData.range, attackLayerMask)`
5. For each hit collider, get HealthSystem component and call `TakeDamage(weaponData.damage, transform.position)`
6. Start cooldown timer
7. Return to previous state after attack duration

### Input Integration
- Uses Unity's PlayerInput component (already on player from Phase 1)
- Listens for the "Attack" action from the Player action map
- Uses `OnAttack(InputAction.CallbackContext context)` callback pattern or `PlayerInput.onActionTriggered`

### State Machine Integration
- Adds an `Attacking` state to the PlayerController state machine (or integrates with existing states)
- Player cannot move during attack (brief lock) or moves at reduced speed
- Attack state duration is based on `1f / weaponData.attackSpeed`

### Cooldown
- Tracks time since last attack
- Prevents attack spam faster than `weaponData.cooldown` allows
- Cooldown timer runs independently of attack animation

## Deliverables
- `Assets/Scripts/Combat/WeaponController.cs` — WeaponController MonoBehaviour

## Acceptance Criteria
- WeaponController reads all combat stats from WeaponData ScriptableObject (no hardcoded values)
- Attack is triggered by the Attack input action (LMB / Gamepad West)
- Hit detection uses Physics2D.OverlapCircleAll with weaponData.range and attackLayerMask
- Detected targets with HealthSystem receive TakeDamage with correct damage and knockback source
- Cooldown prevents attacking faster than weaponData.cooldown allows
- Player enters Attacking state during attack
- WeaponData can be swapped at runtime by changing the weaponData reference
- File compiles without errors
