# Skill: Documentation Patterns

**Tier:** Foundation
**Category:** Workflow
**Created:** Marketplace
**Status:** Active
**Times Used:** 0

## What This Skill Solves
Projects either have no documentation (new developers are lost) or too much documentation (nobody reads it, it's all outdated). This skill defines what to document, where, and how to keep it current.

## The Approach
Document decisions, not descriptions. Code describes itself. Documentation explains WHY, not WHAT. Keep docs close to code and automate updates where possible.

## When to Use This
- Setting up documentation strategy for a new project
- When existing docs are stale and need pruning
- Onboarding documentation for new team members

## When NOT to Use This
- API documentation — use OpenAPI/Swagger generated from code
- Code comments — those follow the codebase's own conventions

## Steps
1. **README.md** answers three questions: What is this? How do I run it? How do I contribute? Nothing else.
2. **Architecture decisions** go in `memory/decisions.md` (Atlas manages this). Each decision has context, alternatives, and reasoning.
3. **Setup guide** is a runnable script, not a doc. If it can't be a script, write steps that can be copy-pasted verbatim.
4. **API docs** are generated from code annotations (JSDoc, docstrings, OpenAPI). Never maintain API docs separately.
5. **Inline comments** explain WHY, never WHAT. `// Retry 3 times because the payment API has transient 503s` is good. `// Increment counter` is noise.
6. **Module-level docs** go in a comment at the top of the file: what this module does, who depends on it, key constraints.
7. **Runbooks** for operational tasks: deploy, rollback, database migration, incident response. Each is a numbered checklist.
8. **Delete stale docs** aggressively. Wrong docs are worse than no docs. If in doubt, delete.
9. **Link, don't duplicate.** If something is documented in one place, link to it from other places. Never copy.
10. **Review docs in PRs.** If code changes, check if docs need updating. Make it part of the review checklist.

## Example
Good README structure:
```
# Project Name
One-sentence description.

## Quick Start
\`\`\`bash
git clone ... && cd ... && npm install && npm run dev
\`\`\`

## Architecture
[Link to architecture decision records]

## Contributing
[Link to contributing guide]
```

Bad README: 3000 words about the project philosophy, installation instructions for 5 operating systems, a full API reference that's outdated.

## Gotchas
- Documentation debt compounds faster than code debt. Prune regularly.
- Generated docs (API, types) should be in .gitignore, generated on build.
- Screenshots go stale instantly. Use them sparingly and date them.
- Wikis die. Keep docs in the repo where they're versioned with the code.

## Related Skills
- code-review-checklist — docs review is part of PR review
