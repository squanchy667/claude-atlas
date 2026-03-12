# T001: Project Setup & Repository Init
## Phase: 1 — Foundation
## Status: PENDING
## Depends On: none
## Blocks: T002, T003

## Description
Create the Unity project code repository at `/Users/ofek/Projects/Claude/AtlasTest/CultRoguelite/cultrougelite/`, set up the full folder structure, configure version control files, and define the initial package manifest.

The folder structure must include:
- `Assets/Scripts/Core`, `Assets/Scripts/Player`, `Assets/Scripts/Combat`, `Assets/Scripts/Enemies`, `Assets/Scripts/Dungeon`, `Assets/Scripts/Kennel`, `Assets/Scripts/Camera`, `Assets/Scripts/UI`, `Assets/Scripts/Utils`
- `Assets/ScriptableObjects/Characters`, `Assets/ScriptableObjects/Weapons`, `Assets/ScriptableObjects/Enemies`, `Assets/ScriptableObjects/Rooms`, `Assets/ScriptableObjects/Upgrades`, `Assets/ScriptableObjects/Audio`
- `Assets/Prefabs/Player`, `Assets/Prefabs/Enemies`, `Assets/Prefabs/Weapons`, `Assets/Prefabs/Rooms`, `Assets/Prefabs/UI`, `Assets/Prefabs/Effects`
- `Assets/Scenes`
- `Assets/Art/Sprites`, `Assets/Art/Tilemaps`, `Assets/Art/UI`
- `Assets/Audio/SFX`, `Assets/Audio/Music`
- `Assets/Animations/Player`, `Assets/Animations/Enemies`, `Assets/Animations/UI`
- `Assets/Editor`
- `Assets/Settings`

Version control and package configuration:
- `.gitignore` tailored for Unity projects
- `.gitattributes` for Unity asset handling (LFS rules, merge strategies)
- `Packages/manifest.json` with required packages: `com.unity.inputsystem`, `com.unity.2d.animation`, `com.unity.2d.tilemap`, `com.unity.2d.tilemap.extras`

## Deliverables
- Initialized git repository at the target path
- Complete directory tree with all listed folders
- `.gitignore` covering Unity-specific files (Library/, Temp/, Logs/, obj/, Build/, etc.)
- `.gitattributes` with Unity merge and LFS rules
- `Packages/manifest.json` with the four required packages and their versions
- Initial commit with the project skeleton

## Acceptance Criteria
- All directories listed above exist in the repository
- `.gitignore` correctly excludes Unity build/cache directories
- `.gitattributes` is present and contains Unity-relevant rules
- `Packages/manifest.json` is valid JSON and includes all four required packages
- Repository has a clean git status after initial commit
