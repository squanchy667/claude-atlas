# T016: Floor Graph Generator
## Phase: 3 — Dungeon Generation
## Status: PENDING
## Complexity: High
## Estimated Scope: 2 files, ~300 lines

## Objective
Build the pyramid DAG algorithm that generates a branching floor graph. Player starts at one node, paths branch outward, and all paths converge at the boss node. This is the core procedural generation algorithm.

## Deliverables
- `Assets/Scripts/Dungeon/FloorGraph.cs` — Graph data structure (nodes + edges) and DAG generation algorithm
- `Assets/Scripts/Dungeon/RoomNode.cs` — Individual room node data (type, connections, position in graph)

## Dependencies
- Depends On: T015
- Blocks: T019, T021

## Acceptance Criteria
- [ ] FloorGraph generates a valid DAG with 5-8 rooms
- [ ] Graph has exactly 1 Start node and 1 Boss node
- [ ] Paths branch from Start and converge at Boss (no dead ends)
- [ ] Room types are assigned: majority Combat, 1 Treasure, 1 Shop per floor
- [ ] Generation is seeded for reproducibility
- [ ] Graph can be queried: GetStartRoom(), GetBossRoom(), GetConnections(node)
