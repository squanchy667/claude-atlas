# [T024] Active Ability System

**Phase:** 4
**Status:** PENDING
**Complexity:** High
**Estimated Scope:** 4 files, ~250 lines

## Objective
Implement the active ability system: an AbilityController component on the player that reads AbilityData, executes the ability on input (Q key / left bumper), tracks cooldown, and displays a cooldown indicator UI. Implement 2 concrete abilities: Ground Slam (Malinois) and Dash Strike (Vizsla).

## Deliverables
- `AbilityController.cs` — component that manages ability execution and cooldown
- Ground Slam implementation: AoE damage in radius around player, knockback, screen shake
- Dash Strike implementation: quick forward dash dealing damage to enemies in path
- Cooldown UI indicator (simple fill bar near player health)
- Input binding for ability (Q key / gamepad left bumper)
- Integration with GameEvents (OnAbilityUsed event)

## Files Likely Touched
- `Scripts/Player/AbilityController.cs` — new, ability execution logic
- `Scripts/Core/GameEvents.cs` — add OnAbilityUsed event
- `Scripts/UI/AbilityCooldownUI.cs` — new, cooldown display
- `Settings/PlayerInputActions.inputactions` — add Ability action binding

## Dependencies
- Depends On: T023 (AbilityData SO must exist)
- Blocks: T026

## Acceptance Criteria
- [ ] Ground Slam: damages all enemies in 3-unit radius, applies knockback outward, screen shake
- [ ] Dash Strike: player dashes 4 units forward, damages enemies in path, brief i-frames
- [ ] Cooldown prevents re-use (Ground Slam: 8s, Dash Strike: 5s)
- [ ] Cooldown UI shows remaining time
- [ ] Ability input works (Q key and gamepad)
- [ ] Ability respects player state (can't use while dead or dodging)

## Notes
- Ground Slam uses Physics2D.OverlapCircleAll similar to weapon attack
- Dash Strike reuses DodgeRoll movement logic but with damage
- Cooldown UI: simple bar below health bar, same RectTransform width pattern (Pattern-002)
