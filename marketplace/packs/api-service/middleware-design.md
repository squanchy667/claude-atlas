# Skill: Middleware Design

**Tier:** Foundation
**Category:** Architecture
**Created:** Marketplace
**Status:** Active
**Times Used:** 0

## What This Skill Solves
Cross-cutting concerns scattered through route handlers create duplication, inconsistency, and unmaintainable code. Authentication checked in some routes but not others. Logging in three different formats. Error handling that varies by endpoint. CORS configured differently per route. This skill provides a clean middleware pipeline where each concern is handled once, in the right order, with consistent behavior.

## The Approach
Build a request pipeline where each middleware does exactly one thing. Order is a contract: parse, identify, authenticate, authorize, validate, handle, log errors, respond. Each middleware either passes to the next or short-circuits with a response. Middleware is composable -- higher-order functions that return middleware.

## When to Use This
- Any Express, Koa, Fastify, or Hono backend
- When cross-cutting concerns are duplicated across route handlers
- When adding a new concern (rate limiting, caching, tracing) to all or most routes

## When NOT to Use This
- Serverless functions where each function is independent -- middleware is per-function, keep it minimal
- Simple scripts or single-endpoint services -- inline everything

## Steps
1. **Single responsibility per middleware.** Auth middleware checks auth. Validation middleware validates. Logging middleware logs. Never combine "check auth AND validate input AND log the request" in one function. Separate concerns are testable, reorderable, and replaceable.

2. **Middleware order is a contract. Document it.**
   ```
   1. Request ID generation   (first -- everything downstream uses it)
   2. Request logging start   (capture timing)
   3. CORS                    (before any other processing)
   4. Body parsing            (parse JSON/form data)
   5. Rate limiting           (before auth -- protect the auth endpoint itself)
   6. Authentication          (who are you? -- sets req.user)
   7. Authorization           (can you do this? -- checks req.user.roles)
   8. Input validation        (is the input valid? -- parses and types req.body)
   9. Route handler           (business logic)
   10. Error middleware        (catches all errors, formats response)
   11. Response logging        (log outcome with status code and duration)
   ```

3. **Auth middleware: authenticate, don't authorize.** Extract token from Authorization header, verify it (JWT verify or session lookup), look up user, attach to `req.user`. If token is missing or invalid, call `next(new AuthError())`. Do NOT check roles here -- that's authorization, which is a separate middleware.

4. **Authorization is separate from authentication.** `requireAuth()` answers "is anyone logged in?" `requireRole('admin')` answers "does the logged-in user have the right role?" `requirePermission('users:write')` answers "does the user have a specific permission?" These are different middleware functions applied per-route.

5. **Request ID middleware: first in the chain.** Generate a UUID for every request. Attach to `req.id`. Set `X-Request-Id` response header. Create a child logger with the request ID. Every downstream middleware and handler uses this ID in logs. When debugging production issues, you grep for the request ID and get the entire story.

6. **Rate limiting middleware with Redis.** Sliding window counter: `INCR` key + `EXPIRE` atomically. Key format: `rl:{identifier}:{path}` where identifier is IP for anonymous, user ID for authenticated. Different limits per tier: anonymous (30/min), authenticated (100/min), premium (1000/min). Always fail open: if Redis is unavailable, allow the request. Rate limiting is a guardrail, not a gate.

7. **CORS middleware: explicit origins, not wildcard.** Development: allow `localhost:*`. Production: explicit list of allowed origins. Different configs per environment. Never use `*` in production with credentials. Use the `cors` npm package with a dynamic origin function that checks against an allowlist.

8. **Request validation middleware factory.** A generic function that takes Zod schemas and returns middleware: `validate({ body: createUserSchema, query: paginationSchema, params: idSchema })`. Validates each part, replaces `req.body`/`req.query`/`req.params` with parsed data, or returns 400 with all errors.

9. **Async middleware wrapper.** Express does not catch promise rejections in middleware or handlers. Wrap every async handler: `asyncHandler(fn)` catches rejections and calls `next(err)`. Without this, unhandled rejections crash the process or hang the request. Express 5 and Koa handle this natively; Express 4 does not.

10. **Error middleware: last in the chain, catches everything.** Express error middleware has 4 parameters: `(err, req, res, next)`. Map error types to HTTP status codes. Return consistent error response shape. Log with request ID and context. Never expose stack traces to clients in production. Log stack traces server-side for 500 errors only.

## Example
```typescript
// middleware/requestId.ts
import { randomUUID } from 'crypto';

export function requestId() {
  return (req: Request, res: Response, next: NextFunction) => {
    req.id = req.headers['x-request-id'] as string ?? randomUUID();
    res.setHeader('X-Request-Id', req.id);
    req.log = logger.child({ requestId: req.id });
    next();
  };
}

// middleware/auth.ts -- authentication only
export function requireAuth() {
  return async (req: Request, res: Response, next: NextFunction) => {
    const token = req.headers.authorization?.replace('Bearer ', '');
    if (!token) return next(new AuthError('No token provided', 401));

    try {
      const payload = jwt.verify(token, JWT_SECRET) as JwtPayload;
      const user = await userService.findById(payload.sub);
      if (!user) return next(new AuthError('User not found', 401));

      req.user = user;
      next();
    } catch (err) {
      if (err instanceof jwt.TokenExpiredError) {
        return next(new AuthError('Token expired', 401));
      }
      next(new AuthError('Invalid token', 401));
    }
  };
}

// middleware/authorize.ts -- authorization, separate from auth
export function requireRole(...roles: string[]) {
  return (req: Request, res: Response, next: NextFunction) => {
    if (!req.user) {
      return next(new AuthError('Not authenticated', 401));
    }
    if (!roles.includes(req.user.role)) {
      return next(new ForbiddenError(
        `Access denied. Required role: ${roles.join(' or ')}. Your role: ${req.user.role}`
      ));
    }
    next();
  };
}

export function requirePermission(permission: string) {
  return (req: Request, res: Response, next: NextFunction) => {
    if (!req.user) return next(new AuthError('Not authenticated', 401));
    if (!req.user.permissions.includes(permission)) {
      return next(new ForbiddenError(`Missing permission: ${permission}`));
    }
    next();
  };
}

// middleware/rateLimit.ts -- Redis-based, fail-open
export function rateLimit({ max, windowMs, keyFn }: RateLimitConfig) {
  return async (req: Request, res: Response, next: NextFunction) => {
    const key = `rl:${keyFn?.(req) ?? req.ip}:${req.path}`;

    try {
      const count = await redis.incr(key);
      if (count === 1) await redis.pexpire(key, windowMs);

      const remaining = Math.max(0, max - count);
      const resetTime = Math.ceil(Date.now() / 1000) + Math.ceil(windowMs / 1000);

      res.set({
        'X-RateLimit-Limit': String(max),
        'X-RateLimit-Remaining': String(remaining),
        'X-RateLimit-Reset': String(resetTime),
      });

      if (count > max) {
        const retryAfter = Math.ceil(windowMs / 1000);
        res.set('Retry-After', String(retryAfter));
        return res.status(429).json({
          error: { code: 'RATE_LIMITED', message: `Too many requests. Retry after ${retryAfter} seconds.` },
        });
      }
    } catch (err) {
      // Fail open: if Redis is down, allow the request
      req.log.warn({ err }, 'Rate limiter unavailable, allowing request');
    }

    next();
  };
}

// middleware/asyncHandler.ts -- catch async errors in Express 4
export function asyncHandler(fn: (req: Request, res: Response, next: NextFunction) => Promise<void>) {
  return (req: Request, res: Response, next: NextFunction) => {
    fn(req, res, next).catch(next);
  };
}

// middleware/errorHandler.ts -- last middleware, catches everything
export function errorHandler(err: Error, req: Request, res: Response, _next: NextFunction) {
  // Map error types to status codes
  const status = err instanceof AppError ? err.statusCode : 500;
  const code = err instanceof AppError ? err.code : 'INTERNAL_ERROR';
  const message = status === 500 ? 'Internal server error' : err.message;

  // Log with context
  if (status >= 500) {
    req.log.error({ err, userId: req.user?.id, body: req.body }, 'Unhandled error');
  } else if (status >= 400) {
    req.log.warn({ code, message, userId: req.user?.id }, 'Client error');
  }

  res.status(status).json({
    error: { code, message },
  });
}

// app.ts -- pipeline assembly
const app = express();

// Global middleware -- runs on every request
app.use(requestId());
app.use(express.json({ limit: '1mb' }));
app.use(cors(corsConfig));

// Public routes -- no auth required
app.use('/health', healthRouter);  // No rate limiting, no auth
app.use('/api/auth', rateLimit({ max: 20, windowMs: 15 * 60 * 1000 }), authRouter);

// Protected routes -- auth required
app.use('/api', requireAuth());
app.use('/api/users', userRouter);
app.use('/api/posts', postRouter);

// Admin routes -- auth + role required
app.use('/api/admin', requireRole('admin'));
app.use('/api/admin/settings', settingsRouter);

// Error handling -- MUST be last
app.use(errorHandler);
```

## Gotchas
- Express 4 does not catch async errors. If your middleware is `async`, unhandled rejections silently hang the request. Either use `express-async-errors` (patches Express), wrap every handler with `asyncHandler`, or upgrade to Express 5+ which handles this natively.
- Middleware order is implicit and invisible. There is no compiler error if auth runs after the route handler. Document the pipeline order in a comment at the top of your app setup. Test the order with integration tests.
- Redis-based rate limiting should fail open. If Redis is down, allow the request with a warning log. Do not block all traffic because your rate limiter is unavailable. The cure should not be worse than the disease.
- Global middleware runs on health check endpoints. If your health check goes through auth middleware, monitoring reports the service as "down" whenever auth is broken. Put health checks before auth in the pipeline.
- `next()` without arguments continues the pipeline. `next(err)` skips to error middleware. `next('route')` skips remaining handlers on the current route (but continues the router). These are three different behaviors and confusing them causes subtle bugs.
- Error middleware MUST have exactly 4 parameters `(err, req, res, next)` in Express. If you omit `next`, Express treats it as regular middleware, not error middleware, and your errors are never caught.
- Request-scoped data goes in `res.locals` (Express) or a context object, never in global or module-scoped variables. Global state shared between requests causes the most insidious concurrency bugs.

## Related Skills
- auth-flow -- auth middleware is the server-side component of the auth flow
- input-validation -- validation middleware parses and types request data
- logging-observability -- request logging, request IDs, and timing are all middleware
- rest-api-design -- middleware implements rate limiting, auth, and consistent error responses
