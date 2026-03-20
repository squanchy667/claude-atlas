# Agreement — T028: Boss Controller (3 Bosses)

**Status:** APPROVED
**Approved:** 2026-03-20

## Scope
Implement 3 boss fights with multi-phase attack patterns using a dedicated BossController with HP-threshold phase transitions, a top-screen boss health bar UI, and 3 BossData SO assets extending EnemyData.

## Checkpoint Parameters
- BossController manages phase state machine with invulnerability windows (1s) at phase transitions
- 3 bosses implemented: Big Brutus (charge + slam, summons adds at 50%), The Catcher (net projectiles + arena shrink at 50%), Feral King (melee combo, clones at 60%, enrage at 30%)
- BossHealthBarUI displays at top of screen with boss name; boss death triggers floor portal spawn via GameEvents

## Out of Scope
- Boss loot drops (handled by T029 loot system)
- Boss difficulty scaling per run
- Boss animations or sprite art (placeholder 2x scale with distinct colors)
- Additional bosses beyond the 3 specified

## Acceptance Criteria
- [ ] Big Brutus charges toward player, slams on arrival, summons 2 adds at 50% HP
- [ ] The Catcher throws slow-projectiles, walls close in at 50% HP (room shrinks)
- [ ] Feral King does 3-hit melee combo, clones at 60%, enrage at 30%
- [ ] Boss health bar shows at top of screen with boss name
- [ ] Boss death unlocks doors and spawns floor portal
- [ ] Phase transitions have brief invulnerability window (1s) with visual tell
- [ ] Each boss has distinct color and larger scale (2x enemy size)
