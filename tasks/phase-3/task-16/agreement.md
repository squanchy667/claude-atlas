# Agreement — T016: Floor Graph Generator
## Status: APPROVED
## Approved: 2026-03-12 (auto-approved by atlas-run --full-permission)

## Scope
- FloorGraph class with node/edge data structure
- DAG generation: Start → branching layers → convergence → Boss
- RoomNode class with room type, connections, graph position
- Seeded random generation
- Room type assignment logic

## Not In Scope
- Physical room instantiation (T019)
- Room prefabs or visuals (T017)
- Minimap rendering (T021)

## Checkpoint Parameters
- FloorGraph generates valid DAGs with 5-8 rooms consistently
- No dead-end nodes (every node has a path to Boss)
- Exactly 1 Start and 1 Boss per floor
- Room type distribution: 1 Treasure, 1 Shop, rest Combat
- Seeded generation produces identical results for same seed

## Skills Used
- singleton-events-pattern
