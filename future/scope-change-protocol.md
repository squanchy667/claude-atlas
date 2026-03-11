# Future Feature: Scope Change Protocol

> Should be built into v1.5. Fills a real workflow gap. Does not require marketplace infrastructure.

## Overview

The Scope Change Protocol is a formal process for handling deliberate requirement changes during a project. It introduces a `/scope-change` command and a tracking system that is distinct from drift tracking.

**The distinction:** Drift is unplanned deviation --- the implementation diverges from the agreement during execution. A scope change is a planned decision --- the stakeholder, developer, or team deliberately decides to change what they are building. Both need tracking, but they have different causes, different workflows, and different implications.

Drift says: "I went off course." A scope change says: "We moved the destination."

Treating scope changes as drift conflates deliberate decisions with unplanned problems. Treating them as nothing (just editing the docs) loses the audit trail and makes retrospectives inaccurate. The Scope Change Protocol gives deliberate changes their own process with full impact analysis and traceability.

## The Problem

Consider this scenario: You are in Phase 3 of a SaaS project. The client decides they want multi-tenancy to use isolated schemas instead of a shared database. This is not drift --- nobody made a mistake. It is a deliberate architectural change based on new information (a new enterprise customer requires data isolation).

Without the Scope Change Protocol, you have a few bad options:
1. **Edit the agreements silently.** Future retrospectives will not know the architecture changed. Estimation data will be wrong (the original plan was simpler). The audit trail is broken.
2. **Log it as drift.** But it is not drift. Nobody deviated from the plan. The plan itself changed. Mixing scope changes with drift makes drift analytics unreliable.
3. **Start a new project.** Extreme overkill for a scoped change.

The Scope Change Protocol provides a fourth option: track the change formally, analyze its impact, amend affected documents with explicit annotations, and maintain a clear record of what changed and why.

## The `/scope-change` Command

### Invocation

```
/scope-change
```

Run whenever a deliberate requirement change occurs. Interactive --- Atlas asks questions and builds the scope change record.

### Step-by-Step Process

**Step 1: Capture the Change**

Atlas asks:
- "What changed?" (description of the before and after)
- "Why did it change?" (new information, stakeholder decision, technical discovery, market change)
- "Who requested it?" (stakeholder name, team decision, self-initiated)
- "How urgent is it?" (immediate / next phase / whenever convenient)

**Step 2: Impact Analysis**

Atlas scans the project to identify everything affected by the change:

1. **Affected tasks:** Scan all `tasks/phase-N/task-N/task.md` and `agreement.md` files for overlapping scope. List tasks that reference the changed area.
2. **Affected phases:** Determine which phases contain affected tasks. If a future phase assumed the old requirement, it needs replanning.
3. **Affected agreements:** List specific `agreement.md` files whose acceptance criteria, scope, or technical approach need amending.
4. **Affected skills:** Check if any skills in `skills/active/` or `skills/foundation/` encode assumptions about the old requirement. List skills that need updating or archiving.
5. **Affected decisions:** Check `memory/decisions.md` for decisions that were based on the old requirement.
6. **New gaps:** Identify unknowns introduced by the change. Add them to `atlas/gaps.md`.

Atlas presents the impact analysis:

```
Impact Analysis for Scope Change:
─────────────────────────────────
Affected tasks: T012, T015, T016, T023 (4 tasks across 2 phases)
Affected phases: Phase 2 (in progress), Phase 3 (planned)
Affected agreements:
  - tasks/phase-2/task-12/agreement.md (acceptance criteria change)
  - tasks/phase-2/task-15/agreement.md (technical approach change)
  - tasks/phase-3/task-23/agreement.md (scope change)
Affected skills:
  - skills/active/database-modeling.md (assumes shared database)
Affected decisions:
  - memory/decisions.md entry from 2026-03-01 (multi-tenancy strategy)
New gaps:
  - Schema migration strategy for isolated tenants
  - Per-tenant backup and restore process
  - Connection pooling for multiple schemas
```

**Step 3: Create Scope Change Record**

Atlas creates `scope-changes/SC-[NNN].md`:

```markdown
# SC-001: Switch to Isolated Schema Multi-Tenancy

## Metadata
- **ID:** SC-001
- **Date:** 2026-03-15
- **Requested by:** Client (Enterprise customer requirement)
- **Urgency:** Next phase (Phase 3)
- **Status:** proposed

## Change Description

### Before
Multi-tenancy implemented via shared database with tenant_id column on all tables.
Single database connection, row-level security via middleware.

### After
Multi-tenancy implemented via isolated PostgreSQL schemas per tenant.
Shared connection pool with schema switching. Tenant provisioning creates new schema
with full migration history.

## Rationale
New enterprise customer (Acme Corp) requires data isolation for SOC 2 compliance.
Shared database with row-level security does not meet their audit requirements.
Isolated schemas provide physical separation while keeping a single database instance.

## Impact Analysis

### Affected Tasks
| Task | Phase | Status | Impact |
|------|-------|--------|--------|
| T012 | 2 | DONE | Needs rework: database layer assumes shared tables |
| T015 | 2 | IN_PROGRESS | Scope change: middleware needs schema switching |
| T016 | 2 | PENDING | Scope change: seed data needs per-schema seeding |
| T023 | 3 | PENDING | Scope change: admin dashboard needs tenant provisioning |

### Affected Agreements
- `tasks/phase-2/task-12/agreement.md` — Acceptance criteria for database layer must change from "tenant_id filtering" to "schema isolation"
- `tasks/phase-2/task-15/agreement.md` — Technical approach for middleware must include schema resolution from request context
- `tasks/phase-3/task-23/agreement.md` — Admin dashboard must include tenant schema provisioning UI

### Affected Skills
- `skills/active/database-modeling.md` — Currently assumes shared database pattern. Must be updated to cover isolated schema pattern.

### Affected Decisions
- `memory/decisions.md` 2026-03-01 entry "Multi-tenancy: shared database with tenant_id" — superseded by this scope change

### New Gaps
- Schema migration strategy: how do migrations run across N schemas?
- Connection pooling: how does the pool handle schema switching?
- Per-tenant backup: can individual tenant schemas be backed up independently?

## Resolution Plan
1. Update database-modeling skill with isolated schema pattern
2. Amend T012 agreement and plan rework task
3. Amend T015 agreement (in progress — may need to restart)
4. Amend T016 agreement
5. Amend T023 agreement
6. Add new gaps to atlas/gaps.md
7. Update memory/decisions.md with new decision
8. Replan Phase 3 to account for increased complexity

## Status History
- 2026-03-15: Proposed
```

**Step 4: Human Approval**

Atlas presents the scope change record and resolution plan. The human reviews and either:
- **Approves:** Status moves to `approved`. Atlas proceeds with amendments.
- **Rejects:** Status moves to `rejected`. Record is kept for audit trail. No changes made.
- **Modifies:** Human adjusts the change or resolution plan. Atlas updates and re-presents.

**Step 5: Apply Changes (if approved)**

When approved, Atlas executes the resolution plan:

1. **Amend agreements:** Each affected `agreement.md` gets an explicit annotation at the top:
   ```markdown
   > **Scope Change SC-001 applied on 2026-03-15.** Original acceptance criteria
   > for database isolation changed from shared-database to isolated-schema approach.
   > See scope-changes/SC-001.md for full context.
   ```
   The actual acceptance criteria and technical approach sections are then updated. The original text is preserved in a collapsed "Previous version" section so the change is visible.

2. **Update skills:** Affected skills are updated with the new patterns. If a skill becomes entirely irrelevant, it is moved to `skills/archive/` with a note referencing the scope change.

3. **Update decisions:** New entry in `memory/decisions.md` referencing the scope change:
   ```
   ## 2026-03-15 — Multi-tenancy: Isolated schemas (SC-001)
   Switched from shared database with tenant_id to isolated PostgreSQL schemas.
   Reason: Enterprise customer requires data isolation for SOC 2 compliance.
   Supersedes: 2026-03-01 decision on shared database approach.
   ```

4. **Update gaps:** New gaps from the impact analysis are added to `atlas/gaps.md`.

5. **Update phases:** If the scope change affects phase planning, `phases/INDEX.md` is updated. If tasks need to be added, modified, or removed, the phase plan is amended.

6. **Log in progress:** `status/progress.md` gets an entry noting the scope change.

7. **Update scope change status:** Record status changes from `approved` to `applied`.

**Step 6: Summary**

Atlas outputs a summary of everything that was changed:

```
Scope Change SC-001 Applied
────────────────────────────
Changed: 3 agreements amended, 1 skill updated, 1 decision superseded
Added: 3 new gaps, 1 new decision
Replanned: Phase 3 tasks adjusted for increased complexity
Record: scope-changes/SC-001.md
```

## Directory Structure

```
scope-changes/
├── SC-001.md
├── SC-002.md
└── INDEX.md        # Summary table of all scope changes with status
```

### INDEX.md Format

```markdown
# Scope Changes

| ID | Date | Description | Status | Affected Tasks |
|----|------|-------------|--------|----------------|
| SC-001 | 2026-03-15 | Switch to isolated schema multi-tenancy | applied | T012, T015, T016, T023 |
| SC-002 | 2026-03-20 | Add SSO support for enterprise tier | proposed | T030, T031 |
```

## Scope Changes vs Drift

| Aspect | Drift | Scope Change |
|--------|-------|-------------|
| Trigger | Unplanned deviation during execution | Deliberate decision to change requirements |
| Who initiates | Claude (discovers deviation) | Human (decides to change) |
| Tracking file | `tasks/phase-N/task-N/drift.md` | `scope-changes/SC-NNN.md` |
| Approval required | No (logged immediately) | Yes (human approves before changes) |
| Agreements modified | No (drift is documented alongside) | Yes (explicitly amended with annotation) |
| Impact analysis | Limited to current task | Cross-task, cross-phase, cross-skill |
| Retrospective treatment | Process improvement signal | Decision quality signal |

## Connection to Other Features

### Quality Scorecard
Scope changes are not counted as drift in the quality scorecard. They are tracked separately as a "scope change count" metric. A high scope change count is not necessarily bad --- it might mean the project is responsive to new information. But it does affect estimation accuracy (original estimates were for a different scope).

### Cross-Project Intelligence
Scope change frequency by project type becomes part of collective intelligence. "SaaS projects average 2.3 scope changes. Most common: auth strategy change (35%), billing model change (25%)." This helps future projects anticipate where scope changes are likely.

### Team Mode
When team mode is active, scope changes that affect tasks assigned to multiple developers trigger automatic sync points. The scope change record includes which workstreams are affected and whether a sync meeting is recommended.

### Adaptive Estimation
Scope changes reset estimation baselines for affected tasks. The estimation system tracks "original estimate," "post-scope-change estimate," and "actual" as three separate data points.

## Status

Should be built into v1.5. The core functionality (command, impact analysis, tracking) fills an immediate workflow gap. Does not require marketplace infrastructure, collective intelligence, or any external dependencies. Builds on existing Atlas file conventions.
