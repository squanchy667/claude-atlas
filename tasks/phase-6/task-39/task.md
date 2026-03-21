# [T039] PlayerInputManager & P2 Join Flow

**Phase:** 6
**Status:** PENDING
**Complexity:** High
**Estimated Scope:** 2 files, ~300 lines

## Objective
Add Unity's PlayerInputManager to handle multi-player input joining. P2 presses any button on a controller (or a specific key like Enter) to join. Spawn P2 player instance from the same prefab at P1's position. P2 gets its own PlayerInput component with a separate control scheme. P2 player fires PlayerSpawned event so the camera auto-tracks. P2 can leave by pressing Select/Back. Solo play remains completely unaffected — P2 simply doesn't join.

## Deliverables
- `CoopManager` singleton that wraps PlayerInputManager join/leave logic
- P2 join flow: press any controller button or Enter key to join
- P2 spawn at P1 position using the same player prefab
- P2 gets own PlayerInput with separate control scheme
- PlayerSpawned event fired for P2 (camera auto-tracks)
- P2 leave flow: press Select/Back to leave
- Solo play unaffected when P2 is absent

## Files Likely Touched
- `Scripts/Core/CoopManager.cs` — new singleton managing co-op state
- `Scripts/Player/PlayerController.cs` — modify for multi-player awareness

## Dependencies
- Depends On: None
- Blocks: T040, T041, T042, T043, T044

## Acceptance Criteria
- [ ] CoopManager singleton exists and tracks active player count
- [ ] PlayerInputManager is configured on CoopManager for join/leave
- [ ] P2 can join by pressing any controller button or Enter key
- [ ] P2 spawns at P1's current position using the same player prefab
- [ ] P2 has its own PlayerInput component with a separate control scheme
- [ ] PlayerSpawned event fires for P2 so CameraController auto-tracks
- [ ] P2 can leave by pressing Select/Back button
- [ ] CoopManager.IsCoopActive returns true when 2 players are present
- [ ] Solo play works identically when P2 has not joined
- [ ] PlayerController handles multi-player awareness (knows which player index it is)

## Notes
- Uses Unity's built-in PlayerInputManager component for join/leave management
- CoopManager follows the Singleton pattern consistent with other managers (GameManager, etc.)
- PlayerSpawned event already exists in GameEvents — reuse it for P2
