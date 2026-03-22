# Drift Log — T045: Phase 6 Integration Test

## Drift Events

### Drift-001: P2 couldn't pass through doors
- **Date:** 2026-03-22
- **Severity:** High
- **What happened:** P2 entered door triggers but only P1 was teleported. P2 remained stuck in the first room.
- **Root cause:** `DungeonGenerator.OnPlayerEnteredDoor()` only teleported `playerTransform` (always P1). The door detected P2 via PlayerController check but the teleport target was hardcoded to P1.
- **Resolution:** Changed `OnPlayerEnteredDoor` to accept the entering player's Transform. Then changed to teleport ALL players when any player enters a door (both move to the new room together).
- **Impact:** Door.cs, DungeonGenerator.cs refactored.

### Drift-002: Enemies stopped attacking in co-op
- **Date:** 2026-03-22
- **Severity:** High
- **What happened:** When P2 joined, all enemies in P1's room stopped chasing and attacking. They appeared to drift toward walls or stand idle.
- **Root cause:** `EnemyController.OnPlayerSpawned()` set `target` to the last spawned player. When P2 spawned, ALL enemies retargeted to P2 — who was in a different room. Enemies chased toward P2 through walls, ignoring P1.
- **Resolution:** Replaced single-target with `FindNearestPlayer()` that picks the closest alive, non-downed player using `FindObjectsByType`. Re-evaluated every ~0.5s (frame % 30).
- **Impact:** EnemyController.cs major targeting refactor.

### Drift-003: Both players same color
- **Date:** 2026-03-22
- **Severity:** Medium
- **What happened:** P1 and P2 appeared identical in color regardless of character selection.
- **Root cause:** CoopManager set P2 color to `p1Color * nearWhiteTint` (barely visible difference). Then PlayerManager.OnPlayerSpawned applied the character's base spriteColor, overwriting even that subtle tint.
- **Resolution:** PlayerManager now gives P2 an inverted/contrasting color derived from the character's base color, ensuring P1 and P2 are always visually distinct.
- **Impact:** PlayerManager.cs ApplyCharacterData modified.
