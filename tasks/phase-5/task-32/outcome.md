# Outcome — T032: MetaProgressionManager (Save/Load)

**Status:** DONE
**Date:** 2026-03-20

## What Was Built
Singleton manager that handles all meta-progression state: JSON-based save/load, resource banking between runs, dog roster management, upgrade tracking, and building state.

## Deliverables
- [x] MetaProgressionManager singleton with DontDestroyOnLoad
- [x] JSON save/load to Application.persistentDataPath
- [x] Resource banking (bones, treats, kibble)
- [x] Dog roster add/remove/query
- [x] Upgrade purchase and tier tracking
- [x] Building unlock and level tracking
- [x] Auto-save on application quit

## Files Changed
| File | Change |
|------|--------|
| Scripts/Core/MetaProgressionManager.cs | New singleton manager |

## Drift Events
None.
