# Agreement — T013: Health Bar UI
## Status: APPROVED
## Approved: 2026-03-12 (auto-approved by atlas-run --full-permission)

## Scope
- Create PlayerHealthUI MonoBehaviour in `Assets/Scripts/UI/PlayerHealthUI.cs`
- Subscribe to HealthSystem.OnHealthChanged to update UI reactively
- Update Slider value (currentHealth / maxHealth ratio)
- Update fill color with lerp between lowHealthColor and fullHealthColor based on health percentage
- Update optional TextMeshProUGUI with "current / max" format
- Initialize display on Start with current health values
- Subscribe in OnEnable, unsubscribe in OnDisable

## Not In Scope
- Canvas or Slider prefab creation (scene setup handled in T014 or manually)
- Enemy health bars (floating world-space bars are a later feature)
- Health bar animations (smooth lerp, pulse on low health — Phase 7 polish)
- Damage numbers or floating text
- Shield or armor bar

## Checkpoint Parameters
- `Assets/Scripts/UI/PlayerHealthUI.cs` exists and compiles without errors
- Subscribes to HealthSystem.OnHealthChanged in OnEnable, unsubscribes in OnDisable
- Slider value updates to currentHealth / maxHealth on health change
- Fill color lerps between configured colors based on health percentage
- Health text updates when TextMeshProUGUI component is assigned (null-safe)
- Initializes display on Start

## Skills Used
- Unity Canvas UI patterns
- Event-driven UI binding

## Risks
- TextMeshProUGUI requires the TextMeshPro package; verify it is available in the project
- Slider and Image references must be wired in the inspector or programmatically
