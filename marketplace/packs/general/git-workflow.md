# Skill: Git Workflow

**Tier:** Foundation
**Category:** Workflow
**Created:** Marketplace
**Status:** Active
**Times Used:** 0

## What This Skill Solves
Inconsistent branching, messy commit history, and unclear PR processes waste time and create merge conflicts. This skill establishes a clear git workflow that scales from solo to team.

## The Approach
Use trunk-based development with short-lived feature branches. Every branch maps to a task. Every commit tells a story. PRs are small and focused.

## When to Use This
- Starting any new project
- Onboarding a new developer to the workflow
- When git history has become messy and needs reset

## When NOT to Use This
- Monorepo setups may need modified branching (per-package branches)
- Open source projects with external contributors need fork-based flow instead

## Steps
1. Main branch is always deployable. Never commit directly to main.
2. Create feature branches from main: `feat/phase-N-task-M-description`
3. Keep branches short-lived: 1-3 days maximum. If longer, break the task down.
4. Commit messages follow: `type(scope): description`
   - Types: feat, fix, refactor, test, docs, chore
   - Scope: the module or component affected
   - Example: `feat(auth): add JWT token refresh on 401 response`
5. Commit frequently — each commit is one logical change that compiles and passes tests.
6. Rebase on main before creating a PR (not merge — keeps history linear).
7. PR title matches the task: `[Phase N] TXXX: Brief description`
8. PR body links to the task agreement and lists checkpoint parameters.
9. Squash merge to main. The squash message is the PR title.
10. Delete the branch after merge.

## Example
```
git checkout -b feat/phase-1-task-3-user-auth
# ... work ...
git commit -m "feat(auth): add login endpoint with JWT"
git commit -m "feat(auth): add token refresh middleware"
git commit -m "test(auth): add login and refresh tests"
git rebase main
git push -u origin feat/phase-1-task-3-user-auth
# Create PR, get review, squash merge
```

## Gotchas
- Never force-push to main. Force-push to feature branches is fine after rebase.
- If two developers touch the same files, coordinate before both pushing. Atlas collision detection helps here.
- Stale branches (older than 3 days) are a smell — the task is too big or blocked.
- Always pull main before creating a new branch.

## Related Skills
- code-review-checklist — what to check before approving PRs
- testing-strategy — tests must pass before merge
