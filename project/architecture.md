# Architecture — [PROJECT_NAME]

<!-- Fill during /atlas-setup or Phase 1 planning -->

## System Diagram

<!-- Replace with ASCII art or a link to an image showing the high-level system topology. -->

```
[SYSTEM_DIAGRAM]

Example structure:

  ┌──────────┐     ┌──────────┐     ┌──────────┐
  │  Client   │────▶│  Server   │────▶│ Database  │
  └──────────┘     └──────────┘     └──────────┘
                         │
                    ┌────▼────┐
                    │ External │
                    │ Service  │
                    └─────────┘
```

## Tech Stack

| Layer | Technology | Version | Reason |
|-------|-----------|---------|--------|
| [LAYER] | [TECH] | [VERSION] | [WHY_THIS_OVER_ALTERNATIVES] |
| [LAYER] | [TECH] | [VERSION] | [WHY_THIS_OVER_ALTERNATIVES] |
| [LAYER] | [TECH] | [VERSION] | [WHY_THIS_OVER_ALTERNATIVES] |
| [LAYER] | [TECH] | [VERSION] | [WHY_THIS_OVER_ALTERNATIVES] |
| [LAYER] | [TECH] | [VERSION] | [WHY_THIS_OVER_ALTERNATIVES] |

## Core Modules

<!-- One section per module. A module is a logical boundary — a package, a service, a major directory. -->

### [MODULE_1_NAME]

- **Responsibility:** [WHAT_IT_DOES — single sentence]
- **Boundaries:** [WHAT_IT_OWNS and WHAT_IT_DOES_NOT_TOUCH]
- **Key files:** [PRIMARY_FILES_OR_DIRECTORIES]
- **Public interface:** [EXPORTED_FUNCTIONS_CLASSES_OR_ENDPOINTS]
- **Depends on:** [OTHER_MODULES_IT_IMPORTS_FROM]

### [MODULE_2_NAME]

- **Responsibility:** [WHAT_IT_DOES]
- **Boundaries:** [WHAT_IT_OWNS and WHAT_IT_DOES_NOT_TOUCH]
- **Key files:** [PRIMARY_FILES_OR_DIRECTORIES]
- **Public interface:** [EXPORTED_FUNCTIONS_CLASSES_OR_ENDPOINTS]
- **Depends on:** [OTHER_MODULES_IT_IMPORTS_FROM]

### [MODULE_N_NAME]

- **Responsibility:** [WHAT_IT_DOES]
- **Boundaries:** [WHAT_IT_OWNS and WHAT_IT_DOES_NOT_TOUCH]
- **Key files:** [PRIMARY_FILES_OR_DIRECTORIES]
- **Public interface:** [EXPORTED_FUNCTIONS_CLASSES_OR_ENDPOINTS]
- **Depends on:** [OTHER_MODULES_IT_IMPORTS_FROM]

## Data Flow — Primary Use Case

<!-- Trace the most common user action through the system, step by step. -->

```
1. [USER_ACTION]
2. [COMPONENT] receives [WHAT] and [DOES_WHAT]
3. [COMPONENT] calls [COMPONENT] with [WHAT]
4. [COMPONENT] returns [WHAT] to [COMPONENT]
5. [USER_SEES]
```

## Architectural Rules

<!-- Hard constraints that Claude must never violate during implementation. These are not suggestions — they are laws. -->

1. [RULE — e.g., "All database access goes through the repository layer. No raw queries in route handlers."]
2. [RULE — e.g., "No circular dependencies between modules."]
3. [RULE — e.g., "All external HTTP calls go through src/lib/http-client.ts."]
4. [RULE]
5. [RULE]

## Scalability Assumptions

<!-- What load is this designed for? What breaks first if traffic doubles? -->

- Expected scale: [USERS / REQUESTS / DATA_VOLUME]
- Designed ceiling: [MAX_BEFORE_REARCHITECTURE]
- First bottleneck: [WHAT_BREAKS_FIRST_AND_WHY]
- Scaling strategy: [HORIZONTAL / VERTICAL / NOT_APPLICABLE_AND_WHY]

## Security Posture

- **Authentication:** [METHOD — e.g., JWT, session cookies, API keys, none]
- **Authorization:** [MODEL — e.g., RBAC, ownership-based, none]
- **Secrets management:** [WHERE_SECRETS_LIVE — e.g., .env (local), AWS Secrets Manager (prod)]
- **Data sensitivity:** [LEVEL — e.g., PII, financial, public only]
- **Network:** [EXPOSURE — e.g., public API, internal only, localhost only]
