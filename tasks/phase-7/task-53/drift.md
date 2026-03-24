# Drift Log — T053: Phase 7 Integration Test

## Drift Events

### Drift-001: Singleton cascade destruction
- **Date:** 2026-03-22
- **Severity:** Critical
- **What happened:** All singletons on a shared Managers GO were destroyed when any one duplicate was detected. Scene transitions broke completely.
- **Root cause:** Singleton.Awake called Destroy(gameObject) instead of Destroy(this). All singletons shared one GO.
- **Resolution:** Changed to Destroy(this). Each duplicate component self-destructs without killing siblings.

### Drift-002: GameEvents.ClearAll deafened surviving singletons
- **Date:** 2026-03-22
- **Severity:** Critical
- **What happened:** After scene transitions, PlayerManager, AudioManager, CoopManager stopped receiving events. Character data not applied, no audio, no co-op.
- **Root cause:** ClearAll nulled all event delegates. OnEnable only fires once per object lifetime. Surviving singletons never re-subscribed.
- **Resolution:** Removed ClearAll from normal transitions. Added SceneManager.sceneLoaded re-subscribe to PlayerManager, AudioManager, CoopManager.

### Drift-003: MainMenuUI destroyed singletons before scene load
- **Date:** 2026-03-22
- **Severity:** High
- **What happened:** Pressing Start Game from Main Menu caused Kennel to break — KennelStartTrigger not working.
- **Root cause:** Object.Destroy is deferred. Old singletons existed when new scene initialized, triggering duplicate detection on new scene's Managers GO.
- **Resolution:** MainMenuUI just loads the scene without destroying anything.

### Drift-004: ScreenFade coroutine wrapping broke scene loads
- **Date:** 2026-03-22
- **Severity:** High
- **What happened:** Scene transitions via SceneTransitionManager silently failed.
- **Root cause:** SceneManager.LoadScene inside a coroutine callback on ScreenFade caused timing issues.
- **Resolution:** Reverted to direct SceneManager.LoadScene calls. Fades deferred to Phase 8.

### Drift-005: Friendly fire between co-op players
- **Date:** 2026-03-24
- **Severity:** Medium
- **What happened:** P1 attacks damaged P2 and vice versa.
- **Root cause:** WeaponController and AbilityController overlap checks didn't skip PlayerController targets.
- **Resolution:** Added PlayerController skip check in all attack hit detection.

### Drift-006: Revive timer too short / dead player pushable
- **Date:** 2026-03-24
- **Severity:** Medium
- **What happened:** Downed player died after 15s with no option to revive. Living player pushed downed player across map.
- **Root cause:** Bleedout timer caused permanent death. Downed player kept active collider and dynamic rigidbody.
- **Resolution:** Removed bleedout death (revive always possible). Disabled collider + set kinematic on downed player. Auto-revive on room clear.

### Drift-007: No dungeon music
- **Date:** 2026-03-24
- **Severity:** Low
- **What happened:** Kennel had music but dungeon was silent.
- **Root cause:** AudioManager's event subscriptions lost after scene transition (OnEnable only fires once).
- **Resolution:** AudioManager re-subscribes via SceneManager.sceneLoaded callback.

### Drift-008: Co-op broken on second run + P2 invincible on rejoin
- **Date:** 2026-03-24
- **Severity:** High
- **What happened:** Second run could only play with P1. Leaving and rejoining co-op made P2 untargetable.
- **Root cause:** CoopManager's player1/player2 references pointed to destroyed GOs from previous scene. Event subscriptions stale.
- **Resolution:** CoopManager resets references and re-subscribes on scene load. P2 health initialized immediately on spawn.

### Drift-009: Double Escape handling
- **Date:** 2026-03-24
- **Severity:** Medium
- **What happened:** First Escape press froze game, second showed pause menu.
- **Root cause:** Both PlayerController.OnPause and PauseMenuUI.Update handled Escape key.
- **Resolution:** Removed OnPause from PlayerController. PauseMenuUI is sole Escape handler.

### Drift-010: Floor transition spawn outside map
- **Date:** 2026-03-24
- **Severity:** Medium
- **What happened:** Moving from Floor 1 to Floor 2, player spawned outside the room.
- **Root cause:** GenerateFloor didn't teleport players to the new start room center.
- **Resolution:** Added player teleport to start room center after floor generation.

### Drift-011: Floor portal present before boss killed
- **Date:** 2026-03-24
- **Severity:** Medium
- **What happened:** Floor 3 portal appeared before defeating the Catcher boss.
- **Root cause:** No per-floor portal flag. Stale room-cleared events from previous floor triggered portal spawn.
- **Resolution:** Added hasSpawnedPortalThisFloor flag, resets each floor.
