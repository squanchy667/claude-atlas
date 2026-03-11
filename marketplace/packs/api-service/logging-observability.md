# Skill: Logging & Observability

**Tier:** Foundation
**Category:** Operations
**Created:** Marketplace
**Status:** Active
**Times Used:** 0

## What This Skill Solves
When something breaks in production, you need to answer four questions: what happened, when, to whom, and why. Unstructured `console.log` statements scattered through the code answer none of them. You grep for error messages, find nothing because the format changed, and spend hours correlating timestamps manually. This skill provides structured logging, request tracing, health checks, and metrics that make production debugging possible in minutes instead of hours.

## The Approach
Structured JSON logs with consistent mandatory fields on every entry. Request IDs that trace through the entire pipeline and across service boundaries. Health check endpoints that distinguish "running" from "ready." Log at boundaries (request in, response out, external call made) not inside business logic. Alert on symptoms (error rate, latency), investigate causes in logs.

## When to Use This
- Any service that will run in production
- When debugging production issues takes hours instead of minutes
- When setting up monitoring and alerting for a new service
- Before the first deployment -- not after the first outage

## When NOT to Use This
- Local-only development tools and scripts -- `console.log` is fine
- Prototype or demo apps that will never see real users

## Steps
1. **Structured JSON logs, from day one.** Every log entry is a parseable JSON object: `{ "timestamp": "...", "level": "info", "message": "...", "requestId": "...", "service": "user-api" }`. Use pino (Node.js) -- it is the fastest structured logger. Never `console.log('User created: ' + userId)`. Always `logger.info({ userId, email }, 'User created')`.

2. **Log levels have specific meanings. Follow them.**
   - `error` -- Something failed that should not have. Requires investigation. Alerts fire. Examples: unhandled exception, database connection lost, payment processing failure.
   - `warn` -- Something unexpected but handled. Degraded behavior. Review periodically. Examples: retry succeeded, rate limit approached, deprecated API called.
   - `info` -- Normal operation milestones. Sparse and meaningful. Examples: server started, user created, order placed, deployment completed.
   - `debug` -- Detailed technical info for active debugging. Disabled in production by default. Enabled temporarily when investigating an issue.

3. **Mandatory fields on every log entry.** These fields must appear on every single log line:
   - `timestamp` -- ISO 8601 format (`2024-01-15T10:30:00.123Z`)
   - `level` -- error, warn, info, debug
   - `message` -- human-readable description of what happened
   - `requestId` -- UUID linking all logs for a single request
   - `service` -- which service produced this log
   - Optional but valuable: `userId`, `duration` (ms), `statusCode`, `method`, `path`

4. **Request lifecycle: one log per request at completion.** Log when the request finishes, not when it starts. Include: method, path, status code, duration in milliseconds, request ID, user ID. One structured log entry captures the entire request. Do not log both start and end -- that doubles log volume for marginal value.

5. **Error logging: context over stack traces.** For every error, log: the error message, the operation that failed, the input that caused it (sanitized), and the request ID. Include the full stack trace only for unexpected (500) errors. For expected errors (400, 404), the message and context are sufficient. One log entry per error, not three.

6. **Performance logging for external calls.** Log duration for every external call: database queries, HTTP requests to other services, cache operations, queue publishes. Set thresholds for slow query warnings (e.g., database > 100ms, API > 500ms). These logs are how you find the bottleneck when latency spikes.

7. **Health check endpoints -- two levels.**
   - `GET /health` -- Returns 200 if the process is alive. No dependency checks. Load balancers use this. Must be fast (<10ms) and always available (no auth middleware).
   - `GET /health/ready` -- Returns 200 if the service can handle requests: database connected, cache reachable, required external services available. Returns 503 if any critical dependency is down. Deployment orchestrators use this for readiness gates.

8. **Metrics: the four golden signals.** Track these for every service:
   - **Latency** -- request duration percentiles: p50, p95, p99. Not averages -- averages hide outliers.
   - **Traffic** -- requests per second by endpoint.
   - **Errors** -- error rate (5xx responses / total responses). Alert when rate exceeds threshold.
   - **Saturation** -- connection pool usage, memory usage, event loop lag. Alert before exhaustion, not at exhaustion.
   Export in Prometheus format if possible. Use `/metrics` endpoint with `prom-client` package.

9. **Log aggregation and search.** Structured JSON logs are shipped to a log aggregation service: Elasticsearch (ELK stack), CloudWatch Logs, Datadog, Grafana Loki. Query by request ID, user ID, time range, error level. Set up dashboards for error rate and latency. Set up alerts for anomalies.

10. **What NOT to log -- the redaction list.** Never log: passwords, access tokens, refresh tokens, API keys, credit card numbers, SSNs, personal health information. Use pino's `redact` option to strip sensitive paths automatically: `redact: ['req.headers.authorization', 'body.password', 'body.creditCard']`. When in doubt, don't log it.

## Example
```typescript
// logger.ts -- pino setup with redaction
import pino from 'pino';

export const logger = pino({
  level: process.env.LOG_LEVEL ?? 'info',
  formatters: {
    level: (label) => ({ level: label }),
  },
  timestamp: pino.stdTimeFunctions.isoTime,
  redact: {
    paths: [
      'req.headers.authorization',
      'body.password',
      'body.token',
      'body.creditCard',
      'body.ssn',
    ],
    censor: '[REDACTED]',
  },
  base: {
    service: process.env.SERVICE_NAME ?? 'api',
    version: process.env.APP_VERSION ?? 'unknown',
  },
});

// middleware/requestLogger.ts -- one log per request
import { randomUUID } from 'crypto';

export function requestLogger() {
  return (req: Request, res: Response, next: NextFunction) => {
    const requestId = (req.headers['x-request-id'] as string) ?? randomUUID();
    const start = process.hrtime.bigint();

    req.id = requestId;
    req.log = logger.child({ requestId });

    res.setHeader('X-Request-Id', requestId);

    res.on('finish', () => {
      const duration = Number(process.hrtime.bigint() - start) / 1_000_000; // ms

      const logData = {
        method: req.method,
        path: req.originalUrl,
        statusCode: res.statusCode,
        duration: Math.round(duration * 100) / 100,
        userId: req.user?.id,
        contentLength: res.get('content-length'),
      };

      if (res.statusCode >= 500) {
        req.log.error(logData, 'Request failed');
      } else if (res.statusCode >= 400) {
        req.log.warn(logData, 'Client error');
      } else if (duration > 1000) {
        req.log.warn(logData, 'Slow request');
      } else {
        req.log.info(logData, 'Request completed');
      }
    });

    next();
  };
}

// middleware/externalCallLogger.ts -- log duration of external calls
export function logExternalCall(service: string, operation: string) {
  return async function <T>(fn: () => Promise<T>, reqLog: pino.Logger): Promise<T> {
    const start = Date.now();
    try {
      const result = await fn();
      const duration = Date.now() - start;

      if (duration > 500) {
        reqLog.warn({ service, operation, duration }, 'Slow external call');
      } else {
        reqLog.debug({ service, operation, duration }, 'External call completed');
      }

      return result;
    } catch (err) {
      const duration = Date.now() - start;
      reqLog.error({ service, operation, duration, err }, 'External call failed');
      throw err;
    }
  };
}

// Usage in service code
async function getUser(id: string, reqLog: pino.Logger) {
  return logExternalCall('database', 'user.findUnique')(
    () => prisma.user.findUnique({ where: { id } }),
    reqLog
  );
}

// routes/health.ts -- two-level health checks
const healthRouter = Router();

// Liveness -- is the process running?
healthRouter.get('/', (req, res) => {
  res.json({
    status: 'ok',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
  });
});

// Readiness -- can the service handle requests?
healthRouter.get('/ready', async (req, res) => {
  const checks: Record<string, 'ok' | 'fail'> = {};

  try {
    await prisma.$queryRaw`SELECT 1`;
    checks.database = 'ok';
  } catch {
    checks.database = 'fail';
  }

  try {
    await redis.ping();
    checks.cache = 'ok';
  } catch {
    checks.cache = 'fail';
  }

  const allOk = Object.values(checks).every(v => v === 'ok');

  res.status(allOk ? 200 : 503).json({
    status: allOk ? 'ready' : 'not ready',
    checks,
    version: process.env.APP_VERSION ?? 'unknown',
    timestamp: new Date().toISOString(),
  });
});

// metrics.ts -- Prometheus metrics with prom-client
import { collectDefaultMetrics, Registry, Histogram, Counter } from 'prom-client';

const register = new Registry();
collectDefaultMetrics({ register });

export const httpRequestDuration = new Histogram({
  name: 'http_request_duration_seconds',
  help: 'Duration of HTTP requests in seconds',
  labelNames: ['method', 'path', 'status_code'],
  buckets: [0.01, 0.05, 0.1, 0.25, 0.5, 1, 2.5, 5, 10],
  registers: [register],
});

export const httpRequestTotal = new Counter({
  name: 'http_requests_total',
  help: 'Total number of HTTP requests',
  labelNames: ['method', 'path', 'status_code'],
  registers: [register],
});

// Metrics endpoint
app.get('/metrics', async (req, res) => {
  res.set('Content-Type', register.contentType);
  res.end(await register.metrics());
});
```

## Gotchas
- `console.log` in production outputs unstructured text to stdout. Log aggregators (CloudWatch, Datadog, ELK) need JSON to be searchable. Use a proper structured logger (pino, winston) from the start -- retrofitting is painful.
- Log volume costs money. At scale, debug-level logs can cost more per month than the service itself. Keep production at `info` level. Enable `debug` temporarily for active investigation, then disable it.
- Request IDs must propagate across service boundaries. When calling another service, pass `X-Request-Id` in the request headers. Without this, distributed tracing across microservices is impossible -- you can trace within a service but not across them.
- Health check endpoints MUST NOT go through auth middleware. If auth is broken (database down, JWT secret rotated), the health check must still respond. Otherwise monitoring reports the service as completely down when only auth is broken.
- Logging inside hot loops tanks performance. A loop that processes 10,000 items should log once (the summary: "Processed 10,000 items in 2.3s") not 10,000 times. Even pino's speed cannot save you from 10,000 log writes per request.
- `process.hrtime.bigint()` is more accurate than `Date.now()` for measuring duration. `Date.now()` has millisecond resolution and can jump due to NTP adjustments. `hrtime` is monotonic and nanosecond resolution.
- Alert on symptoms, not causes. Alert on: error rate above 1%, p99 latency above 2s, health check failing. Do NOT alert on: individual error log lines, CPU usage spikes, log volume changes. Symptoms affect users; causes are for investigation after the alert fires.

## Related Skills
- middleware-design -- request logging, request IDs, and timing are implemented as middleware
- rest-api-design -- health endpoints and request ID headers are part of the API surface
- database-patterns -- slow query logging helps identify N+1 and missing indexes
