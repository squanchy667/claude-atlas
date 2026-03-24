# Project Progress

> Live project state. Updated automatically by Atlas commands.

## Current State
- **Project:** DogPack Roguelite
- **Setup Complete:** yes
- **Preview Approved:** yes
- **Current Phase:** 7 — Polish & UI (complete, tested)
- **Phase Progress:** 8/8 tasks done
- **Current Task:** None — Phase 7 complete
- **Last Activity:** Phase 7 Unity tested: 11 drift events found and fixed. Singleton cascade, scene transitions, co-op bugs, audio, floor transitions all resolved.
- **Last Updated:** 2026-03-24
- **Team Mode:** no

## Health
- [ ] Tests passing (no automated tests yet — Unity project)
- [x] Documentation current
- [x] No open blockers
- [x] On schedule

## Phase Breakdown

| Phase | Name | Status | Tasks | Completed |
|-------|------|--------|-------|-----------|
| 1 | Foundation | complete | 7/7 | 2026-03-11 |
| 2 | Combat Core | complete | 7/7 | 2026-03-12 |
| 3 | Dungeon Generation | complete | 8/8 | 2026-03-20 |
| 4 | Characters & Enemies | complete | 8/8 | 2026-03-20 |
| 5 | The Kennel (Base) | complete | 8/8 | 2026-03-20 |
| 6 | Co-op | complete | 7/7 | 2026-03-22 |
| 7 | Polish & UI | complete | 8/8 | 2026-03-24 |

## Recent Activity

| Date | Event | Details |
|------|-------|---------|
| 2026-03-11 | Project initialized | Atlas structure created |
| 2026-03-11 | Setup completed | Project definition, architecture, data model, 7 phases, 7 foundation skills |
| 2026-03-11 | Gaps resolved | All 7 gaps resolved |
| 2026-03-11 | Preview approved | 9 architectural decisions logged |
| 2026-03-11 | Phase 1 executed | All 7 tasks completed via atlas-run --full-permission |
| 2026-03-11 | Phase 1 outcomes | 7 outcome files written, 3 drift logs recorded |
| 2026-03-11 | Phase 1 checkpoint | Approved, committed, pushed |
| 2026-03-12 | Phase 2 planned | 7 tasks (T008–T014), all agreements approved |
| 2026-03-12 | Phase 2 code written | T008–T013 implemented, T014 scene setup updated |
| 2026-03-12 | Phase 2 partial verify | Attack works (C key), enemies chase. Health bar update issue unresolved. Paused. |
| 2026-03-12 | T014 bugs fixed | Event timing, health bar rendering, enemy hit feedback all resolved. Phase 2 complete. |
| 2026-03-12 | Phase 2 closed | Memory consolidated (3 patterns, 2 mistakes, 1 systemic drift). Advancing to Phase 3. |
| 2026-03-12 | Phase 3 planned | 8 tasks (T015–T022), all agreements auto-approved. |
| 2026-03-12 | Phase 3 code written | All 8 tasks implemented. 12 new scripts, 1 SceneSetup extension. Needs Unity testing. |
| 2026-03-20 | Phase 3 Unity tested | Iterative testing: 6 major bugs fixed (door conflicts, teleport bounce, minimap clipping, restart singletons, boss depth, Input System). 3 open issues identified. |
| 2026-03-20 | Phase 3 fixes approved | Runtime sprite fix (walls/floors visible), high-contrast floor colors. 2/3 open issues resolved. Treasure/shop deferred to Phase 5 by design. Phase 3 complete. |
| 2026-03-20 | Phase 4 planned | 8 tasks (T023–T030): character data, abilities, passives, char select, 6 enemy types, 3 bosses, loot system, integration test. All agreements approved. |
| 2026-03-20 | Phase 4 code written | All 8 tasks implemented. 20+ new scripts. Needs Unity testing. |
| 2026-03-20 | Phase 4 approved | Unity tested. 5 bug fixes + 4 balance iterations. Full 3-floor run validated. |
| 2026-03-20 | Phase 5 code written | 8 tasks (T031–T038). Kennel scene, dogs, buildings, upgrades, save/load, scene transitions. Needs Unity testing. |
| 2026-03-20 | Phase 5 approved | Unity tested. 3 bug fixes (UpgradeManager NullRef, EventSystem missing, Build Settings). Full Kennel↔Dungeon loop validated. |
| 2026-03-20 | Phase 6 code written | 7 tasks (T039–T045). CoopManager, P2 join/leave, dual UI, camera leash, enemy scaling, revive mechanic. |
| 2026-03-22 | Phase 6 approved | Co-op tested. 4 bug fixes (doors, targeting, color, revive). 3 known issues deferred to Phase 7. |
| 2026-03-22 | Phase 7 code written | 8 tasks (T046–T053). Main menu, pause, audio, fades, particles, difficulty, game feel. |
| 2026-03-24 | Phase 7 Unity tested | 11 drift events found and fixed. Singleton cascade, scene transitions, co-op, audio, floor transitions all resolved. |

## Drift Summary (Active)

| Phase | Task | Issue | Severity |
|-------|------|-------|----------|
| 1 | T003 | Ability gamepad binding: rightTrigger vs East/B | Low |
| 1 | T004 | Movement: linearVelocity vs MovePosition | Medium |
| 1 | T005 | I-frames: boolean flag vs Physics2D layer collision | Medium |
| 2 | T010 | Attack input: polling in Update() instead of InputAction callback | Medium |
| 2 | T010 | Added direct C key fallback alongside InputSystem | Low |
| 2 | T014 | Event timing: OnPlayerSpawned fires before subscribers ready | High |
| 2 | T014 | Player health bar not updating when enemies attack | High |
| 3 | T022 | Door direction wall conflicts — required full graph pre-computation | High |
| 3 | T022 | Teleport ping-pong between doors — added cooldown | High |
| 3 | T022 | Minimap clipping/sizing — ~5 iterations, rewrote to RectMask2D | Medium |
| 3 | T022 | DontDestroyOnLoad singletons persist across restart | High |
| 3 | T022 | Boss reachable in 2 transitions — tightened layer threshold | Medium |
| 3 | T022 | Legacy Input.GetKeyDown deprecation — migrated to Input System | Low |
| 5 | T038 | Room backtrack can skip to boss on Floor 2/3 — DAG short paths | Medium |
| 6 | T045 | P2 couldn't pass through doors — teleport only moved P1 | High |
| 6 | T045 | Enemies retargeted to P2 and stopped attacking P1 | High |
| 6 | T045 | P1 and P2 same color — no visual distinction | Medium |
| 6 | T045 | Enemies only target reviver after revive — need retarget event | Low |
| 6 | T045 | P2 rejoin gives full HP — no penalty for leave/rejoin | Low |
| 6 | T045 | Co-op char select: only P1 chooses, no P2 independent selection | Medium |
| 7 | T053 | Singleton cascade destruction — Destroy(gameObject) killed all singletons on shared GO | Critical |
| 7 | T053 | ClearAll deafened surviving singletons — never re-subscribed | Critical |
| 7 | T053 | MainMenuUI destroyed singletons before scene load | High |
| 7 | T053 | ScreenFade coroutine wrapping broke scene loads | High |
| 7 | T053 | Friendly fire between co-op players | Medium |
| 7 | T053 | Revive timer too short / dead player pushable | Medium |
| 7 | T053 | No dungeon music — AudioManager subscriptions lost | Low |
| 7 | T053 | Co-op broken on second run + P2 invincible | High |
| 7 | T053 | Double Escape handling froze then paused | Medium |
| 7 | T053 | Floor transition spawn outside map | Medium |
| 7 | T053 | Floor portal before boss killed | Medium |
