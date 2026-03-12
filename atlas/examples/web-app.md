# Atlas Setup Example — Web App (Expense Tracker)

A full-stack web app with React frontend, Express backend, and PostgreSQL database.

---

## Q1 — Project Name
```
ExpenseTracker
```

## Q2 — Description
```
A personal expense tracking web app where users log transactions, categorize spending, set monthly budgets, and view spending trends through interactive charts.
```

## Q3 — Problem
```
People lose track of where their money goes. Bank apps show transactions but don't help you understand spending patterns or stick to a budget. Spreadsheets work but require manual entry and discipline. Existing expense trackers are either too complex (Mint, YNAB — require linking bank accounts, learning budgeting philosophy) or too simple (basic spreadsheet clones with no insights). Target audience: young professionals (25-35) who want to understand their spending without linking bank accounts or learning a budgeting system. They want to open a tab, log an expense in 3 seconds, and see where their money went this month.
```

## Q4 — Stack
```
Frontend: React 18 with TypeScript, Vite, TailwindCSS, Recharts (charts), React Router v6, React Hook Form + Zod validation. State: TanStack Query for server state, React Context for auth. Backend: Node.js 20, Express, TypeScript. Database: PostgreSQL 15 with Prisma ORM. Auth: JWT (access + refresh tokens), bcrypt for password hashing. API: REST with Zod request validation middleware. Testing: Vitest (unit), Playwright (e2e). Build: Docker Compose for local dev (app + db). Version Control: Git.
```

## Q5 — Team Size
```
1
```

## Q6 — Success Criteria
```
- User can sign up, log in, and log out (JWT auth with refresh tokens)
- User can add an expense in under 3 seconds (amount, category, optional note, date defaults to today)
- User can view a list of expenses filtered by date range and category
- User can edit or delete any expense
- User can set monthly budgets per category and see progress bars (spent vs budget)
- Dashboard shows: total spent this month, top 3 categories, spending trend line chart (last 6 months), category breakdown pie chart
- All forms validate on submit with clear error messages (Zod schemas shared between frontend and backend)
- Responsive design: works on desktop and mobile (TailwindCSS breakpoints)
- API returns proper HTTP status codes and structured error responses
- Page loads in under 2 seconds on first visit
```

## Q7 — Failure Conditions
```
- Adding an expense requires more than 3 clicks or fields
- Charts are confusing or don't update when data changes
- Auth flow has security holes (tokens stored in localStorage without httpOnly, no refresh rotation)
- Mobile layout is broken or unusable
- API errors return 500 with no useful message
- Page feels slow (visible loading spinners on every navigation)
```

## Q8 — Non-Scope
```
- Bank account linking or automatic transaction import (manual entry only)
- Multi-currency support (single currency, user picks during setup)
- Recurring expenses or subscriptions tracking
- Export to CSV/PDF
- Social features or sharing
- Mobile native app (responsive web only)
- Multi-user households or shared budgets
- AI-powered categorization
```

## Q9 — Phases
```
Phase 1 — Foundation: Project setup (monorepo with client + server + shared packages), database schema (users, categories, expenses, budgets), Prisma setup, Express scaffold with health check, React scaffold with routing, Docker Compose for local dev. Result: both apps start, database connects.

Phase 2 — Auth: User registration and login endpoints, JWT access + refresh token flow, password hashing with bcrypt, auth middleware, React auth context, login/signup pages, protected route wrapper, token refresh on 401. Result: user can sign up, log in, access protected pages.

Phase 3 — Expense CRUD: Create/read/update/delete expense API endpoints with Zod validation, expense list page with date range and category filters, add expense form (quick-add optimized), edit/delete with confirmation, shared Zod schemas between client and server. Result: user can manage their expenses.

Phase 4 — Budgets: Monthly budget API (set per category, read current month), budget progress bars on dashboard, over-budget visual warnings, budget settings page. Result: user can set and track budgets.

Phase 5 — Dashboard & Charts: Dashboard page with summary cards (total spent, top categories), spending trend line chart (Recharts, last 6 months), category breakdown pie chart, responsive layout. Result: user can see spending insights at a glance.

Phase 6 — Polish: Loading states and skeleton screens, error boundaries, toast notifications, mobile responsive pass, performance optimization (query caching, lazy loading), form UX improvements (autofocus, keyboard navigation). Result: app feels production-ready.
```

## Q10 — Risks
```
- Auth security: JWT implementation has many subtle pitfalls (token storage, refresh rotation, CSRF). Mitigation: follow OWASP guidelines, use httpOnly cookies for refresh tokens, rotate refresh tokens on use.
- Prisma migration conflicts: schema changes mid-project can break existing data. Mitigation: plan the full schema in Phase 1, minimize changes in later phases.
- Chart performance: large datasets may slow down Recharts rendering. Mitigation: aggregate data on the backend, send pre-computed summaries to the frontend.
- Shared Zod schemas: keeping client and server validation in sync requires careful package structure. Mitigation: create a shared package in the monorepo from Phase 1.
- Mobile responsiveness: retrofitting responsive design is harder than building it in. Mitigation: TailwindCSS mobile-first approach from Phase 1, test on mobile viewport at every phase.
```

## Q11 — Integrations
```
No external services beyond the database. PostgreSQL 15 runs locally via Docker Compose. npm packages — Frontend: react, react-router-dom, @tanstack/react-query, tailwindcss, recharts, react-hook-form, zod, @hookform/resolvers. Backend: express, prisma, @prisma/client, jsonwebtoken, bcrypt, zod, cors, helmet. Dev: typescript, vite, vitest, playwright, docker-compose. Environment variables: DATABASE_URL (Prisma connection string), JWT_SECRET, JWT_REFRESH_SECRET, PORT.
```

---

## Expected Output

| Metric | Estimate |
|--------|----------|
| Total tasks | 25-30 |
| Phases | 6 |
| Source files | 60-80 |
| Lines of code | 5,000-8,000 |
| API endpoints | 12-15 |
| Database tables | 4 (users, categories, expenses, budgets) |
| Sessions | 2-3 |

## Key Patterns

- **Zod-first validation** — Define schemas once in shared package, infer TypeScript types, use on both client and server
- **TanStack Query for server state** — No manual loading/error state management, automatic cache invalidation
- **Monorepo with shared package** — Types and validation schemas shared between frontend and backend
- **JWT with httpOnly refresh cookies** — Access token in memory (short-lived), refresh token in httpOnly cookie (long-lived, rotated)
- **Prisma for type-safe DB** — Generated types from schema, migrations tracked in git
- **Mobile-first TailwindCSS** — Start with mobile layout, add breakpoints for desktop

## Gotchas

- Prisma JSON columns need `JSON.parse(JSON.stringify(obj))` for complex TypeScript objects
- Recharts Tooltip `labelFormatter` takes `ReactNode`, not `string` — use `String(label)` cast
- TanStack Query cache invalidation: mutate expense → invalidate both expense list AND dashboard summary queries
- JWT refresh token rotation: if the old refresh token is reused after rotation, invalidate ALL tokens for that user (stolen token detection)
- Docker Compose: Prisma migrations need to run after the database container is healthy, not just started — use `depends_on` with healthcheck
- CORS: configure allowed origins explicitly, don't use `*` with credentials
