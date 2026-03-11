# Skill: Error Handling

**Tier:** Foundation
**Category:** Error Handling
**Created:** Marketplace
**Status:** Active
**Times Used:** 0

## What This Skill Solves
Inconsistent error handling leads to swallowed errors, unhelpful error messages, and debugging nightmares. This skill establishes a single approach to catching, wrapping, propagating, and reporting errors.

## The Approach
Errors are first-class citizens. Catch at boundaries, wrap with context, propagate up, handle at the top. Never swallow. Never log-and-continue without reason.

## When to Use This
- Any project with more than one module
- When debugging is taking too long because errors are unclear
- When setting up error handling patterns for a new service

## When NOT to Use This
- Scripts and one-off tools — a try/catch at the top with console.error is sufficient
- Performance-critical hot paths where exception overhead matters (use result types instead)

## Steps
1. **Define error types** for your domain. At minimum: `ValidationError`, `NotFoundError`, `AuthError`, `ExternalServiceError`, `InternalError`.
2. **Catch at boundaries**: API route handlers, event handlers, queue consumers, CLI entry points. Not inside business logic.
3. **Wrap with context** when re-throwing: add what operation was happening, what entity was involved, what input caused it.
4. **Never catch and ignore.** If you catch, you must: log, rethrow, or handle with a defined fallback.
5. **Error responses are consistent.** Every API error returns: `{ error: { code: string, message: string, details?: object } }` with appropriate HTTP status.
6. **Log errors with structured data**: timestamp, error type, message, stack, request ID, user ID, operation. Not just `console.error(e)`.
7. **External service errors get wrapped** in your error types. The caller should not know which third-party failed — only that the operation failed.
8. **Validation errors are not exceptions.** Return them as values. They are expected input, not exceptional conditions.
9. **Unhandled rejection handler** as safety net. Log, alert, do not crash silently.
10. **Test error paths.** Every catch block needs a test that triggers it.

## Example
```typescript
// Domain error types
class AppError extends Error {
  constructor(message: string, public code: string, public statusCode: number, public details?: unknown) {
    super(message);
    this.name = 'AppError';
  }
}

class NotFoundError extends AppError {
  constructor(entity: string, id: string) {
    super(`${entity} not found: ${id}`, 'NOT_FOUND', 404);
  }
}

// Wrapping external errors
async function getUser(id: string) {
  try {
    return await db.users.findUnique({ where: { id } });
  } catch (err) {
    throw new AppError(`Failed to fetch user ${id}`, 'DB_ERROR', 500, { original: err.message });
  }
}

// Handling at boundary
app.get('/api/users/:id', async (req, res, next) => {
  try {
    const user = await getUser(req.params.id);
    if (!user) throw new NotFoundError('User', req.params.id);
    res.json(user);
  } catch (err) {
    next(err); // Central error middleware handles response
  }
});
```

## Gotchas
- `catch (e) { throw e }` is pointless. Either add context or don't catch.
- Logging the same error at multiple levels creates noise. Log once at the boundary.
- Stack traces from async code can be unhelpful. The context you wrap with IS the debugging info.
- TypeScript catch blocks give `unknown` type — always narrow before accessing properties.

## Related Skills
- logging-observability — structured logging for errors
- input-validation — validation errors are a special case
- testing-strategy — test error paths
