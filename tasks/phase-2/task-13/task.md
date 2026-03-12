# T013: Health Bar UI
## Phase: 2 — Combat Core
## Status: PENDING
## Depends On: T009
## Blocks: T014

## Description
Implement a screen-space overlay health bar that displays the player's current and maximum health. The UI reads from the HealthSystem component via events, following the reactive event-driven pattern used throughout the project.

### PlayerHealthUI MonoBehaviour
| Member | Type | Purpose |
|--------|------|---------|
| healthSlider | Slider (serialized) | UI Slider for health bar fill |
| fillImage | Image (serialized) | Fill image for color control |
| healthText | TextMeshProUGUI (serialized, optional) | Shows "current / max" text |
| playerHealth | HealthSystem (serialized) | Reference to player's HealthSystem |
| fullHealthColor | Color (serialized) | Color at full health (default green) |
| lowHealthColor | Color (serialized) | Color at low health (default red) |
| lowHealthThreshold | float (serialized, default 0.3f) | Percentage threshold for low health color |

### Behavior
- Subscribes to `playerHealth.OnHealthChanged` in `OnEnable`, unsubscribes in `OnDisable`
- On health change: updates Slider value (currentHealth / maxHealth)
- On health change: updates fill color (lerp from lowHealthColor to fullHealthColor based on health percentage)
- On health change: updates healthText to show `"{current} / {max}"` if text component is assigned
- Initializes display in `Start()` by reading current values from HealthSystem

### Canvas Setup
- Expects to be placed on a Screen Space - Overlay Canvas
- Canvas and Slider setup is done in the scene (or programmatically in T014), not in this script
- Script only manages the data binding and visual updates

## Deliverables
- `Assets/Scripts/UI/PlayerHealthUI.cs` — PlayerHealthUI MonoBehaviour

## Acceptance Criteria
- PlayerHealthUI subscribes to HealthSystem.OnHealthChanged events
- Slider value updates to reflect currentHealth / maxHealth ratio
- Fill color changes based on health percentage (green at full, red at low)
- Health text displays "current / max" format when text component is assigned
- Properly subscribes in OnEnable and unsubscribes in OnDisable
- Initializes correctly on Start with current health values
- Works with any HealthSystem reference (not hardcoded to find player)
- File compiles without errors
