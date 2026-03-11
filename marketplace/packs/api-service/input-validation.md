# Skill: Input Validation

**Tier:** Foundation
**Category:** Security
**Created:** Marketplace
**Status:** Active
**Times Used:** 0

## What This Skill Solves
Invalid data that sneaks past the API boundary corrupts databases, crashes downstream services, and creates security vulnerabilities. Client-side validation is for UX -- a user with curl bypasses it entirely. Server-side validation at every system boundary is the real defense. This skill ensures input is parsed, validated, and typed before it enters your system.

## The Approach
Schema-first validation at the boundary. Define the exact shape of valid input as a Zod schema. Parse (don't just check) -- the output is typed, trimmed, and coerced. Reject invalid input with ALL errors at once, not one at a time. Validate at the boundary, trust internally. Share schemas between client and server for a single source of truth.

## When to Use This
- Every API endpoint that accepts input (body, query params, path params)
- Every queue consumer or webhook handler that processes external messages
- Every function that reads external data (file uploads, config files, environment variables)

## When NOT to Use This
- Internal function-to-function calls within a trusted boundary -- TypeScript types provide compile-time safety
- Pure read-only endpoints with no parameters beyond a simple ID (though validating the ID format is still good practice)

## Steps
1. **Schema-first with Zod.** Define every request body, query parameter set, and path parameter as a Zod schema. The schema is the contract. Infer the TypeScript type from the schema -- one source of truth for runtime validation and compile-time types. `type CreateUserInput = z.infer<typeof createUserSchema>`.

2. **Parse, don't validate.** `schema.parse(input)` returns a typed, validated, transformed object -- or throws with all errors. This is different from checking validity and then casting. After parsing, the data is guaranteed to match the type. Never use `as` type assertions on unvalidated input.

3. **Validate at the boundary, trust internally.** Validation happens in middleware or the first line of the route handler. Service functions, business logic, and database calls receive already-validated, typed data. No validation deep inside business logic -- that's the boundary's job.

4. **Fail fast, fail completely.** Return ALL validation errors at once, not one at a time. Zod returns all errors by default. Surface them all in a structured format: `{ fields: [{ field: "name", message: "..." }, { field: "email", message: "..." }] }`. The user fixes everything in one round trip.

5. **Type coercion at boundary.** Query params are always strings. Path params are always strings. Parse and coerce in one step: `z.coerce.number()` converts `"42"` to `42`. `z.coerce.boolean()` converts `"true"` to `true`. Use coerce schemas specifically for query/path params, not for JSON bodies (which already have types).

6. **Sanitize after validating.** Validate first (reject invalid), then sanitize (clean valid). Never sanitize instead of validating -- that hides problems. Use Zod transforms for sanitization: `.trim()` for whitespace, `.toLowerCase()` for emails, `.transform(strip)` for HTML tags in plain text fields.

7. **Constrain everything.** Strings: `.min()`, `.max()`. Numbers: `.min()`, `.max()`, `.int()` where appropriate. Arrays: `.min(1)`, `.max(100)`. Never accept unbounded input -- unbounded strings can be 100MB, unbounded arrays can be millions of items. Both are either bugs or attacks.

8. **Strict objects reject unknown fields.** `z.object({ name: z.string() }).strict()` rejects `{ name: "Alice", admin: true }`. Without `.strict()`, Zod strips unknown fields by default (safe but silent). Use `.strict()` when extra fields indicate a client bug. Use `.strip()` (default) when extra fields are harmless.

9. **File upload validation before processing.** Validate MIME type, file size, and filename before reading the file content. Do not trust the client's Content-Type header -- verify with magic bytes (file-type package) for security-critical uploads. Validate in middleware before the file reaches your handler.

10. **SQL injection prevention is separate.** Parameterized queries are the primary defense against SQL injection. Validation is defense-in-depth, not the primary defense. Even with perfect validation, never concatenate user input into SQL strings. Use `$1` placeholders (pg), `?` (mysql2), or ORM parameterization.

## Example
```typescript
// schemas/user.ts -- shared between client and server
import { z } from 'zod';

export const createUserSchema = z.object({
  name: z.string()
    .trim()
    .min(2, 'Name must be at least 2 characters')
    .max(100, 'Name must be under 100 characters'),
  email: z.string()
    .trim()
    .toLowerCase()
    .email('Invalid email address'),
  age: z.number()
    .int('Age must be a whole number')
    .min(13, 'Must be at least 13 years old')
    .max(150, 'Invalid age')
    .optional(),
  role: z.enum(['admin', 'editor', 'viewer'], {
    errorMap: () => ({ message: 'Role must be admin, editor, or viewer' }),
  }),
  tags: z.array(z.string().trim().min(1))
    .max(10, 'Maximum 10 tags')
    .optional()
    .default([]),
});

export type CreateUserInput = z.infer<typeof createUserSchema>;

// Query param schemas use coercion (everything arrives as string)
export const listUsersQuerySchema = z.object({
  page: z.coerce.number().int().min(1).default(1),
  limit: z.coerce.number().int().min(1).max(100).default(20),
  role: z.enum(['admin', 'editor', 'viewer']).optional(),
  search: z.string().trim().min(1).max(200).optional(),
  sort: z.enum(['name', '-name', 'createdAt', '-createdAt']).default('-createdAt'),
});

// Path param validation
export const userIdParamSchema = z.object({
  id: z.string().regex(/^u_[a-zA-Z0-9]{12}$/, 'Invalid user ID format'),
});

// middleware/validate.ts -- generic validation middleware factory
import { z, ZodSchema } from 'zod';
import { Request, Response, NextFunction } from 'express';

interface ValidateOptions {
  body?: ZodSchema;
  query?: ZodSchema;
  params?: ZodSchema;
}

export function validate(schemas: ValidateOptions) {
  return (req: Request, res: Response, next: NextFunction) => {
    const errors: Array<{ field: string; message: string; location: string }> = [];

    if (schemas.body) {
      const result = schemas.body.safeParse(req.body);
      if (result.success) {
        req.body = result.data; // Replace with parsed data (trimmed, typed)
      } else {
        errors.push(...result.error.issues.map(issue => ({
          field: issue.path.join('.'),
          message: issue.message,
          location: 'body',
        })));
      }
    }

    if (schemas.query) {
      const result = schemas.query.safeParse(req.query);
      if (result.success) {
        req.query = result.data;
      } else {
        errors.push(...result.error.issues.map(issue => ({
          field: issue.path.join('.'),
          message: issue.message,
          location: 'query',
        })));
      }
    }

    if (schemas.params) {
      const result = schemas.params.safeParse(req.params);
      if (result.success) {
        req.params = result.data;
      } else {
        errors.push(...result.error.issues.map(issue => ({
          field: issue.path.join('.'),
          message: issue.message,
          location: 'params',
        })));
      }
    }

    if (errors.length > 0) {
      return res.status(400).json({
        error: {
          code: 'VALIDATION_ERROR',
          message: 'Invalid input',
          details: { fields: errors },
        },
      });
    }

    next();
  };
}

// routes/users.ts -- using the validation middleware
import { validate } from '../middleware/validate';
import { createUserSchema, listUsersQuerySchema, userIdParamSchema } from '../schemas/user';

router.get('/',
  validate({ query: listUsersQuerySchema }),
  async (req, res) => {
    // req.query is typed and coerced: { page: number, limit: number, ... }
    const users = await userService.list(req.query);
    res.json({ data: users });
  }
);

router.post('/',
  validate({ body: createUserSchema }),
  async (req, res) => {
    // req.body is typed as CreateUserInput, trimmed, lowercased where specified
    const user = await userService.create(req.body);
    res.status(201).json({ data: user });
  }
);

router.get('/:id',
  validate({ params: userIdParamSchema }),
  async (req, res) => {
    const user = await userService.getById(req.params.id);
    if (!user) return res.status(404).json({ error: { code: 'NOT_FOUND', message: 'User not found' } });
    res.json({ data: user });
  }
);
```

## Gotchas
- `z.boolean().default(true)` makes the TypeScript type `boolean` (required), not optional. When constructing objects manually, you must include the field. This is because `.default()` fills it in during parsing, but the output type is non-optional.
- `z.coerce.number()` converts strings to numbers -- use it for query params. But `z.number()` rejects strings -- use it for JSON bodies where the type should already be correct. Mixing them up causes confusing rejections.
- JSON `number` can be a float. If you expect an integer, use `.int()`. Without it, `3.14` passes `z.number().min(1)`. This matters for pagination params, IDs, and quantities.
- Deeply nested validation errors need flattened paths: `"address.city"` not `["address", "city"]`. Use `issue.path.join('.')` when formatting error responses.
- Client-side validation is for UX, not security. Never trust it. Anyone with curl, Postman, or browser dev tools bypasses client validation entirely. Server-side validation is the gate.
- Zod `.strict()` rejects unknown fields but `.passthrough()` preserves them. Default behavior is `.strip()` which silently removes unknown fields. Be intentional about which you choose.
- Common validation patterns: email (Zod's `.email()` covers format; for critical flows, also verify MX records), URLs (parse with `new URL()` in a `.refine()`), dates (ISO 8601 string with `.datetime()` or `z.coerce.date()`), phone numbers (use a library like `libphonenumber-js` in a `.refine()`).

## Related Skills
- form-handling -- client-side validation using the same Zod schemas
- rest-api-design -- validation errors fit the standard error response format
- middleware-design -- validation middleware sits in the request pipeline
