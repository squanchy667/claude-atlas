# T021: Minimap UI
## Phase: 3 — Dungeon Generation
## Status: PENDING
## Complexity: Medium
## Estimated Scope: 1 file, ~200 lines

## Objective
Create a minimap UI that shows the dungeon's DAG graph. Rooms appear as nodes connected by lines. Current room is highlighted, explored rooms show their type, unexplored rooms are grayed out.

## Deliverables
- `Assets/Scripts/UI/MinimapUI.cs` — Canvas-based minimap overlay

## Dependencies
- Depends On: T016, T019
- Blocks: T022

## Acceptance Criteria
- [ ] Minimap renders in top-right corner of screen
- [ ] Rooms shown as small colored squares connected by lines
- [ ] Current room highlighted (yellow border or bright color)
- [ ] Explored rooms show type color (Combat=red, Treasure=gold, Shop=green, Boss=magenta, Start=cyan)
- [ ] Unexplored rooms are gray
- [ ] Minimap updates when player enters a new room
- [ ] Minimap resets when a new floor generates
