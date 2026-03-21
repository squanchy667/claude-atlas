# Agreement — T035: Dog Roster & Role Assignment UI

**Status:** APPROVED
**Approved:** 2026-03-20

## Scope
Create the dog roster Canvas UI overlay for viewing rescued dogs, selecting dogs, assigning roles, seeing role effects, and starting dungeon runs. Modify KennelManager for UI integration.

## Checkpoint Parameters
- DogRosterUI Canvas overlay toggled with Tab or E
- Scrollable dog list showing name, breed, role, happiness per dog
- Click-to-select with visual highlight
- Role assignment dropdown (None, Guard, Forager, Builder) calling MetaProgressionManager.AssignRole()
- Role effect descriptions displayed
- "Start Run" button triggering scene transition
- Player movement disabled when UI is open

## Out of Scope
- Building interaction UI (T036)
- Scene transition implementation (T037) — this task only fires the event
- Happiness gameplay effects (future phase)
- Dog dismissal/release mechanic (future phase)

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
