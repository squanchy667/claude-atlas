# Agreement — T010: Attack System
## Status: APPROVED
## Approved: 2026-03-12 (auto-approved by atlas-run --full-permission)

## Scope
- Create WeaponController MonoBehaviour in `Assets/Scripts/Combat/WeaponController.cs`
- Implement data-driven attack using WeaponData SO (damage, range, cooldown, attackSpeed, knockback)
- Implement melee hit detection via Physics2D.OverlapCircleAll
- Integrate with PlayerInput Attack action (LMB / Gamepad West)
- Integrate with PlayerController state machine (Attacking state)
- Apply TakeDamage to hit targets via their HealthSystem component
- Implement cooldown timer based on weaponData.cooldown

## Not In Scope
- Ranged/projectile attacks (Bark, Howl projectile logic deferred to Phase 4)
- Attack animations (visual feedback is Phase 7 polish; state machine integration is structural only)
- Combo systems or attack chains
- Weapon switching UI
- Sound effects on attack

## Checkpoint Parameters
- `Assets/Scripts/Combat/WeaponController.cs` exists and compiles without errors
- WeaponController has serialized fields: weaponData (WeaponData), attackPoint (Transform), attackLayerMask (LayerMask)
- Attack triggers from PlayerInput Attack action
- Hit detection uses Physics2D.OverlapCircleAll with weaponData.range
- Targets with HealthSystem receive TakeDamage(weaponData.damage, transform.position)
- Cooldown timer prevents attacks faster than weaponData.cooldown
- PlayerController enters Attacking state during attack

## Skills Used
- ScriptableObject data pattern
- Unity Input System callback pattern
- Physics2D overlap detection

## Risks
- PlayerController state machine from Phase 1 may need extension to support Attacking state; if state machine pattern differs, adaptation required
- attackPoint Transform must be set up on the player prefab; task assumes it exists or creates it
