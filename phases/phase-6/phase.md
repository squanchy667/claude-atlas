# Phase 6 — Co-op

## Goal
PlayerInputManager for 2-player local co-op, split character select, shared camera with dynamic zoom, co-op balancing (enemy scaling), shared resource pool, revive mechanic.

## Key Deliverables
- PlayerInputManager setup for 2 local players (keyboard + controller, or 2 controllers)
- Player 2 join/leave flow (press button to join)
- Split character select: each player picks independently
- Shared camera with dynamic zoom (pulls back when players separate)
- Max separation leash (players can't go too far apart)
- Enemy scaling for co-op: more enemies, slightly more HP
- Shared resource pool during runs
- Revive mechanic: downed player can be revived by partner within time limit
- Co-op-aware UI: two health bars, two ability indicators
- All single-player functionality preserved (co-op must not break solo play)

## Entry Criteria
- Phase 5 complete: full game loop works in single player (run → kennel → run)

## Exit Criteria
- Second player can join and play through full dungeon runs
- Camera handles 2 players smoothly with dynamic zoom
- Enemy count/HP scales for co-op
- Revive mechanic works
- Single player is unaffected by co-op code
- Character select works for 2 players

## Dependencies
- Phase 5 (complete single-player game loop)
