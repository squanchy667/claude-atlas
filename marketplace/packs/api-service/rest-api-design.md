# Skill: REST API Design

**Tier:** Foundation
**Category:** Architecture
**Created:** Marketplace
**Status:** Active
**Times Used:** 0

## What This Skill Solves
Inconsistent API design creates confusion for consumers: different naming conventions across endpoints, unpredictable error responses, misused status codes, and breaking changes deployed without versioning. This skill provides conventions that make APIs predictable, self-documenting, and maintainable across team members and time.

## The Approach
Resources are nouns, actions are HTTP methods. Responses have a consistent shape. Status codes mean what the HTTP spec says they mean. Cursor-based pagination over offset. Breaking changes get a new version prefix. HATEOAS is skipped unless your API is truly public infrastructure.

## When to Use This
- Designing a new REST API from scratch
- Standardizing an existing API that has grown inconsistent
- When frontend developers complain about unpredictable responses or spend time reading docs for every endpoint

## When NOT to Use This
- GraphQL APIs -- different conventions apply
- RPC-style APIs (gRPC, tRPC) -- use their native patterns
- Internal microservice communication where a simpler contract (events, queues) is more appropriate

## Steps
1. **Resources are nouns, plural, kebab-case.** `/api/user-profiles`, `/api/order-items`. Not `/api/getUserProfile`, `/api/createOrder`, `/api/delete-product`. The HTTP method is the verb. Multi-word resources use kebab-case, not camelCase or snake_case.

2. **HTTP methods map to operations:**
   - `GET /users` -- list users (with filtering, pagination)
   - `GET /users/:id` -- get one user
   - `POST /users` -- create a user (request body contains data)
   - `PUT /users/:id` -- full replace (all fields required, omitted fields get defaults)
   - `PATCH /users/:id` -- partial update (only provided fields change)
   - `DELETE /users/:id` -- delete a user

3. **Nested resources for direct relationships, one level deep.** `GET /users/:id/orders` -- get orders belonging to a user. Never go deeper: not `/users/:id/orders/:orderId/items/:itemId`. Instead, use top-level resources with filters: `GET /order-items?orderId=abc`.

4. **Status codes that matter -- use exactly these:**
   - `200` -- Success with response body
   - `201` -- Created (POST success, include `Location` header with the new resource URL)
   - `204` -- Success with no body (DELETE, some PUT/PATCH)
   - `400` -- Bad request (malformed JSON, missing required fields, validation failure)
   - `401` -- Unauthenticated (no valid credentials provided)
   - `403` -- Forbidden (authenticated but not authorized for this action)
   - `404` -- Not found (resource does not exist)
   - `409` -- Conflict (duplicate entry, version conflict on update)
   - `422` -- Unprocessable entity (valid JSON, valid schema, but business logic rejects it)
   - `429` -- Too many requests (rate limited)
   - `500` -- Server error (never intentional -- always a bug)

5. **Consistent response shape.** Pick one and use it everywhere:
   - Envelope style: `{ data: T }` for single resources, `{ data: T[], meta: { nextCursor, hasMore } }` for lists, `{ error: { code, message, details } }` for errors.
   - Direct style: return the resource directly, errors in a consistent shape. Simpler but less extensible.
   - Whichever you pick, every endpoint follows the same shape. No exceptions.

6. **Pagination: prefer cursor-based.** Cursor-based pagination with `{ data, nextCursor, hasMore }` is stable under insertions and deletions -- page 2 does not shift when a new record is inserted on page 1. Offset-based (`?page=2&limit=20`) breaks when data changes between pages. Use cursor-based unless you have a compelling reason not to.

7. **Filtering and sorting via query params.** `?status=active&role=admin&sort=-createdAt` (prefix `-` for descending). Don't invent custom query languages or JSON-in-query-params. Multiple values for the same field: `?status=active&status=pending` or `?status=active,pending`. Keep it simple.

8. **Error responses are structured.** Every error returns: `{ error: { code: "VALIDATION_ERROR", message: "Name is required", details?: { fields: [...] } } }`. `code` is machine-readable (constant string for programmatic handling). `message` is human-readable. `details` provides context when needed.

9. **Versioning via URL prefix.** `/api/v1/users`. Increment only on breaking changes (removing fields, renaming fields, changing types, changing behavior). Additive changes (new optional fields, new endpoints) are NOT breaking. This is the simplest, most explicit versioning strategy.

10. **Rate limiting with headers.** Include `X-RateLimit-Limit`, `X-RateLimit-Remaining`, and `X-RateLimit-Reset` (Unix timestamp) on every response. Return `429` with `Retry-After` header (seconds) when exceeded. Different limits for authenticated vs anonymous users. Implement with Redis `INCR` + `EXPIRE` atomically, failing open if Redis is unavailable.

## Example
```
# List with cursor-based pagination and filtering
GET /api/v1/users?role=admin&sort=-createdAt&limit=20
-> 200
{
  "data": [
    { "id": "u_abc", "name": "Alice", "email": "alice@example.com", "role": "admin", "createdAt": "2024-01-15T10:30:00Z" },
    ...
  ],
  "meta": { "nextCursor": "eyJpZCI6InVfZGVmIn0", "hasMore": true }
}

# Next page
GET /api/v1/users?role=admin&sort=-createdAt&limit=20&cursor=eyJpZCI6InVfZGVmIn0
-> 200
{ "data": [...], "meta": { "nextCursor": null, "hasMore": false } }

# Create
POST /api/v1/users
Content-Type: application/json
{ "name": "Alice", "email": "alice@example.com", "role": "admin" }
-> 201
Location: /api/v1/users/u_abc
{ "data": { "id": "u_abc", "name": "Alice", "email": "alice@example.com", "role": "admin", "createdAt": "2024-01-15T10:30:00Z" } }

# Partial update
PATCH /api/v1/users/u_abc
{ "name": "Alice Smith" }
-> 200
{ "data": { "id": "u_abc", "name": "Alice Smith", "email": "alice@example.com", ... } }

# Validation error -- returns ALL errors, not just the first
POST /api/v1/users
{ "name": "", "email": "not-an-email" }
-> 400
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid input",
    "details": {
      "fields": [
        { "field": "name", "message": "Name is required" },
        { "field": "email", "message": "Invalid email format" }
      ]
    }
  }
}

# Rate limited
GET /api/v1/users
-> 429
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 0
X-RateLimit-Reset: 1705312800
Retry-After: 45
{ "error": { "code": "RATE_LIMITED", "message": "Too many requests. Retry after 45 seconds." } }

# Not found
GET /api/v1/users/u_999
-> 404
{ "error": { "code": "NOT_FOUND", "message": "User not found" } }

# Conflict (duplicate)
POST /api/v1/users
{ "name": "Alice", "email": "alice@example.com", "role": "admin" }
-> 409
{ "error": { "code": "DUPLICATE", "message": "A user with this email already exists" } }
```

## Gotchas
- `PUT` vs `PATCH`: most clients expect `PATCH` behavior (partial update). `PUT` replaces the entire resource -- omitted fields get defaults or are cleared. Clarify which you support and document it. Most apps only need `PATCH`.
- Don't return `200` for errors. A response `{ success: false, error: "..." }` with status `200` breaks every HTTP client's error handling, retry logic, and monitoring. Use proper status codes.
- `DELETE` should be idempotent. Deleting an already-deleted resource returns `204`, not `404`. The desired state (resource gone) is achieved regardless.
- HATEOAS (links in responses) is overkill for most applications. It adds complexity that only pays off for truly public APIs with many third-party consumers. Skip it unless you are building public infrastructure.
- Redis fail-open rate limiting: use `INCR` + `EXPIRE` atomically. If Redis is down, allow the request (fail open) rather than blocking all traffic. Rate limiting is a guardrail, not a gate.
- Avoid custom headers for standard things. Use `Authorization` for auth, `Content-Type` for format, `Accept` for content negotiation. Custom headers (`X-*`) are for custom metadata only.

## Related Skills
- input-validation -- validate request bodies at the boundary
- middleware-design -- request pipeline implements rate limiting, auth, validation
- logging-observability -- request/response logging and health endpoints
