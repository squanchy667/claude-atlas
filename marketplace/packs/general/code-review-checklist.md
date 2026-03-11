# Skill: Code Review Checklist

**Tier:** Foundation
**Category:** Workflow
**Created:** Marketplace
**Status:** Active
**Times Used:** 0

## What This Skill Solves
Code reviews that focus on style instead of substance miss real bugs. This skill provides a systematic checklist that catches issues that matter — correctness, security, performance, and maintainability.

## The Approach
Review in layers: correctness first, then security, then design, then style. Never start with style. A perfectly formatted function that has a security hole is not good code.

## When to Use This
- Every PR review
- Self-review before submitting a PR
- When onboarding a new reviewer to the team's standards

## When NOT to Use This
- Trivial changes (typo fixes, config updates) — scan, approve, move on
- Emergency hotfixes — review after merge, fix forward if needed

## Steps

### Layer 1: Correctness (most important)
1. Does the code do what the task agreement says it should?
2. Are edge cases handled? Empty inputs, null values, boundary conditions.
3. Are error paths handled? What happens when things fail?
4. Does it handle concurrent access correctly? Race conditions?
5. Are there off-by-one errors in loops or array access?

### Layer 2: Security
6. Is user input validated before use?
7. Are SQL queries parameterized (no string concatenation)?
8. Are secrets hardcoded anywhere?
9. Is authentication/authorization checked where needed?
10. Are there any open redirects, XSS vectors, or injection points?

### Layer 3: Design
11. Is this the simplest solution that works?
12. Does it follow existing patterns in the codebase?
13. Are there any unnecessary abstractions?
14. Is the data flow clear — can you trace input to output?
15. Are function/variable names accurate and descriptive?

### Layer 4: Operations
16. Will this work in production? (Environment differences, scale, timeouts)
17. Is there appropriate logging for debugging?
18. Are new dependencies justified and audited?
19. Is the change backward compatible or is migration needed?

### Layer 5: Tests
20. Do the tests actually test the behavior, not the implementation?
21. Are error paths tested?
22. Would you trust these tests to catch a regression?

## Example
PR: "Add password reset endpoint"
- Layer 1: Does the reset token expire? Is it single-use? What if the user doesn't exist?
- Layer 2: Is the token cryptographically random? Is the reset link HTTPS? Rate limited?
- Layer 3: Does it use the existing email service or create a new one?
- Layer 4: What happens if the email service is down?
- Layer 5: Is there a test for expired tokens?

## Gotchas
- Reviewing too much at once leads to rubber-stamping. Keep PRs under 400 lines.
- "Looks good to me" without specific observations is not a review.
- Style nitpicks belong in linters, not reviews. Configure the linter instead.
- If a review has more than 3 major issues, the PR should be reworked, not patched.

## Related Skills
- testing-strategy — tests must pass before review starts
- git-workflow — PR conventions and size limits
