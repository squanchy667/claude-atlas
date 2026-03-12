# Agreement — T006: Camera System
## Status: APPROVED
## Approved: 2026-03-11 (auto-approved by atlas-run --full-permission)

## Scope
- CameraController MonoBehaviour with Lerp-based smooth follow
- Configurable follow speed, offset, and dead zone radius
- ScreenShake method with intensity, duration, and decay curve
- Single-target following for Phase 1
- Architecture that does not preclude multi-target (co-op) in Phase 6

## Not In Scope
- Multi-target centroid calculation and dynamic zoom (Phase 6)
- Cinemachine integration (may be evaluated later)
- Camera bounds / room clamping (future phase)
- Camera transitions between rooms
- Post-processing effects

## Checkpoint Parameters
- Camera follows player smoothly with no snapping or teleporting
- Dead zone prevents camera movement for small player displacements
- ScreenShake method produces visible shake effect when called with test values (e.g., 0.3 intensity, 0.2 duration)
- Shake decays to zero and camera returns to correct position after shake
- Follow speed, offset, and dead zone radius are configurable in Inspector
- No jitter or oscillation at any follow speed setting

## Skills Used
- unity-monobehaviour (component architecture)
- unity-camera (camera positioning and LateUpdate usage)
- coroutines (screen shake timing and decay)

## Risks
- Camera must update in LateUpdate to avoid jitter from following a physics-driven player in FixedUpdate
- Dead zone logic must use distance check, not axis-independent thresholds, to avoid rectangular dead zones
- Screen shake must not accumulate offset — must be applied and removed each frame, not added incrementally
