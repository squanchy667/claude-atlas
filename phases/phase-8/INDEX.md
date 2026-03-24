# Phase 8 — Human Polish

**Goal:** Interactive back-and-forth polish pass across all game areas
**Status:** IN PROGRESS
**Tasks:** Dynamic — created per feedback session

## Process

This phase does NOT use pre-planned tasks. Instead:

1. Human plays an area
2. Human reports feedback
3. Claude creates a task, implements the fix, commits
4. Human retests
5. Repeat until approved

## Areas to Polish

| Area | Status | Notes |
|------|--------|-------|
| Combat Feel | pending | Attack responsiveness, knockback, screen shake |
| Movement & Dodge | pending | Speed, dodge distance, i-frames |
| Enemy Behavior | pending | AI patterns, difficulty, telegraphs |
| Boss Fights | pending | Phase transitions, difficulty per floor |
| Dungeon Flow | pending | Room sizes, doors, minimap, progression |
| Kennel & Economy | pending | Costs, pacing, building effects, UX |
| Co-op | in progress | Second run P2 join, leave/rejoin invincibility — fixes applied, need retest |
| UI & Menus | pending | Readability, layout, buttons |
| Known Bugs | pending | All deferred issues from Phases 3-6 |

## Known Issues Backlog

| Source | Issue | Severity |
|--------|-------|----------|
| Phase 3 | Room backtrack can skip to boss (DAG short paths) | Medium |
| Phase 6 | Enemies only target reviver after revive | Low |
| Phase 6 | P2 rejoin gives full HP (no penalty) | Low |
| Phase 6 | Co-op char select: only P1 chooses | Medium |
| Phase 8 | Co-op second run: P2 can't join (GameState stuck) | High — fix applied |
| Phase 8 | Co-op leave/rejoin: P2 invincible (stale refs) | High — fix applied |
| Phase 8 | Floor graph crash on Floor 3 (empty layer2) | High — fix applied |
| Phase 8 | Boss only targeted P2 (no FindNearestPlayer) | Medium — fix applied |
| Phase 8 | Downed player could be pushed | Medium — fix applied |
| Phase 8 | Friendly fire between co-op players | Medium — fix applied |
| Phase 8 | Revive timer too short (was 15s death) | Medium — fix applied (infinite now) |
| Phase 8 | No dungeon music on scene transition | Low — fix applied |
