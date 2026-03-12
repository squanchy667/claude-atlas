# Drift Log — T007: Test Room & Editor Setup Scripts

## DRIFT-001: SceneSetup.cs did not compile on first try
- **Date**: 2026-03-11
- **Severity**: High
- **Issues**:
  1. `Collider2D.usedByComposite` is obsolete in Unity 6 — replaced with `compositeOperation = Collider2D.CompositeOperation.Merge`
  2. `File.Exists()` unresolved — missing `System.IO.` prefix (the `File_Exists` helper existed but wasn't used; raw `File` reference lacked namespace qualification)
- **Fix applied**: Both issues fixed. Deprecated API updated to Unity 6 equivalent, unqualified `File` reference fully qualified.
- **Impact**: Combined with T002 Singleton cast error, project required 2 rounds of fixes before compiling. Did not run on first Unity import.
- **Root cause**: Code written targeting Unity 2022.3 APIs but project uses Unity 6 which deprecated `usedByComposite`. The `File` issue is a simple namespace oversight.
