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

## Open Issues (Not Yet Resolved)

### Issue-001: Invisible wall colliders
- **Severity:** Medium
- **What:** Player hits invisible barriers around rooms, especially near doors and portals. Wall colors were brightened but still not visible enough against dark background, or some colliders exist without corresponding visuals.
- **Status:** NOT FIXED — carried to Phase 4 or polish phase.

### Issue-002: Treasure/Shop rooms not interactive
- **Severity:** Medium
- **What:** Treasure rooms show a gold block and shop rooms show a green block, but player cannot interact with them. No pickup, no shop UI, no reward.
- **Status:** BY DESIGN for Phase 3. Treasure/shop interaction is Phase 5 (The Kennel / economy) scope.

### Issue-003: Floor color changes not noticeable
- **Severity:** Low
- **What:** Despite updating floor and wall colors for all 3 floors (blue-gray, brown, purple), visual difference between floors was not noticeable to the user during playtesting.
- **Status:** NOT FIXED — may need stronger color differentiation or tilemap-based approach in Phase 7 (Polish).
