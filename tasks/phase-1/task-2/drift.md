# Drift Log — T002: Core Framework

## DRIFT-001: Singleton<T> did not compile on first try
- **Date**: 2026-03-11
- **Severity**: High
- **Issue**: `Instance = (T)this;` on line 22 causes `CS0030: Cannot convert type 'Singleton<T>' to 'T'`. C# does not allow direct cast from a generic base type to its type parameter.
- **Fix applied**: Changed to `Instance = this as T;` which uses a safe cast and compiles correctly.
- **Impact**: Project did not compile on first Unity import. Required a code fix before any testing could happen.
- **Root cause**: Code was written without Unity compilation verification. The `as` pattern is the standard approach for generic singleton base classes in Unity.
