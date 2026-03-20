# [T028] Boss Controller (3 Bosses)

**Phase:** 4
**Status:** PENDING
**Complexity:** High
**Estimated Scope:** 4 files, ~350 lines

## Objective
Implement 3 boss fights with multi-phase attack patterns. Bosses use the existing HealthSystem but have a dedicated BossController with phase transitions at HP thresholds. Each boss has a larger health bar displayed at the top of the screen.

## Deliverables
- `BossController.cs` — manages boss phases, attack pattern state machine
- **Floor 1: "Big Brutus"** — charge + ground slam, summons 2 Stray Mutt adds at 50% HP
- **Floor 2: "The Catcher"** — throws net projectiles (slow player), arena walls move inward at 50% HP
- **Floor 3: "Feral King"** — fast melee combo, spawns 2 shadow clones at 60% HP, enrage (1.5x speed/damage) at 30% HP
- `BossHealthBarUI.cs` — large health bar at top of screen with boss name
- 3 BossData assets extending EnemyData with phase thresholds
- Boss death triggers floor portal spawn (already wired via GameEvents.RoomCleared)

## Files Likely Touched
- `Scripts/Enemies/BossController.cs` — new, boss phase state machine
- `Scripts/UI/BossHealthBarUI.cs` — new, top-screen boss health display
- `Scripts/Enemies/EnemyData.cs` — add boss-specific fields (phase thresholds, isHeavyAttack)
- `Scripts/Core/GameEvents.cs` — add OnBossPhaseChanged event

## Dependencies
- Depends On: T027 (enemy AI behaviors, since bosses summon regular enemies)
- Blocks: T030

## Acceptance Criteria
- [ ] Big Brutus charges toward player, slams on arrival, summons 2 adds at 50% HP
- [ ] The Catcher throws slow-projectiles, walls close in at 50% HP (room shrinks)
- [ ] Feral King does 3-hit melee combo, clones at 60%, enrage at 30%
- [ ] Boss health bar shows at top of screen with boss name
- [ ] Boss death unlocks doors and spawns floor portal
- [ ] Phase transitions have brief invulnerability window (1s) with visual tell
- [ ] Each boss has distinct color and larger scale (2x enemy size)

## Notes
- Bosses are spawned by RoomController when room type is Boss — existing system handles this
- Big Brutus: charge uses Rigidbody2D velocity toward player position, slam is AoE on arrival
- The Catcher: net projectile applies "slow" debuff (reduce player speed 50% for 3s), arena shrink spawns wall colliders
- Feral King: combo is 3 rapid attacks in facing direction, clones are weakened copies (30% HP, 50% damage), enrage buffs speed/damage
- Boss scale: set transform.localScale to (2, 2, 1) for visual distinction
