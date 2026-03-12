# Agreement — T021: Minimap UI
## Status: APPROVED
## Approved: 2026-03-12 (auto-approved by atlas-run --full-permission)

## Scope
- MinimapUI MonoBehaviour on Canvas
- Room node rendering (colored Image per room)
- Connection line rendering (UI lines between nodes)
- State tracking: current, explored, unexplored
- Room type color coding
- Event-driven updates via GameEvents.OnRoomEntered

## Not In Scope
- Fog of war or gradual reveal
- Interactive minimap (clicking rooms)

## Checkpoint Parameters
- Minimap renders correctly for generated floor
- Node colors match room types for explored rooms
- Current room is visually distinct
- Unexplored rooms are gray
- Minimap updates on room transition
- Minimap resets on new floor

## Skills Used
- Pattern-002 (RectTransform UI)
