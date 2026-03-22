# Phase 7 — Polish & UI

## Tasks

| ID | Task | Complexity | Status | Depends On | Blocks |
|----|------|-----------|--------|------------|--------|
| T046 | Main Menu Scene | Medium | PENDING | None | T053 |
| T047 | Pause Menu | Low | PENDING | None | T053 |
| T048 | Audio System (SFX + Music) | High | PENDING | None | T053 |
| T049 | Screen Transitions (Fade) | Medium | PENDING | None | T053 |
| T050 | Particle Effects | Medium | PENDING | None | T052, T053 |
| T051 | Difficulty Scaling (AnimationCurve) | Medium | PENDING | None | T053 |
| T052 | Game Feel Pass | Medium | PENDING | T050 | T053 |
| T053 | Phase 7 Integration Test | Medium | PENDING | T046-T052 | None |

## Execution Strategy

**Parallel batch 1** (6 independent tasks): T046, T047, T048, T049, T050, T051
**Parallel batch 2** (1 task, depends on T050): T052
**Sequential final** (depends on all): T053

## Files Created/Modified

| Task | New Files | Modified Files |
|------|-----------|----------------|
| T046 | Scripts/UI/MainMenuUI.cs | Editor/SceneSetup.cs |
| T047 | Scripts/UI/PauseMenuUI.cs | — |
| T048 | Scripts/Audio/AudioManager.cs, Scripts/Audio/SoundBank.cs | — |
| T049 | Scripts/UI/ScreenFade.cs | Scripts/Core/SceneTransitionManager.cs |
| T050 | Scripts/Effects/ParticleManager.cs | — |
| T051 | Scripts/Core/DifficultyConfig.cs | Scripts/Dungeon/RoomController.cs |
| T052 | Scripts/Effects/AfterimageEffect.cs | Scripts/Camera/CameraController.cs |
| T053 | — | Bug fixes across T046-T052 files |
