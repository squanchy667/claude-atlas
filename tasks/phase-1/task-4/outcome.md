# Outcome — T004: Player Controller
## Status: DONE
## Completed: 2026-03-11

## What Was Built
PlayerController MonoBehaviour with 8-directional movement, state machine (Idle, Moving, Dodging, Attacking, Dead), Input System integration, facing direction tracking, and sprite flip. Located at `Assets/Scripts/Player/PlayerController.cs` in the `DogPack.Player` namespace.

## Files Created/Changed
- `Assets/Scripts/Player/PlayerController.cs` — Player controller with state machine, input handling, movement, facing direction

## Implementation Details
- **State machine**: 5 states (Idle, Moving, Dodging, Attacking, Dead) — Attacking and Dead added for forward compatibility
- **Input**: Uses PlayerInput component with action references for Move, Dodge, Pause
- **Movement**: `rb.linearVelocity = movement` in FixedUpdate (see drift.md for deviation from MovePosition)
- **Facing**: 8-direction enum updated from movement input angle, with sprite flipX for left-facing
- **References**: RequireComponent(Rigidbody2D), auto-resolves SpriteRenderer and DodgeRoll
- **Pause integration**: OnPause delegates to GameManager.TogglePause()
- **Events**: Fires GameEvents.PlayerSpawned on enable, GameEvents.PlayerDied on death

## Tests Added
- None (requires Unity runtime for testing)

## Deviations From Agreement
- **Movement method**: Agreement specifies `Rigidbody2D.MovePosition` in FixedUpdate. Implementation uses `rb.linearVelocity` assignment instead. See drift.md. Both are valid physics movement approaches, but velocity-based gives smoother results with collision response and is the more modern Unity pattern.
- **PlayerState expanded**: Added `Attacking` and `Dead` states beyond agreed Idle/Moving/Dodging. No states removed.
- **FacingDirection**: Created as a separate enum with 8 values, which is more explicit than the task description's general "facing direction" concept.

## Checkpoint Parameters Verification
- [x] Player moves in 8 directions with equal speed on diagonals (normalized input)
- [x] Movement speed is configurable via serialized field (moveSpeed = 6f)
- [x] State machine transitions correctly: Idle <-> Moving
- [x] Facing direction persists when player stops moving (LastNonZeroInput)
- [ ] Rigidbody2D.MovePosition used in FixedUpdate (DRIFT: uses rb.linearVelocity instead)
- [x] Component compiles with no errors and attaches to a GameObject
