# Drift Log — T003: Input System Setup

## DRIFT-002: WASD composite missing type — NullReferenceException at runtime
- **Date**: 2026-03-11
- **Severity**: High
- **Issue**: WASD composite binding had `"path": ""` instead of `"path": "2DVector"`. Unity Input System threw NullReferenceException in InputBindingResolver when trying to resolve the binding, making input completely non-functional.
- **Fix applied**: Set composite path to `"2DVector"`.
- **Impact**: Input system crashed on enable. Player could not move. Third compilation/runtime issue encountered during Phase 1 first run.
- **Root cause**: .inputactions JSON was hand-authored without Unity validation. Composite bindings require a type identifier in the path field.

## DRIFT-001: Ability gamepad binding changed
- **Date**: 2026-03-11
- **Severity**: Low
- **Agreed**: Ability action bound to `<Gamepad>/buttonEast` (East/B button)
- **Actual**: Ability action bound to `<Gamepad>/rightTrigger` (Right Trigger)
- **Reason**: Likely chosen for ergonomic reasons — right trigger is common for ability activation in action games. However, this was not discussed or approved.
- **Impact**: Gamepad players will use Right Trigger for abilities instead of B button. No functional impact on Phase 1 (Ability action is not consumed by any Phase 1 script).
- **Resolution**: APPROVED — keeping Right Trigger per human decision (2026-03-12).
