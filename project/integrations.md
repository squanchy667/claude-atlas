# Integrations — [PROJECT_NAME]

<!-- Fill during /atlas-setup or Phase 1 planning. Update as dependencies change. -->

## External Services

| Service | Purpose | Auth Method | Credentials Location | Rate Limits | Fallback | SDK | Adapter Location |
|---------|---------|-------------|---------------------|-------------|----------|-----|-----------------|
| [SERVICE] | [WHAT_IT_DOES_FOR_US] | [API_KEY / OAUTH / JWT / NONE] | [WHERE_CREDS_LIVE] | [LIMITS] | [WHAT_HAPPENS_IF_DOWN] | [PACKAGE_NAME] | [FILE_PATH] |
| [SERVICE] | [WHAT_IT_DOES_FOR_US] | [AUTH_METHOD] | [WHERE_CREDS_LIVE] | [LIMITS] | [WHAT_HAPPENS_IF_DOWN] | [PACKAGE_NAME] | [FILE_PATH] |

## Production Dependencies

| Package | Version | Purpose | Replacement Option |
|---------|---------|---------|-------------------|
| [PACKAGE] | [VERSION] | [WHY_WE_NEED_IT] | [ALTERNATIVE_IF_DEPRECATED] |
| [PACKAGE] | [VERSION] | [WHY_WE_NEED_IT] | [ALTERNATIVE_IF_DEPRECATED] |
| [PACKAGE] | [VERSION] | [WHY_WE_NEED_IT] | [ALTERNATIVE_IF_DEPRECATED] |

## Dev Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| [PACKAGE] | [VERSION] | [WHY_WE_NEED_IT] |
| [PACKAGE] | [VERSION] | [WHY_WE_NEED_IT] |
| [PACKAGE] | [VERSION] | [WHY_WE_NEED_IT] |

## Environment Variables

| Name | Required | Default | Description |
|------|----------|---------|-------------|
| [VAR_NAME] | [YES/NO] | [DEFAULT_OR_NONE] | [WHAT_IT_CONTROLS] |
| [VAR_NAME] | [YES/NO] | [DEFAULT_OR_NONE] | [WHAT_IT_CONTROLS] |
| [VAR_NAME] | [YES/NO] | [DEFAULT_OR_NONE] | [WHAT_IT_CONTROLS] |

## Dependency Rules

<!-- Hard rules for how external calls are managed. These prevent scattered integration logic. -->

1. [RULE — e.g., "All HTTP calls to external services go through src/lib/http-client.ts with retry and timeout."]
2. [RULE — e.g., "No direct SDK imports in route handlers. All external service access goes through adapter modules."]
3. [RULE — e.g., "Every external service must have a fallback behavior defined. No silent failures."]
4. [RULE]
