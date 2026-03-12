# T004: Player Controller
## Phase: 1 — Foundation
## Status: PENDING
## Depends On: T002, T003
## Blocks: T005, T006, T007

## Description
Create a `PlayerController` MonoBehaviour that provides 8-directional movement using Rigidbody2D and Unity's new Input System. Movement speed is exposed as a serialized field (will later be driven by a ScriptableObject stats system). The controller tracks sprite facing direction based on the last non-zero movement input. Implements a state machine with three initial states: Idle, Moving, and Dodging. State transitions are clean and extensible for future states (Attacking, Stunned, etc.).

Movement uses `Rigidbody2D.MovePosition` in FixedUpdate for physics-correct movement. Input is read via the new Input System's generated C# class or PlayerInput component. Diagonal movement is normalized to prevent faster diagonal speed.

## Deliverables
- `PlayerController.cs` — MonoBehaviour with state machine, input handling, and 8-directional movement
- `PlayerState.cs` — Enum defining player states (Idle, Moving, Dodging)
- Input Action Asset configuration for Move action (Vector2, WASD + Arrow Keys + Gamepad Left Stick)
- Sprite facing direction tracking (last non-zero input direction)
- Serialized `moveSpeed` field with sensible default (e.g., 5f)

## Acceptance Criteria
- Player moves in all 8 directions using WASD, arrow keys, or gamepad left stick
- Diagonal movement speed equals cardinal movement speed (input normalized)
- Movement speed is configurable via Inspector without code changes
- State machine transitions correctly between Idle and Moving based on input
- Dodging state is defined and accessible (actual dodge logic is T005)
- Sprite facing direction updates when player moves and persists when stopping
- No movement occurs during Dodging state (controlled by T005)
- Component requires Rigidbody2D (RequireComponent attribute)
- Movement uses FixedUpdate with Rigidbody2D.MovePosition
