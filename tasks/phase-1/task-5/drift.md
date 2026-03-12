# Drift Log — T005: Dodge Roll System

## DRIFT-001: I-frames use boolean flag instead of Physics2D layer collision
- **Date**: 2026-03-11
- **Severity**: Medium
- **Agreed**: I-frame system using Physics2D layer collision matrix changes (temporarily ignore enemy damage layer)
- **Actual**: I-frame system using `PlayerController.IsInvincible` boolean flag
- **Reason**: Layer collision matrix approach requires: (1) defining enemy/damage layers upfront, (2) modifying collision matrix at runtime which affects all objects on those layers, (3) careful restoration even on interruption. The boolean flag approach is simpler, delegates damage-checking responsibility to the combat system (Phase 2), and is safer against edge cases.
- **Impact**: The combat system (Phase 2) must check `IsInvincible` before applying damage. This is a lighter coupling than layer-based collision. If physics-based damage detection is needed (e.g., OnCollisionEnter2D auto-damage), the layer approach would need to be added then.
- **Resolution**: APPROVED — keeping boolean flag per human decision (2026-03-12). Phase 2 combat will check `IsInvincible`.
