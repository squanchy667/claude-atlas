# Drift Log — T022: Dungeon Integration Test

## Drift Events

### Drift-001: Door direction wall conflicts
- **Date:** 2026-03-20
- **Severity:** High
- **What happened:** Per-connection direction assignment caused wall conflicts — two doors assigned to the same wall of a room. Player couldn't navigate the dungeon reliably.
- **Root cause:** `GetDirectionTo()` assigned directions independently per connection. Room with 3+ connections could get duplicate wall assignments.
- **Resolution:** Complete rewrite of door direction system. Added `AssignDoorDirections()` pre-computation pass that checks all connections across the graph for conflict-free wall assignments before any rooms are built.
- **Impact:** DungeonGenerator.cs major rewrite of direction assignment.

### Drift-002: Teleport ping-pong between doors
- **Date:** 2026-03-20
- **Severity:** High
- **What happened:** Entering door A teleported player to door B, which immediately triggered door B back to door A, creating infinite bounce.
- **Root cause:** No cooldown between door teleports. Player's trigger collider overlapped destination door on arrival.
- **Resolution:** Added 0.4s teleport cooldown + velocity clearing on teleport.
- **Impact:** DungeonGenerator.cs teleport logic.

### Drift-003: Minimap clipping and sizing
- **Date:** 2026-03-20
- **Severity:** Medium
- **What happened:** Minimap nodes rendered outside the visible frame. Right side consistently cut off. Went through ~5 iterations of fixes.
- **Root cause:** Multiple compounding issues: wrong pivot/anchor, no clipping mask, Mask component (alpha-based) didn't work with RectMask2D, padding insufficient for half-node-size overshoot.
- **Resolution:** Rewrote to use RectMask2D, added MINIMAP_PADDING (14px = NODE_SIZE/2 + 8), reduced to 150px, anchored at (-20, -15) from top-right.
- **Impact:** MinimapUI.cs complete rewrite.

### Drift-004: DontDestroyOnLoad singletons persist across restart
- **Date:** 2026-03-20
- **Severity:** High
- **What happened:** Pressing R to restart loaded the scene fresh, but singletons (GameManager, RunManager, DungeonGenerator) survived. New scene's DungeonStartTrigger was on a singleton GO that got destroyed by duplicate check.
- **Root cause:** Singleton pattern uses DontDestroyOnLoad. Scene reload doesn't destroy these objects.
- **Resolution:** Created GameOverUI that explicitly destroys all singleton GOs and calls GameEvents.ClearAll() before SceneManager.LoadScene.
- **Impact:** New file GameOverUI.cs. SceneSetup.cs updated.

### Drift-005: Boss room reachable too early
- **Date:** 2026-03-20
- **Severity:** Medium
- **What happened:** With middleRooms <= 3 threshold, FloorGraph used single middle layer. Path was Start → middle → Boss (only 2 transitions). Boss should require at least 3 transitions.
- **Root cause:** Threshold too generous. Floors with 5 rooms had 3 middle rooms, all in one layer.
- **Resolution:** Changed threshold to middleRooms <= 1. Now 2+ middle rooms always split into 2 layers: Start → layer1 → layer2 → Boss.
- **Impact:** FloorGraph.cs layer generation logic.

### Drift-006: Legacy Input System deprecation warning
- **Date:** 2026-03-20
- **Severity:** Low
- **What happened:** GameOverUI used `Input.GetKeyDown(KeyCode.R)` which triggers Unity deprecation warning when project uses new Input System.
- **Root cause:** Quick implementation used familiar legacy API.
- **Resolution:** Migrated to `Keyboard.current.rKey.wasPressedThisFrame` with `using UnityEngine.InputSystem`.
- **Impact:** GameOverUI.cs.

### Drift-007: Runtime sprites null — walls and floors invisible
- **Date:** 2026-03-20
- **Severity:** High
- **What happened:** Walls and floors were completely invisible at runtime despite colliders working. Players got stuck on invisible walls with no visual feedback.
- **Root cause:** `DungeonGenerator.wallSprite` and `floorSprite` are private non-serialized fields. `SetSprites()` was called at editor time in `SceneSetup.CreateDungeonTestScene()`, but the values were lost when the scene was saved and reloaded in Play mode. All `SpriteRenderer` components received null sprites.
- **Resolution:** Added `EnsureSprites()` method to `DungeonGenerator` that creates a 16x16 white runtime sprite if sprites are null. Called at the start of `GenerateFloor()`. Also increased wall thickness (1f → 1.5f), added black outline borders behind walls, and set high-contrast floor colors per floor.
- **Impact:** DungeonGenerator.cs, RoomBuilder.cs, RunManager.cs, SceneSetup.cs.

## Open Issues (Not Yet Resolved)

### Issue-001: Treasure/Shop rooms not interactive
- **Severity:** Medium
- **What:** Treasure rooms show a gold block and shop rooms show a green block, but player cannot interact with them. No pickup, no shop UI, no reward.
- **Status:** BY DESIGN for Phase 3. Treasure/shop interaction is Phase 5 (The Kennel / economy) scope.

## Resolved Issues

### Issue-002: Invisible wall colliders — FIXED
- **Resolved:** 2026-03-20
- **Fix:** Root cause was null sprites at runtime (Drift-007). Walls now render with thick outlines and high-contrast colors.

### Issue-003: Floor color changes not noticeable — FIXED
- **Resolved:** 2026-03-20
- **Fix:** Replaced muted colors with high-saturation palette: steel-blue (F1), sandy gold (F2), vivid magenta (F3). Visible immediately.
