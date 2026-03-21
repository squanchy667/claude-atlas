# Agreement — T039: PlayerInputManager & P2 Join Flow

**Status:** APPROVED
**Approved:** 2026-03-20

## Scope
Add PlayerInputManager-based co-op join/leave system. Create CoopManager singleton that handles P2 joining (any controller button or Enter), spawning P2 at P1's position with a separate PlayerInput/control scheme, firing PlayerSpawned for camera tracking, and P2 leaving via Select/Back. Modify PlayerController for multi-player awareness. Solo play must remain completely unaffected.

## Checkpoint Parameters
- CoopManager singleton with PlayerInputManager for join/leave management
- P2 join via any controller button or Enter key, spawn at P1 position
- P2 gets own PlayerInput with separate control scheme
- PlayerSpawned event fires for P2 (camera auto-tracks)
- P2 leave via Select/Back button
- CoopManager.IsCoopActive property
- PlayerController knows its player index
- Solo play unaffected

## Out of Scope
- Co-op character selection UI (T040)
- Camera leash/zoom tuning (T041)
- Co-op UI elements (T042)
- Enemy scaling (T043)
- Revive mechanic (T044)

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
