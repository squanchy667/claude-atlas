# Drift Log — Cross-Task Patterns

> Individual drift lives in task folders. This file surfaces patterns across tasks. If the same deviation keeps happening, the project can course-correct based on data.

## Systemic Drift Patterns

<!-- Entry template:
### Drift-Pattern-[NNN]: [Description]
- **First seen:** Phase [N], Task [M]
- **Also seen in:** [List of tasks]
- **Pattern:** [What type of drift keeps happening]
- **Root cause hypothesis:** [Why this keeps recurring]
- **Proposed resolution:** New rule / New skill / Architecture change / Accepted as normal
- **Status:** Open / Addressed / Accepted
-->

### Drift-Pattern-001: Unity API behavior assumptions
- **First seen:** Phase 1, Task T004 (linearVelocity vs MovePosition)
- **Also seen in:** Phase 1 T003 (gamepad binding), Phase 1 T005 (i-frames approach), Phase 2 T010 (InputAction callback vs polling), Phase 2 T014 (OnEnable order, Image.Type.Filled)
- **Pattern:** Code is written based on how Unity APIs *should* work, but Unity's actual behavior differs — execution order, input callback reliability, UI rendering without sprites. Each time requires testing in Unity and rewriting the approach.
- **Root cause hypothesis:** Unity's documentation doesn't always cover edge cases. Programmatic scene setup (no prefabs/editor workflow) exposes more of these edges.
- **Proposed resolution:** Accepted as normal for programmatic Unity development. Mitigated by: (1) Pattern-001 (events in Start), (2) Pattern-002 (RectTransform for UI), (3) always test in Unity before marking tasks complete.
- **Status:** Accepted — documented patterns prevent repeat occurrences
