# Agreement — T002: Core Framework (Singleton + GameEvents)
## Status: APPROVED
## Approved: 2026-03-11 (auto-approved by atlas-run --full-permission)

## Scope
- Create `Singleton<T>` generic base class with DontDestroyOnLoad, duplicate prevention, and lazy Instance property
- Create `GameEvents` static class with Phase 1 events (OnGameStateChanged, OnPlayerSpawned, OnPlayerDied, OnRoomEntered, OnRoomCleared) and invoke/reset methods
- Create `GameManager` singleton with GameState enum (Menu, Playing, Paused, GameOver, Victory) and state transition logic
- All files placed in `Assets/Scripts/Core/`

## Not In Scope
- Events for systems built in later tasks (combat, kennel, upgrades) — those will be added when their tasks are executed
- Save/load functionality
- Scene management or loading logic
- UI integration

## Checkpoint Parameters
- `Singleton<T>` compiles and provides static Instance access with null safety
- `GameEvents` has at least 5 declared events with public static invoke methods
- `GameManager` initializes to Menu state and transitions fire OnGameStateChanged
- No compilation errors across all three/four files
- Files are in the correct directory (`Assets/Scripts/Core/`)

## Skills Used
- Unity C# singleton pattern
- C# event/delegate patterns
- Game state machine design

## Risks
- Singleton lifecycle edge cases (scene reloads, application quit) need careful handling
- Event subscription cleanup is critical to avoid memory leaks between runs
