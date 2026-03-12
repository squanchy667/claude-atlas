# Outcome — T003: Input System Setup
## Status: DONE
## Completed: 2026-03-11

## What Was Built
PlayerInputActions.inputactions JSON asset at `Assets/Settings/` defining the Player action map with 6 actions and bindings for both Keyboard&Mouse and Gamepad control schemes.

## Files Created/Changed
- `Assets/Settings/PlayerInputActions.inputactions` — Complete Input System asset with Player action map

## Actions Defined
| Action | Type | Keyboard/Mouse | Gamepad |
|--------|------|----------------|---------|
| Move | Value (Vector2) | WASD composite | Left Stick (with StickDeadzone) |
| Dodge | Button | Space | South/A |
| Attack | Button | Left Mouse Button | West/X |
| Ability | Button | Right Mouse Button | **Right Trigger** |
| Interact | Button | E | North/Y |
| Pause | Button | Escape | Start |

## Tests Added
- None (JSON asset — validated by Unity import)

## Deviations From Agreement
- **Ability gamepad binding**: Agreement specified East/B button. Implementation uses Right Trigger (`<Gamepad>/rightTrigger`). See drift.md for details. Right Trigger may feel more natural for ability activation in a roguelite context, but it deviates from the agreed binding.

## Checkpoint Parameters Verification
- [x] `Assets/Settings/PlayerInputActions.inputactions` exists and is valid JSON
- [x] JSON contains a Player action map with exactly 6 actions
- [x] Move action uses Value/Vector2 type with WASD composite and left stick bindings
- [x] Dodge, Attack, Ability, Interact, Pause actions use Button type
- [x] Every action has at least one keyboard/mouse binding and one gamepad binding
- [ ] Ability gamepad binding is East/B (DRIFT: uses Right Trigger instead)
