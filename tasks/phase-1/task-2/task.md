# T002: Core Framework (Singleton + GameEvents)
## Phase: 1 — Foundation
## Status: PENDING
## Depends On: T001
## Blocks: T004, T005, T006, T007

## Description
Create the core framework scripts that all other systems will depend on. This includes a generic Singleton base class, a centralized GameEvents static class for decoupled communication, and a GameManager singleton that owns the game state machine.

### Singleton<T>
A reusable `MonoBehaviour`-based singleton pattern:
- Generic `Singleton<T>` base class where `T : MonoBehaviour`
- Handles `DontDestroyOnLoad` persistence
- Prevents duplicate instances (destroys extras)
- Provides a static `Instance` property with lazy initialization

### GameEvents
A static class providing C# events/actions for decoupled system communication:
- Phase 1 event structure (events will be added as systems are built)
- Initial events: `OnGameStateChanged`, `OnPlayerSpawned`, `OnPlayerDied`, `OnRoomEntered`, `OnRoomCleared`
- Static invoke methods for each event
- Clear/reset method for cleaning up subscriptions between runs

### GameManager
A singleton (`Singleton<T>` derived) that manages the top-level game state:
- `GameState` enum: `Menu`, `Playing`, `Paused`, `GameOver`, `Victory`
- State transition methods with validation
- Fires `GameEvents.OnGameStateChanged` on every transition
- Initializes to `Menu` state on startup

## Deliverables
- `Assets/Scripts/Core/Singleton.cs` — Generic singleton base class
- `Assets/Scripts/Core/GameEvents.cs` — Static event bus
- `Assets/Scripts/Core/GameManager.cs` — Game state singleton
- `Assets/Scripts/Core/GameState.cs` — GameState enum (or nested in GameManager)

## Acceptance Criteria
- `Singleton<T>` compiles without errors and enforces single-instance behavior
- `GameEvents` has public static events and corresponding invoke methods
- `GameManager` inherits from `Singleton<GameManager>` and initializes to `Menu` state
- State transitions fire `OnGameStateChanged` with old and new state
- All scripts are in the correct `Assets/Scripts/Core/` directory
- Code follows C# Unity conventions (namespaces, access modifiers, XML doc comments)
