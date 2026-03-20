# Agreement — T030: Phase 4 Integration Test

**Status:** APPROVED
**Approved:** 2026-03-20

## Scope
Wire all Phase 4 systems together, configure per-floor enemy pools and loot tables, update the DungeonTest scene with character selection flow, and verify the full run loop works end-to-end: character select through 3-floor dungeon completion with all enemy types, bosses, and loot.

## Checkpoint Parameters
- DungeonTest scene updated with character selection flow and per-floor enemy pool configuration (Floor 1: Stray Mutt + Barker, Floor 2: adds Armored Hound + Pack Runner, Floor 3: adds Shadow Dog + Howler)
- All 3 bosses assigned to their respective floors (Big Brutus, The Catcher, Feral King) with LootTable assets per floor
- Full 3-floor run completable without crashes; all integration bugs discovered during testing are fixed

## Out of Scope
- New features or systems not already built in T023-T029
- Performance optimization
- Difficulty balancing beyond basic enemy pool assignment
- Art, animation, or audio polish

## Acceptance Criteria
- [ ] Character select screen appears before dungeon run
- [ ] Malinois and Vizsla have visibly different stats and abilities
- [ ] Floor 1 spawns Stray Mutts and Barkers
- [ ] Floor 2 adds Armored Hounds and Pack Runners
- [ ] Floor 3 adds Shadow Dogs and Howlers
- [ ] Each floor's boss appears in the boss room with correct behavior
- [ ] Loot drops from enemies and can be picked up
- [ ] Weapon pickups change the player's weapon
- [ ] Resource pickups increment run counters
- [ ] Full 3-floor run completable without crashes
