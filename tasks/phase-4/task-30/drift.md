# Drift Log — T030: Phase 4 Integration Test

## Drift Events

### Drift-001: Player missing AbilityController and PassiveTraitController
- **Date:** 2026-03-20
- **Severity:** High
- **What happened:** Q ability did nothing, passive stats not applied.
- **Root cause:** Player prefab from Phase 1 didn't have Phase 4 components. PlayerManager.GetComponent returned null.
- **Resolution:** PlayerManager.EnsurePlayerComponents() adds both at runtime if missing.

### Drift-002: Character stats not applied after selection
- **Date:** 2026-03-20
- **Severity:** High
- **What happened:** Both characters looked identical regardless of selection.
- **Root cause:** PlayerSpawned event fires before user selects. Stats applied with default, never re-applied.
- **Resolution:** PlayerManager.SelectCharacter() re-applies to existing player.

### Drift-003: Boss drops no loot
- **Date:** 2026-03-20
- **Severity:** Medium
- **What happened:** No loot dropped from boss kills.
- **Root cause:** BossController.OnDeath() didn't call LootDropper.
- **Resolution:** Added LootDropper.DropBossLoot() call.

### Drift-004: Armored Hound unkillable (frontal shield always active)
- **Date:** 2026-03-20
- **Severity:** High
- **What happened:** Gray enemies on Floor 2 couldn't be killed.
- **Root cause:** Frontal shield healed 50% damage, but enemy always faces player, so shield always triggered.
- **Resolution:** Removed frontal shield entirely. Armored Hound is tanky via HP only.

### Drift-005: Boss too hard — undodgeable attacks
- **Date:** 2026-03-20
- **Severity:** High
- **What happened:** Player couldn't dodge boss attacks, died every time.
- **Root cause:** Boss scale 2x, slam radius 3, charge 3x speed, tiny 0.15s telegraph.
- **Resolution:** Scale 1.5x, slam radius 2, charge 2x, telegraph 0.5-0.6s, HP halved, longer recovery.

### Drift-006: Floor 3 too hard to reach boss
- **Date:** 2026-03-20
- **Severity:** Medium
- **What happened:** Player couldn't survive to Floor 3 boss.
- **Root cause:** Floor 3 enemies too tanky/damaging, no healing between rooms, too many rooms.
- **Resolution:** Nerfed Floor 3 enemy stats, added 25% room-clear healing, reduced Floor 3 rooms to 4-6.
