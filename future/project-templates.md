# Future Feature: Project Templates

> Planned for v2. Requires marketplace infrastructure and validated skill packs.

## Overview

Project Templates are pre-built project blueprints that sit above skills. A template packages together phase definitions, curated skill packs, architecture patterns, task outlines, and pre-identified gaps for a specific project type. When a user runs `/atlas-setup`, they select a template and approximately 70% of the project structure is pre-filled. The user customizes from there.

Templates are not rigid scaffolds. They are informed starting points that encode lessons from real projects. A SaaS starter template does not just create folders --- it knows that auth comes before billing, that multi-tenancy decisions ripple through every layer, and that the first phase should validate the data model before building features.

## Template Structure

Each template lives in `marketplace/templates/` as a directory with a fixed internal structure:

```
marketplace/templates/
├── saas-starter/
│   ├── template.json          # Metadata, stack, phases, skills, estimated effort
│   ├── phases/                # Pre-defined phase definitions
│   │   ├── phase-1-foundation.md
│   │   ├── phase-2-core.md
│   │   ├── phase-3-integration.md
│   │   ├── phase-4-polish.md
│   │   └── phase-5-production.md
│   ├── skills/                # Curated skill pack for this type
│   │   ├── foundation/        # Skills imported as foundation tier
│   │   └── active/            # Skills imported as active tier
│   ├── architecture.md        # Reference architecture with diagrams
│   ├── known-gaps.md          # Common gaps and unknowns for this project type
│   └── decisions.md           # Pre-loaded architectural decisions with rationale
├── rest-api/
├── cli-tool/
├── chrome-extension/
├── mobile-app/
├── unity-game/
└── open-source-library/
```

### template.json

The template manifest contains everything Atlas needs to pre-fill a project:

```json
{
  "name": "saas-starter",
  "displayName": "SaaS Starter",
  "description": "Full-stack SaaS application with auth, billing, multi-tenancy, and admin dashboard",
  "version": "1.0.0",
  "author": "atlas-team",
  "license": "MIT",
  "stack": {
    "required": ["TypeScript", "Node.js"],
    "recommended": ["React", "PostgreSQL", "Prisma", "Stripe"],
    "alternatives": {
      "React": ["Vue", "Svelte"],
      "PostgreSQL": ["MySQL"],
      "Stripe": ["Paddle", "LemonSqueezy"]
    }
  },
  "phases": [
    {
      "number": 1,
      "name": "Foundation",
      "theme": "Data model, auth, project structure",
      "estimatedTasks": 8,
      "estimatedComplexity": "moderate",
      "planFile": "phases/phase-1-foundation.md"
    },
    {
      "number": 2,
      "name": "Core Features",
      "theme": "Primary user flows and business logic",
      "estimatedTasks": 12,
      "estimatedComplexity": "complex",
      "planFile": "phases/phase-2-core.md"
    },
    {
      "number": 3,
      "name": "Integration",
      "theme": "Billing, email, external services",
      "estimatedTasks": 6,
      "estimatedComplexity": "moderate",
      "planFile": "phases/phase-3-integration.md"
    },
    {
      "number": 4,
      "name": "Polish",
      "theme": "Error handling, loading states, accessibility",
      "estimatedTasks": 5,
      "estimatedComplexity": "simple",
      "planFile": "phases/phase-4-polish.md"
    },
    {
      "number": 5,
      "name": "Production",
      "theme": "Deployment, monitoring, documentation",
      "estimatedTasks": 4,
      "estimatedComplexity": "moderate",
      "planFile": "phases/phase-5-production.md"
    }
  ],
  "skills": {
    "foundation": ["auth-patterns", "database-modeling", "api-design", "error-handling"],
    "active": ["stripe-billing", "multi-tenancy", "email-integration"]
  },
  "totalEstimatedTasks": 35,
  "estimatedDuration": "3-5 phases, 2-4 sessions per phase",
  "tags": ["fullstack", "saas", "billing", "auth", "multi-tenant"]
}
```

### Phase Definitions

Each phase file in `phases/` contains rough task outlines --- not full task specs, but enough structure to accelerate `/plan-phase`:

```markdown
# Phase 1: Foundation

## Theme
Data model validation, authentication, project structure.

## Rough Tasks
1. Project scaffolding — monorepo setup, linting, CI config
2. Data model design — core entities, relationships, migration strategy
3. Database setup — connection, migrations, seed data
4. Auth system — registration, login, session management
5. Auth middleware — route protection, role-based access
6. Base API structure — router setup, error handling, validation layer
7. Base UI structure — layout, routing, theme, shared components
8. Development tooling — hot reload, debug config, test harness

## Dependencies
- Tasks 1-3 must complete before 4-8
- Tasks 4-5 are sequential (auth before middleware)
- Tasks 6-7 can run in parallel after task 3

## Exit Criteria
- User can register, log in, and access a protected route
- Database migrations run cleanly
- CI pipeline passes
- Base API responds to health check

## Common Gaps (from collective intelligence)
- Auth token refresh strategy often deferred — decide in this phase
- Database indexing strategy should be planned now, not retrofitted
- Error response format must be standardized before building endpoints
```

### Architecture Reference

The `architecture.md` file provides a reference architecture that the user can adopt, modify, or replace entirely. It includes system diagrams (in ASCII or Mermaid), data flow descriptions, module boundaries, and key architectural decisions that the template assumes.

### Known Gaps

The `known-gaps.md` file documents common unknowns and decision points for this project type. These are pre-loaded into `atlas/gaps.md` during setup, giving the user a head start on identifying what they do not know yet. Examples for a SaaS starter:

- Multi-tenancy strategy (shared database vs isolated schemas vs separate databases)
- Billing model (subscription tiers, usage-based, hybrid)
- Email provider selection and transactional email templates
- File upload strategy (S3 direct upload vs server proxy)
- Rate limiting approach (per-user, per-tenant, per-endpoint)

## Integration with Atlas Workflow

### During `/atlas-setup`

1. Atlas asks: "What type of project are you building?"
2. Lists available templates with short descriptions
3. User selects a template (or "none --- start blank")
4. Atlas reads `template.json` and presents the pre-filled structure:
   - "This template suggests 5 phases with ~35 tasks. Stack: TypeScript, React, PostgreSQL, Prisma, Stripe."
   - "Customize the stack? (Stripe can be swapped for Paddle or LemonSqueezy)"
5. User confirms or customizes
6. Atlas populates:
   - `project/overview.md` with template description (user edits)
   - `project/architecture.md` from template's `architecture.md` (user edits)
   - `atlas/gaps.md` from template's `known-gaps.md`
   - `memory/decisions.md` from template's `decisions.md`
   - `skills/foundation/` and `skills/active/` from template's curated skill pack
   - `phases/INDEX.md` with phase structure from template
7. User runs `/plan-phase 1` and gets a head start --- rough task outlines are already there

### During `/plan-phase`

When a template was used, `/plan-phase` reads the template's phase definition file for the current phase. It uses the rough task outlines as a starting point, refining them into full task specs based on the project's actual requirements and any customizations the user made.

### Custom Template Creation

After completing a project, `/atlas-retro` offers to create a template from it:

1. Extracts phase structure, task categories, skill usage
2. Anonymizes project-specific details
3. Generalizes task descriptions (e.g., "Build user dashboard" becomes "Build primary dashboard")
4. Packages into template directory structure
5. User can publish to marketplace via `/skill publish --template [name]`

This means every completed Atlas project can potentially become a template for the next developer building something similar.

## Planned Templates

### Free (shipped with Atlas)

| Template | Description |
|----------|-------------|
| `saas-starter` | Full-stack SaaS with auth, billing, multi-tenancy |
| `rest-api` | Backend API service with database, auth, validation |
| `cli-tool` | Command-line tool with argument parsing, config, output formatting |
| `open-source-library` | NPM/PyPI package with tests, docs, CI/CD, examples |

### Premium (marketplace)

| Template | Description | Why Premium |
|----------|-------------|-------------|
| `hipaa-saas` | HIPAA-compliant SaaS with audit logging, encryption at rest, BAA workflow | Deep compliance task breakdowns, compliance skill pack |
| `multi-tenant-b2b` | B2B SaaS with organization management, SSO, role hierarchy | Complex multi-tenancy patterns, calibrated estimates from collective intelligence |
| `realtime-collab` | Real-time collaborative app (CRDT-based) with presence, cursors, conflict resolution | Specialized CRDT skills, phased complexity management |
| `marketplace-platform` | Two-sided marketplace with listings, search, payments, reviews | Payment splitting skills, trust-and-safety patterns |
| `mobile-app` | React Native / Flutter mobile app with offline-first, push notifications | Platform-specific skill packs, deployment pipeline |
| `unity-game` | Unity game with game loop, input, physics, UI, audio | Unity-specific agent strategies, Editor setup scripts |
| `chrome-extension` | Chrome extension with content scripts, service worker, popup, options | Manifest V3 patterns, content script communication |

Premium templates include:
- Deeper task breakdowns (15-20 rough tasks per phase vs 5-8 for free)
- More curated skills (domain-specific patterns vs general)
- Calibrated estimates from collective intelligence (based on real project data)
- Pre-loaded decisions with trade-off analysis
- More comprehensive known-gaps lists

## Revenue Model

- **Free templates** ship with Atlas. Four general-purpose templates cover the most common project types.
- **Premium templates** are sold through the marketplace. Priced per template or as part of a subscription.
- **Community templates** are free to create, publish, and import. The marketplace hosts them alongside premium templates.
- Premium templates are maintained by the Atlas team, updated with collective intelligence data, and include guaranteed quality.
- Community templates are community-maintained with ratings and reviews.

## Prerequisites

This feature depends on:
- Stable Atlas file format (templates reference Atlas directory structure)
- Validated skill packs (templates bundle skills that must work)
- Marketplace infrastructure (for premium and community templates)
- Collective intelligence data (for calibrated estimates in premium templates)

## Status

Planned for v2. The template format and free templates could be developed earlier. Premium templates and community publishing require marketplace infrastructure.
