# Drift Log — T004: Player Controller

## DRIFT-001: Movement uses linearVelocity instead of MovePosition
- **Date**: 2026-03-11
- **Severity**: Medium
- **Agreed**: Movement via `Rigidbody2D.MovePosition` in FixedUpdate
- **Actual**: Movement via `rb.linearVelocity = movement` in FixedUpdate
- **Reason**: linearVelocity provides smoother collision response — when hitting walls, the player slides along them naturally. MovePosition can cause the player to "stick" to walls when moving diagonally. linearVelocity is the more common pattern in modern Unity 2D games.
- **Impact**: Functionally equivalent for movement feel. Collision behavior is actually improved. The player will push against objects correctly if physics interactions are needed later. However, velocity-based movement means external forces (knockback, etc.) will interact differently.
- **Resolution**: APPROVED — keeping linearVelocity per human decision (2026-03-12).
