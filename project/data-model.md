# Data Model — [PROJECT_NAME]

<!-- Fill during Phase 1 or architecture planning. Update whenever entities change. -->

## Entities

<!-- One section per entity. An entity is anything that gets persisted — database table, document, config object, file on disk. -->

### [ENTITY_1_NAME]

| Field | Type | Required | Description | Constraints |
|-------|------|----------|-------------|-------------|
| [FIELD] | [TYPE] | [YES/NO] | [WHAT_IT_REPRESENTS] | [VALIDATION_RULES — e.g., unique, min 1, max 255, enum values] |
| [FIELD] | [TYPE] | [YES/NO] | [WHAT_IT_REPRESENTS] | [VALIDATION_RULES] |
| [FIELD] | [TYPE] | [YES/NO] | [WHAT_IT_REPRESENTS] | [VALIDATION_RULES] |

### [ENTITY_2_NAME]

| Field | Type | Required | Description | Constraints |
|-------|------|----------|-------------|-------------|
| [FIELD] | [TYPE] | [YES/NO] | [WHAT_IT_REPRESENTS] | [VALIDATION_RULES] |
| [FIELD] | [TYPE] | [YES/NO] | [WHAT_IT_REPRESENTS] | [VALIDATION_RULES] |
| [FIELD] | [TYPE] | [YES/NO] | [WHAT_IT_REPRESENTS] | [VALIDATION_RULES] |

### [ENTITY_N_NAME]

| Field | Type | Required | Description | Constraints |
|-------|------|----------|-------------|-------------|
| [FIELD] | [TYPE] | [YES/NO] | [WHAT_IT_REPRESENTS] | [VALIDATION_RULES] |
| [FIELD] | [TYPE] | [YES/NO] | [WHAT_IT_REPRESENTS] | [VALIDATION_RULES] |

## Relationships

<!-- How entities connect to each other. -->

| From | To | Type | Description |
|------|----|------|-------------|
| [ENTITY] | [ENTITY] | [1:1 / 1:N / N:M] | [WHAT_THE_RELATIONSHIP_MEANS] |
| [ENTITY] | [ENTITY] | [1:1 / 1:N / N:M] | [WHAT_THE_RELATIONSHIP_MEANS] |
| [ENTITY] | [ENTITY] | [1:1 / 1:N / N:M] | [WHAT_THE_RELATIONSHIP_MEANS] |

## Entity Relationship Diagram

<!-- Replace with ASCII art or link to diagram. -->

```
[ER_DIAGRAM]

Example:

  ┌────────────┐       ┌────────────┐
  │    User     │──1:N──│   Project   │
  └────────────┘       └────────────┘
                             │
                            1:N
                             │
                       ┌────────────┐
                       │    Task     │
                       └────────────┘
```

## Invariants

<!-- Rules that must always be true about the data. If any of these are violated, the system is in a broken state. -->

1. [INVARIANT — e.g., "Every Task belongs to exactly one Project. Orphan tasks must not exist."]
2. [INVARIANT — e.g., "A User's email is unique across the entire system."]
3. [INVARIANT — e.g., "A Project's task count field always equals the actual number of related tasks."]
4. [INVARIANT]

## Migration Log

<!-- Track every schema change after initial creation. -->

| Date | Change | Reason | Approved By |
|------|--------|--------|-------------|
| [DATE] | [WHAT_CHANGED — e.g., "Added `archived` boolean to Project"] | [WHY] | [NAME] |
| [DATE] | [WHAT_CHANGED] | [WHY] | [NAME] |
