# T003: Input System Setup
## Phase: 1 — Foundation
## Status: PENDING
## Depends On: T001
## Blocks: T004, T005

## Description
Create the Unity New Input System configuration file (`PlayerInputActions.inputactions`) that defines all player input bindings for the game. This file is a JSON asset consumed by Unity's Input System package.

### Action Map: Player
| Action | Type | Bindings |
|--------|------|----------|
| Move | Value (Vector2) | WASD (keyboard composite), Left Stick (gamepad) |
| Dodge | Button | Space (keyboard), South/A button (gamepad) |
| Attack | Button | Left Mouse Button (keyboard/mouse), West/X button (gamepad) |
| Ability | Button | Right Mouse Button (keyboard/mouse), East/B button (gamepad) |
| Interact | Button | E (keyboard), North/Y button (gamepad) |
| Pause | Button | Escape (keyboard), Start button (gamepad) |

The file must be valid JSON that Unity's Input System can import directly. It should include proper action map structure with bindings, composite parts for Vector2 inputs, and processor configurations where appropriate.

## Deliverables
- `Assets/Settings/PlayerInputActions.inputactions` — Complete input actions asset in JSON format
- Input bindings for both keyboard+mouse and gamepad control schemes

## Acceptance Criteria
- `.inputactions` file is valid JSON parseable by Unity's Input System
- Player action map contains all 6 actions (Move, Dodge, Attack, Ability, Interact, Pause)
- Move action is Value type with Vector2 and has WASD composite binding and left stick binding
- All other actions are Button type
- Each action has both keyboard/mouse and gamepad bindings
- File is located at `Assets/Settings/PlayerInputActions.inputactions`
