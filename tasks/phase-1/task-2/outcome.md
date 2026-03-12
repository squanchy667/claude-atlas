# Outcome — T002: Core Framework (Singleton + GameEvents)
## Status: DONE
## Completed: 2026-03-11

## What Was Built
Core framework with generic Singleton<T> base class, GameEvents static event bus, GameManager singleton, and GameState enum. All placed in `Assets/Scripts/Core/` under the `DogPack.Core` namespace.

## Files Created/Changed
- `Assets/Scripts/Core/Singleton.cs` — Generic Singleton<T> with DontDestroyOnLoad, duplicate prevention, Instance property, OnDestroy cleanup
- `Assets/Scripts/Core/GameEvents.cs` — Static event bus with 14 events across 6 categories (Game State, Player, Combat, Run, Room, Resources, Camera) plus ClearAll() method
- `Assets/Scripts/Core/GameManager.cs` — Singleton with GameState machine, state transitions, pause/resume/toggle, fires OnGameStateChanged, DefaultExecutionOrder(-100)
- `Assets/Scripts/Core/GameState.cs` — Enum: Menu, CharacterSelect, Playing, Paused, GameOver, Victory, Kennel

## Tests Added
- None (core framework — tested implicitly by dependent tasks)

## Deviations From Agreement
- **Singleton<T> did not compile on first try**: `(T)this` cast is invalid in C# generics — caused CS0030 error on Unity import. Fixed to `this as T`. Project did not run on first open.
- **GameState enum expanded**: Agreement specified 5 states (Menu, Playing, Paused, GameOver, Victory). Implementation has 7 states — added `CharacterSelect` and `Kennel` for forward compatibility. No states were removed.
- **GameEvents expanded**: Agreement specified "at least 5" events. Implementation has 14 events covering all anticipated Phase 1-5 needs. This exceeds but does not violate the agreement.

## Checkpoint Parameters Verification
- [x] Singleton<T> compiles and provides static Instance access with null safety
- [x] GameEvents has 14 declared events (exceeds minimum of 5) with public static invoke methods
- [x] GameManager initializes to Menu state (then transitions to Playing for test scene)
- [x] State transitions fire OnGameStateChanged
- [x] No compilation errors across all four files
- [x] Files are in the correct directory (Assets/Scripts/Core/)
