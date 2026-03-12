# Atlas Setup Template — Blank

Copy this template, fill in your answers, then paste each one when `/atlas-setup` asks the corresponding question.

---

## Q1 — Project Name

> A short, memorable name. 1-3 words. This becomes folder names and references everywhere.

```
[Your Project Name]
```

## Q2 — Description

> One sentence: what does it do? Be specific about the WHAT, not the WHY.

```
[A ___ that ___ for ___.]
```

## Q3 — Problem

> Who has the problem? What is the pain? Why do existing solutions fail? Who is the target audience?
> The more specific you are here, the better Atlas scopes everything downstream.

```
[Problem description. Target audience. Why existing solutions don't work.]
```

## Q4 — Stack

> List every technology choice. Be explicit about versions, patterns, and architectural decisions.
> Atlas uses this to generate foundation skills and make architectural decisions.

```
[Language/Framework. Version. Architecture pattern. Database. UI framework. Build tools.
Testing framework. Deployment target. Version control.]
```

## Q5 — Team Size

> A number. If >1, Atlas activates team mode and asks follow-up questions about each developer.

```
[Number]
```

## Q6 — Success Criteria

> Bullet list of observable, testable outcomes. What does "done" look like?
> Each criterion should be something you can verify by looking at or using the product.

```
[- Criterion 1 (specific and testable)
- Criterion 2
- Criterion 3
- ...]
```

## Q7 — Failure Conditions

> What would make this project a failure even if it technically "works"?
> These are quality guardrails that prevent Atlas from shipping something that feels wrong.

```
[- Failure 1 (specific feeling or behavior to avoid)
- Failure 2
- ...]
```

## Q8 — Non-Scope

> What are you explicitly NOT building? Each item here prevents scope creep.
> Include the reason in parentheses so Atlas understands the boundary.

```
[- Feature X (reason it's out)
- Feature Y (reason it's out)
- ...]
```

## Q9 — Phases

> High-level milestones. Each phase should produce something visible/testable.
> Format: Phase N — Name: description. Result: what you can see/use after this phase.
>
> Good phase count by project size:
> - Simple (CLI, small game): 3-4 phases
> - Medium (web app, complex game): 5-7 phases
> - Large (full-stack SaaS, multiplayer): 7-10 phases

```
[Phase 1 — Name: What gets built. Result: what you can see/test.

Phase 2 — Name: What gets built. Result: what you can see/test.

Phase 3 — Name: What gets built. Result: what you can see/test.

...]
```

## Q10 — Risks

> What could go wrong? Technical unknowns, integration challenges, performance concerns.
> ALWAYS include a mitigation for each risk.

```
[- Risk 1. Mitigation: how you'll handle it.
- Risk 2. Mitigation: how you'll handle it.
- ...]
```

## Q11 — Integrations

> External services, APIs, packages, environment variables.
> If none, say "No external services. Fully offline."

```
[List of external dependencies, packages, APIs, env vars needed.
Or: No external services. Fully offline.]
```

---

## After Setup

1. **Review the preview** — Read every section Atlas generated. Fix anything wrong.
2. **Approve** — Lock in the plan.
3. **Run** — `/atlas-run --supervised` (first time) or `/atlas-run --full-permission` (autopilot).
