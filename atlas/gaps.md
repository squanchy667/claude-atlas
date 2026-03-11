# Gaps -- Known Unknowns

This is a living document. It tracks everything that is unknown, unresolved, or deliberately deferred. Every gap gets an ID, a source, and a resolution plan.

Gaps are created during `/atlas-setup` (from unanswered questions and known risks), during task execution (when unknowns emerge), and during `/complete-phase` (from gap reports).

---

## Format

Each gap follows this structure:

```
### GAP-XXX: [Short title]

- **What is unknown**: [Clear description of what we do not know]
- **Source**: [setup-unanswered | emerged-during-work | deliberate-deferral]
- **Discovered**: [Date or phase/task reference]
- **Impact**: [What is blocked or degraded by this gap]
- **Resolution plan**: [How and when this will be resolved]
- **Status**: [open | in-progress | resolved]
- **Resolution**: [Filled when resolved. What was decided and why.]
```

---

## Gaps

<!-- Example gap for reference. Remove or replace with real gaps during /atlas-setup.

### GAP-001: Database selection not finalized

- **What is unknown**: Whether the project will use PostgreSQL or SQLite for local development and whether the production database will be managed (RDS) or self-hosted.
- **Source**: setup-unanswered
- **Discovered**: Setup conversation
- **Impact**: Data model design and migration strategy depend on this choice. Blocks detailed Phase 2 planning.
- **Resolution plan**: Evaluate query complexity and expected data volume during Phase 1. Decide before Phase 2 planning begins.
- **Status**: open
- **Resolution**: --

-->

<!-- Add gaps below this line -->
