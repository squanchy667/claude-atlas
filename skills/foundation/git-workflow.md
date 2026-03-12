# Git Workflow

**Tier:** Foundation
**Category:** Workflow
**Created:** 2026-03-11
**Status:** Active

## What It Solves
Defines the Git branching strategy, commit conventions, and Unity-specific Git concerns for the project. Prevents merge conflicts on binary files and maintains clean history.

## Approach

### Branching Strategy
- `main` — stable, always builds. Only merged into via completed task branches.
- `feat/TXXX-task-name` — feature branches per task (e.g., `feat/T001-project-setup`)
- No long-lived develop branch. Tasks merge directly to main after checkpoint approval.

### Commit Convention
```
[Phase N] TXXX: Brief description

Optional longer explanation if needed.
```
Examples:
- `[Phase 1] T001: Set up Unity project with URP and Input System`
- `[Phase 2] T010: Implement weapon data ScriptableObject and 4 weapon types`

### Unity-Specific .gitignore
Ensure these are in `.gitignore`:
```
/[Ll]ibrary/
/[Tt]emp/
/[Oo]bj/
/[Bb]uild/
/[Bb]uilds/
/[Ll]ogs/
/[Uu]ser[Ss]ettings/
*.csproj
*.sln
*.suo
*.tmp
*.user
*.userprefs
*.pidb
*.booproj
*.svd
*.pdb
*.mdb
*.opendb
*.VC.db
*.pidb.meta
*.pdb.meta
*.mdb.meta
/Assets/Plugins/Editor/JetBrains*
Crashlytics/
```

### Unity-Specific Git Settings
- Force text serialization: Edit → Project Settings → Editor → Asset Serialization → Force Text
- Use `.gitattributes` for Unity YAML merge:
  ```
  *.unity merge=unityyamlmerge
  *.prefab merge=unityyamlmerge
  *.asset merge=unityyamlmerge
  ```
- Consider Git LFS for large binary assets (sprites, audio) if repo size grows

### Merge Strategy
- Always merge task branches via squash merge or regular merge (no rebase onto main for Unity projects — rebase on binary files causes pain)
- Resolve scene/prefab merge conflicts by re-applying changes in Editor, not by text-editing YAML

## When To Use
- Every commit
- Creating branches for tasks
- Resolving merge conflicts
- Setting up the initial repository

## When NOT To Use
- Docs repo (this repo) uses standard Git conventions, not Unity-specific ones

## Gotchas
- NEVER manually edit `.unity`, `.prefab`, or `.asset` files to resolve merge conflicts. Open in Unity Editor and re-apply changes.
- Unity generates `.meta` files for every asset. If you delete a file, delete its `.meta` too. If you add a file outside Unity, let Unity generate the `.meta` on next Editor open.
- Scene merge conflicts are the #1 source of pain in Unity Git projects. Minimize concurrent work on the same scene. Use prefabs and additive scene loading to reduce scene file changes.
- Large binary files (textures, audio) can bloat the repo. Set up Git LFS early if planning significant art assets.
