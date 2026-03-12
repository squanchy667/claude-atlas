# Agreement — T003: Input System Setup
## Status: APPROVED
## Approved: 2026-03-11 (auto-approved by atlas-run --full-permission)

## Scope
- Create `PlayerInputActions.inputactions` JSON file at `Assets/Settings/`
- Define Player action map with 6 actions: Move (Vector2), Dodge (Button), Attack (Button), Ability (Button), Interact (Button), Pause (Button)
- Include keyboard+mouse bindings: WASD composite for Move, Space for Dodge, LMB for Attack, RMB for Ability, E for Interact, Escape for Pause
- Include gamepad bindings: Left Stick for Move, South/A for Dodge, West/X for Attack, East/B for Ability, North/Y for Interact, Start for Pause
- File must be valid JSON conforming to Unity Input System .inputactions schema

## Not In Scope
- C# generated input action wrapper class (Unity auto-generates this)
- UI action map (will be added in a later task if needed)
- Rebinding UI or settings menu
- Touch/mobile input bindings

## Checkpoint Parameters
- `Assets/Settings/PlayerInputActions.inputactions` exists and is valid JSON
- JSON contains a Player action map with exactly 6 actions
- Move action uses Value/Vector2 type with WASD composite and left stick bindings
- Dodge, Attack, Ability, Interact, Pause actions use Button type
- Every action has at least one keyboard/mouse binding and one gamepad binding

## Skills Used
- Unity New Input System configuration
- JSON authoring for Unity assets

## Risks
- .inputactions JSON schema is not formally documented; must match Unity's expected format exactly
- Action IDs (GUIDs) must be unique within the file
