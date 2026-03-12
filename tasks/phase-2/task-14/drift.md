# T014 Drift Log — Combat Test Scene Integration

## Drift 1: Event Timing — OnPlayerSpawned Race Condition
- **Date:** 2026-03-12
- **Severity:** HIGH
- **What happened:** PlayerController fires `OnPlayerSpawned` in `OnEnable()`, but EnemyController, PlayerHealthUI, and CameraController subscribe to the event in their own `OnEnable()`. Depending on Unity's initialization order, the event fires before other systems subscribe — so they never receive it.
- **Impact:** Enemies had no target (couldn't chase/attack), health bar had no reference to player health, camera had no follow target.
- **Fix applied:** Added `Start()` fallback in all three scripts using `Object.FindAnyObjectByType<PlayerController>()` to find the player if the event was missed.
- **Verification:** Enemies now chase. Health bar and camera fixes not yet confirmed by user.

## Drift 2: Attack Input — Polling Instead of Callback
- **Date:** 2026-03-12
- **Severity:** MEDIUM
- **What happened:** Original attack implementation used InputAction callback subscription (`attackAction.performed += ...`). This didn't fire reliably — attack key press was ignored.
- **Impact:** Player could not attack at all.
- **Fix applied:** Rewrote to poll `attackAction.WasPressedThisFrame()` in `Update()`, plus direct `Keyboard.current.cKey.wasPressedThisFrame` fallback.
- **Verification:** Attack works reliably with C key and left mouse button.

## Drift 3: Player Health Bar Not Updating
- **Date:** 2026-03-12
- **Severity:** HIGH
- **What happened:** Health bar used Image.Type.Filled which doesn't render properly without a source sprite. Combined with OnPlayerSpawned race condition.
- **Impact:** Health bar showed no change when player took damage.
- **Fix applied:** Rewrote PlayerHealthUI to use RectTransform width scaling instead of fillAmount. Moved PlayerSpawned event from OnEnable to Start to fix subscription timing.
- **Status:** RESOLVED

## Drift 4: C Key Attack Binding
- **Date:** 2026-03-12
- **Severity:** LOW
- **What happened:** User requested attack on C key. Original spec had left mouse button only for keyboard.
- **Fix applied:** Added `<Keyboard>/c` binding to PlayerInputActions.inputactions for Attack action.
- **Agreement deviation:** Minor — user preference, not spec violation.
