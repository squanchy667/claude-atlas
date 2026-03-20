# Agreement — T024: Active Ability System

**Status:** APPROVED
**Approved:** 2026-03-20

## Scope
Implement the active ability system with an AbilityController component that reads AbilityData, executes abilities on input (Q key / left bumper), tracks cooldown with a UI indicator, and provides two concrete ability implementations: Ground Slam (AoE) for Malinois and Dash Strike (forward dash) for Vizsla.

## Checkpoint Parameters
- AbilityController component manages ability execution, cooldown tracking, and state checks (no use while dead/dodging)
- Two abilities implemented: Ground Slam (3-unit AoE, knockback, screen shake, 8s cooldown) and Dash Strike (4-unit dash with damage, i-frames, 5s cooldown)
- Cooldown UI indicator displays remaining cooldown time near health bar

## Out of Scope
- Passive trait system (T025)
- Character selection flow (T026)
- Additional abilities beyond Ground Slam and Dash Strike
- Ability upgrades or modifications

## Acceptance Criteria
- [ ] Ground Slam: damages all enemies in 3-unit radius, applies knockback outward, screen shake
- [ ] Dash Strike: player dashes 4 units forward, damages enemies in path, brief i-frames
- [ ] Cooldown prevents re-use (Ground Slam: 8s, Dash Strike: 5s)
- [ ] Cooldown UI shows remaining time
- [ ] Ability input works (Q key and gamepad)
- [ ] Ability respects player state (can't use while dead or dodging)
