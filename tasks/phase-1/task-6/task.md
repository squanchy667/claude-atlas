# T006: Camera System
## Phase: 1 — Foundation
## Status: PENDING
## Depends On: T001
## Blocks: T007

## Description
Create a `CameraController` MonoBehaviour that provides smooth camera following and screen shake functionality. The camera follows the player (or a target transform) using `Vector3.Lerp` for smooth interpolation. Configurable parameters include follow speed, position offset, and a dead zone radius within which the camera does not move (preventing micro-jitter from small player movements).

A public `ScreenShake` method accepts intensity and duration parameters. Shake is implemented by applying a random offset to the camera position each frame, with a decay curve that reduces intensity over the duration. Shake stacks or interrupts cleanly (latest shake wins with highest remaining intensity).

The system is designed with co-op support in mind (Phase 6) by accepting a list of target transforms. When multiple targets exist, the camera frames all of them by calculating a centroid and adjusting position/zoom. For Phase 1, only single-target mode is needed, but the architecture should not prevent multi-target later.

## Deliverables
- `CameraController.cs` — MonoBehaviour with smooth follow, dead zone, offset, and screen shake
- Public `ScreenShake(float intensity, float duration)` method callable from any system
- Configurable serialized fields: followSpeed, offset (Vector3), deadZoneRadius
- Dead zone logic preventing camera movement for small player displacements
- Shake decay curve (linear or exponential falloff)
- Target transform reference (single target for Phase 1, architected for multi-target)

## Acceptance Criteria
- Camera smoothly follows the player transform using Lerp-based interpolation
- Follow speed is configurable and produces visually smooth results at default value
- Offset allows the camera to sit above/ahead of the player
- Dead zone prevents jitter — camera does not move when player moves within dead zone radius
- ScreenShake method produces visible camera shake when called
- Shake intensity decays over duration and does not leave camera in offset position
- Camera returns to correct follow position after shake ends
- Component works on the main camera GameObject
- Architecture supports adding multiple targets later without rewrite
