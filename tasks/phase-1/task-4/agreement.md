# Agreement — T004: Player Controller
## Status: APPROVED
## Approved: 2026-03-11 (auto-approved by atlas-run --full-permission)

## Scope
- PlayerController MonoBehaviour with 8-directional movement via Rigidbody2D
- New Input System integration for Move action (WASD, arrows, gamepad)
- Player state machine with Idle, Moving, Dodging states
- Sprite facing direction tracking
- Serialized moveSpeed field for Inspector configuration
- Normalized diagonal movement

## Not In Scope
- ScriptableObject-driven stats (future phase)
- Dodge roll logic and i-frames (T005)
- Attack input or combat states
- Animation integration
- Networked/co-op input

## Checkpoint Parameters
- Player moves in 8 directions with equal speed on diagonals
- Movement speed is configurable via serialized field in Inspector
- State machine transitions correctly: Idle <-> Moving, any -> Dodging
- Facing direction persists when player stops moving
- Rigidbody2D.MovePosition used in FixedUpdate for physics-correct movement
- Component compiles with no errors and attaches to a GameObject

## Skills Used
- unity-monobehaviour (component architecture)
- unity-input-system (new Input System setup)
- state-machine (player state management)

## Risks
- Input System package must be installed and active input handling set to "Both" or "Input System Package (New)" in Player Settings
- State machine must be extensible — tight coupling now will cause refactors when adding combat states
- Rigidbody2D settings (gravity scale 0, interpolation) must be correct or movement will feel wrong
