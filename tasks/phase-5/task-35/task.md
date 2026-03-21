# [T035] Dog Roster & Role Assignment UI

**Phase:** 5
**Status:** PENDING
**Complexity:** High
**Estimated Scope:** 2 files, ~350 lines

## Objective
Create the dog roster Canvas UI overlay for the Kennel scene. Players can view all rescued dogs, select individual dogs, assign roles, and start a new dungeon run. The UI shows role effects and provides the primary interaction point for dog management.

## Deliverables
- `DogRosterUI` Canvas overlay toggled with Tab or E key
- Dog list: shows all rescued dogs with name, breed, role, happiness
- Dog selection: click a dog entry to select it
- Role assignment: dropdown with None, Guard, Forager, Builder options
- Role effect descriptions: Guards boost damage, Foragers generate income, Builders speed construction
- "Start Run" button at bottom to begin next dungeon run
- KennelManager modifications to support UI integration

## Files Likely Touched
- `Scripts/UI/DogRosterUI.cs` — new Canvas UI controller
- `Scripts/Kennel/KennelManager.cs` — modify to support UI toggling and run start

## Dependencies
- Depends On: T032, T033, T034
- Blocks: T038

## Acceptance Criteria
- [ ] Pressing Tab or E toggles the dog roster UI overlay
- [ ] UI shows a scrollable list of all rescued dogs from MetaProgressionManager
- [ ] Each dog entry displays: name, breed (color indicator), current role, happiness value
- [ ] Clicking a dog entry selects it (visual highlight)
- [ ] Selected dog shows a role dropdown with None, Guard, Forager, Builder
- [ ] Changing role calls MetaProgressionManager.AssignRole() and updates display
- [ ] Role effect descriptions visible: Guard (+damage), Forager (+income), Builder (+construction)
- [ ] "Start Run" button at bottom triggers scene transition to character select/dungeon
- [ ] UI disables player movement when open
- [ ] UI updates dynamically when dogs are added or roles changed

## Notes
- Use Canvas with ScreenSpace-Overlay render mode
- Dog list items instantiated from a prefab template
- Role dropdown uses Unity UI Dropdown component
- "Start Run" button fires a GameEvent that SceneTransitionManager listens to
- Happiness is display-only for now (no gameplay effect until future phase)
