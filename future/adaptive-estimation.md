# Future Feature: Adaptive Estimation

> Planned for v2-v3. Personal estimation tracking could ship earlier.

## Overview

Adaptive Estimation is a calibration system that tracks estimated vs actual effort for every task, then uses that history to adjust future estimates. Instead of guessing how long a task will take based on intuition, Atlas provides data-driven estimates calibrated against your own track record and the collective experience of all Atlas users.

Every developer has estimation blind spots. Some consistently underestimate auth tasks. Others overestimate UI work. These biases are invisible until you track them. Adaptive Estimation makes them visible and corrects for them automatically.

## Data Sources

### Personal History

Your own completed tasks with estimation data, stored locally at `~/.atlas/intelligence/personal/calibration.json`.

**Collected from each completed task:**
- **Estimated complexity** from `agreement.md`: simple, moderate, or complex
- **Task category** inferred from task description and files changed: auth, database, API, UI, integration, infrastructure, testing, documentation
- **Actual effort indicators** from `outcome.md` and project tracking:
  - Files changed (count)
  - Lines of code added/modified (from git diff)
  - Drift entries (count and severity)
  - Checkpoint revisions (count)
  - Skills used (count --- more skills suggests more complexity)
  - Blockers encountered (count)

### Collective Intelligence

Aggregated estimation data from all Atlas projects, stored in `marketplace/intelligence/[project-type]/`.

**Provides:**
- Baseline estimation accuracy per task category per project type
- Common underestimation patterns (e.g., "auth tasks in SaaS projects are underestimated 65% of the time")
- Adjustment factors per task category (e.g., "multiply auth task estimates by 1.4")

## The Calibration Model

### Complexity Levels

Atlas uses five complexity levels, mapped to concrete indicators:

| Level | Files Changed | Drift Events | Revisions | Description |
|-------|--------------|-------------|-----------|-------------|
| Trivial | 1-2 | 0 | 0 | Config change, typo fix, minor adjustment |
| Simple | 2-4 | 0 | 0 | Single-concern task with clear scope |
| Moderate | 4-8 | 0-1 | 0-1 | Multi-file change, some integration points |
| Complex | 8-15 | 1-3 | 0-2 | Cross-cutting concern, multiple integration points |
| Very Complex | 15+ | 3+ | 2+ | Architectural change, many unknowns |

Agreements use three levels (simple, moderate, complex). The calibration model uses five to provide finer granularity in the actual-effort measurement. A task estimated as "moderate" that turns out to be "complex" is a one-level miss; one that turns out to be "very complex" is a two-level miss.

### Per-Category Calibration

The calibration model tracks accuracy per task category:

```json
{
  "calibration": {
    "auth": {
      "sampleSize": 12,
      "estimatedSimple": { "actualTrivial": 0, "actualSimple": 3, "actualModerate": 5, "actualComplex": 1, "actualVeryComplex": 0 },
      "estimatedModerate": { "actualTrivial": 0, "actualSimple": 0, "actualModerate": 2, "actualComplex": 1, "actualVeryComplex": 0 },
      "estimatedComplex": { "actualTrivial": 0, "actualSimple": 0, "actualModerate": 0, "actualComplex": 0, "actualVeryComplex": 0 },
      "adjustmentFactor": 1.4,
      "accuracyRate": 0.42,
      "dominantBias": "underestimate"
    },
    "database": {
      "sampleSize": 8,
      "estimatedSimple": { "actualTrivial": 1, "actualSimple": 3, "actualModerate": 1, "actualComplex": 0, "actualVeryComplex": 0 },
      "estimatedModerate": { "actualTrivial": 0, "actualSimple": 0, "actualModerate": 2, "actualComplex": 1, "actualVeryComplex": 0 },
      "estimatedComplex": { "actualTrivial": 0, "actualSimple": 0, "actualModerate": 0, "actualComplex": 0, "actualVeryComplex": 0 },
      "adjustmentFactor": 1.15,
      "accuracyRate": 0.63,
      "dominantBias": "slight_underestimate"
    },
    "api": {
      "sampleSize": 15,
      "adjustmentFactor": 1.0,
      "accuracyRate": 0.87,
      "dominantBias": "calibrated"
    },
    "ui": {
      "sampleSize": 10,
      "adjustmentFactor": 0.9,
      "accuracyRate": 0.70,
      "dominantBias": "slight_overestimate"
    }
  }
}
```

**Adjustment factor calculation:**

The adjustment factor is a rolling weighted average of (actual complexity / estimated complexity) across all tasks in the category. It is used to adjust future estimates:

```
adjusted_estimate = original_estimate * adjustment_factor
```

An adjustment factor of 1.4 means "tasks in this category historically take 40% more effort than you estimate." A factor of 0.9 means "you tend to slightly overestimate this category."

The rolling average weights recent projects more heavily than older ones (exponential decay with half-life of 3 projects). This allows the model to adapt as the developer improves.

### Blending Personal and Collective

When both personal and collective data are available, they are blended based on the developer's sample size:

```
If personal sample size < 5:
    weight_personal = 0.2
    weight_collective = 0.8

If personal sample size 5-15:
    weight_personal = 0.5
    weight_collective = 0.5

If personal sample size > 15:
    weight_personal = 0.8
    weight_collective = 0.2
```

This means:
- New Atlas users get collective calibration from day one (no cold start)
- After 2-3 projects, personal data starts to matter equally
- After 5+ projects, personal calibration dominates (your data is more relevant than the average)

For task categories with zero personal data, the collective calibration is used entirely. For task categories with zero collective data (rare or novel task types), personal data is used entirely. If neither exists, no calibration is applied and the raw estimate is used.

## Integration Points

### During `/plan-phase`

When planning a phase, Atlas categorizes each task and applies calibration:

```
Phase 3 Planning — Calibrated Estimates
─────────────────────────────────────────

T015: Payment Integration
  Category: integration
  Your estimate: moderate
  Calibration: Your integration tasks at moderate → actually complex 60% of the time
  Adjusted estimate: moderate-complex
  Collective data: Integration tasks in SaaS projects average 1.3x estimated effort
  Recommendation: Plan for complex. Allocate extra time for webhook handling.

T016: Email Notifications
  Category: integration
  Your estimate: simple
  Calibration: Your integration tasks at simple → accurate 80% of the time
  Adjusted estimate: simple (no adjustment)

T017: Admin User Management
  Category: ui
  Your estimate: moderate
  Calibration: Your UI tasks at moderate → actually moderate 85% of the time
  Adjusted estimate: moderate (no adjustment)
  Note: You slightly overestimate UI tasks. This might actually be simpler.
```

Atlas presents calibrated estimates alongside original estimates. The human decides whether to accept the adjustment. Atlas never silently changes an estimate --- it recommends and the human confirms.

### During `/task plan`

When planning an individual task, Atlas surfaces relevant calibration data:

```
Planning T015: Payment Integration
───────────────────────────────────
Category: integration
Your estimate: moderate

Calibration Warning:
- Your last 8 integration tasks estimated as moderate: 5 were actually complex
- Common causes: underestimated webhook complexity (3 times), missed error handling scope (2 times)
- Collective data: 65% of SaaS payment integration tasks exceed their estimates

Suggestion: Consider estimating as complex. Key areas to scope carefully:
- Webhook signature validation and retry handling
- Idempotency for payment events
- Error recovery for partial payment states
```

### During `/atlas-retro`

The retrospective calculates estimation accuracy for the entire project and updates the calibration model:

```
Estimation Accuracy Report
──────────────────────────

Overall: 72% (25/35 tasks within one complexity level)

By Category:
  Auth:          42% (underestimate bias — adjustment factor: 1.4 → 1.35)
  Database:      63% (slight underestimate — adjustment factor: 1.15 → 1.12)
  API:           87% (calibrated — no adjustment needed)
  UI:            70% (slight overestimate — adjustment factor: 0.9 → 0.92)
  Integration:   60% (underestimate bias — adjustment factor: 1.3 → 1.28)
  Infrastructure: 90% (calibrated — no adjustment needed)

Biggest Misses:
  T015 (Payment Integration): estimated simple, was very complex
    Root cause: webhook handling and idempotency were not scoped
  T012 (Auth Middleware): estimated simple, was complex
    Root cause: token refresh strategy not decided upfront
```

### Connection to Cost Tracking

When calibration data is available, Atlas can estimate token cost for a phase:

```
Phase 3 Cost Estimate
─────────────────────
7 tasks, calibrated total complexity: 3 simple, 2 moderate, 2 complex

Estimated tokens per complexity level (from your history):
  Simple:    ~8K tokens per task
  Moderate:  ~15K tokens per task
  Complex:   ~30K tokens per task

Estimated total: ~120K tokens for Phase 3
Confidence: moderate (based on 35 completed tasks)
```

This gives the user a concrete cost estimate before starting a phase, based on real data rather than guesswork.

### During `/atlas-setup`

When starting a new project, if calibration data exists:

```
Project Setup — Estimation Calibration
───────────────────────────────────────
Using calibration from 4 completed projects (35 tasks total)

Your estimation profile:
  Strength: API tasks (87% accurate), Infrastructure (90% accurate)
  Watch out: Auth tasks (42% accurate — you underestimate by ~40%)
  Watch out: Integration tasks (60% accurate — you underestimate by ~30%)

Recommendation for this SaaS project:
  - Auth and integration phases will likely take longer than you think
  - Consider breaking auth tasks into smaller pieces
  - Budget extra time for integration phase

Collective data for SaaS projects (127 projects):
  - Average total tasks: 35 (range: 15-80)
  - Most underestimated: payment integration, auth, multi-tenancy
  - Most overestimated: documentation, basic CRUD endpoints
  - Average estimation accuracy: 68%
```

## Data Storage

### Personal Calibration

Stored at `~/.atlas/intelligence/personal/calibration.json`:

```json
{
  "version": "1.0.0",
  "lastUpdated": "2026-03-15",
  "projectCount": 4,
  "totalTasks": 35,
  "overallAccuracy": 0.72,
  "calibration": {
    "auth": { "...": "see per-category model above" },
    "database": { "...": "" },
    "api": { "...": "" },
    "ui": { "...": "" },
    "integration": { "...": "" },
    "infrastructure": { "...": "" },
    "testing": { "...": "" },
    "documentation": { "...": "" }
  },
  "costPerComplexity": {
    "trivial": { "avgTokens": 3000, "sampleSize": 5 },
    "simple": { "avgTokens": 8000, "sampleSize": 12 },
    "moderate": { "avgTokens": 15000, "sampleSize": 10 },
    "complex": { "avgTokens": 30000, "sampleSize": 6 },
    "veryComplex": { "avgTokens": 55000, "sampleSize": 2 }
  },
  "projects": [
    {
      "slug": "chat-agent",
      "type": "fullstack-saas",
      "taskCount": 15,
      "accuracy": 0.67,
      "completedDate": "2026-02-01"
    },
    {
      "slug": "dira-finder",
      "type": "chrome-extension",
      "taskCount": 20,
      "accuracy": 0.80,
      "completedDate": "2026-02-15"
    }
  ]
}
```

### Collective Calibration

Stored in `marketplace/intelligence/[project-type]/estimation.json`:

```json
{
  "projectType": "saas",
  "projectCount": 127,
  "totalTasks": 4445,
  "lastUpdated": "2026-03-01",
  "calibration": {
    "auth": { "adjustmentFactor": 1.35, "accuracyRate": 0.55, "sampleSize": 320 },
    "database": { "adjustmentFactor": 1.10, "accuracyRate": 0.72, "sampleSize": 280 },
    "api": { "adjustmentFactor": 1.05, "accuracyRate": 0.82, "sampleSize": 450 },
    "ui": { "adjustmentFactor": 0.95, "accuracyRate": 0.75, "sampleSize": 380 },
    "integration": { "adjustmentFactor": 1.30, "accuracyRate": 0.58, "sampleSize": 210 },
    "infrastructure": { "adjustmentFactor": 1.02, "accuracyRate": 0.88, "sampleSize": 150 }
  },
  "commonUnderestimates": [
    { "category": "auth", "pattern": "Token refresh strategy", "frequency": 0.65 },
    { "category": "integration", "pattern": "Webhook error handling", "frequency": 0.55 },
    { "category": "database", "pattern": "Migration rollback strategy", "frequency": 0.40 }
  ],
  "commonOverestimates": [
    { "category": "documentation", "pattern": "API documentation generation", "frequency": 0.50 },
    { "category": "api", "pattern": "Basic CRUD endpoints", "frequency": 0.35 }
  ]
}
```

## Task Category Detection

Atlas categorizes tasks automatically based on:

1. **Task title keywords:** "auth", "login", "payment", "database", "API", "UI", "dashboard", "deploy"
2. **Files changed:** File extensions and paths indicate category (`.prisma` = database, `components/` = UI, `middleware/` = auth/API)
3. **Skills used:** Skills have categories that map to task categories
4. **Manual override:** The developer can correct the category in the agreement if auto-detection is wrong

Category detection does not need to be perfect. It is used for calibration, not for execution. Miscategorized tasks add noise to the calibration model but do not break anything. Over time, with enough data, the noise averages out.

## Confidence Intervals

As the calibration model matures, it can provide confidence intervals:

```
T015: Payment Integration
  Estimated complexity: moderate
  Calibrated estimate: complex (adjustment factor: 1.3)
  Confidence: 65% (based on 8 similar tasks)
  Range: moderate (20%) | complex (65%) | very complex (15%)
```

Low confidence means the model does not have enough data for this category. High confidence means the prediction is reliable. This helps the human decide how much to trust the calibrated estimate.

## Privacy

All personal calibration data stays on the user's machine. It is never uploaded without explicit consent. When published to collective intelligence via `/atlas-retro`, the data is:
- Stripped of project names and identifiers
- Aggregated into category-level statistics
- Merged with existing collective data (individual records are not stored)

## Status

- **Personal estimation tracking** could ship in v1.5 as part of `/atlas-retro`. Only requires local storage and outcome.md parsing.
- **Calibration display in `/plan-phase`** could ship in v1.5 if personal tracking is available.
- **Collective calibration** requires marketplace intelligence infrastructure (v2).
- **Cost estimation** requires token tracking per task, which is not yet implemented.
- **Confidence intervals** require sufficient sample sizes (v3, after enough data accumulates).
