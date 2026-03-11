# Atlas Setup

You are running the guided project definition conversation. This is the most important setup command. You will ask questions one at a time, wait for the user's response, and build out the project definition files as you go.

## Step 1: Verify Atlas Structure

Read `INDEX.md` at the project root. If it does not exist or does not contain "Atlas Index", stop and tell the user to run `/atlas-init` first.

## Step 2: Greet and Explain

Say:
"This conversation will define your project. I will ask you a series of questions, and your answers will populate the project definition files. By the end, you will have a complete project overview, architecture outline, phase map, foundation skills, and a gap report for anything we could not resolve. Take your time with each answer."

## Step 3: Ask Questions

Ask the following questions one at a time. Wait for the user's answer before proceeding to the next question. Do not skip ahead. Do not bundle questions.

**a.** "What is the name of your project?"
- Store as PROJECT_NAME.

**b.** "In one sentence, what does it do?"
- Store as ONE_LINER.

**c.** "What specific problem does it solve, and for whom?"
- Store as PROBLEM and TARGET_USERS.

**d.** "What is the tech stack? For each technology choice, briefly explain why you chose it."
- Store as STACK. Parse into categories: language, framework, database, infrastructure, etc.

**e.** "How many developers will work on this project?"
- If the answer is greater than 1, activate team mode:
  - Ask: "List each developer's name or handle and their specialty (e.g., 'Alex — backend, API design')."
  - Create `team/members.md` with a table: columns "Name", "Specialty", "Workstream", "Status". Fill with the provided developers. Set all statuses to "Active".
  - Note in `status/progress.md` that team mode is active.

**f.** "What does success look like? Give me 3-5 measurable outcomes."
- Store as SUCCESS_CRITERIA.

**g.** "What would make this project a failure?"
- Store as ANTI_GOALS.

**h.** "What is explicitly NOT in scope?"
- Store as OUT_OF_SCOPE.

**i.** "What are the rough phases you envision? Just the milestones, not the details."
- Store as PHASES. Parse into a numbered list with phase name and goal.

**j.** "What are the known risks or hard parts?"
- Store as RISKS.

**k.** "Any external services, APIs, or integrations?"
- Store as INTEGRATIONS. If none, note "None identified."

## Step 4: Write Project Files

As answers come in, fill files in real time. After all questions are answered, ensure these files are complete:

**project/overview.md:**
Write with sections: Name, One-Liner, Problem Statement, Target Users, Success Criteria (bulleted list), Anti-Goals (bulleted list), Out of Scope (bulleted list), Risks (bulleted list).

**project/architecture.md:**
Write with sections: Stack (table with Technology, Category, Rationale for each), System Overview (high-level description based on what was discussed), Key Decisions (any architectural decisions implied by the stack or problem).

**project/data-model.md:**
If data entities were mentioned in any answer, outline them here with fields and relationships. If none were discussed, write: "No data entities identified during setup. This file will be populated during phase planning."

**project/integrations.md:**
If integrations were mentioned, list each with: Name, Purpose, Auth Method (if known), Notes. If none, write: "No integrations identified during setup."

## Step 5: Create Foundation Skills

Based on the project type and stack, create foundation skill files in `skills/foundation/`. Each skill is a markdown file following this structure:

```markdown
# [Skill Name]

**Tier:** Foundation
**Category:** [category]
**Created:** [today's date]
**Status:** Active

## What It Solves
[one paragraph]

## Approach
[concrete steps]

## When To Use
[conditions]

## When NOT To Use
[conditions]

## Gotchas
[known pitfalls]
```

Create skills appropriate to the stack. Examples:
- For React projects: `react-component-patterns.md`, `state-management.md`
- For Express/Node projects: `api-endpoint-pattern.md`, `error-handling.md`
- For any project: `git-workflow.md`, `testing-strategy.md`

Update `skills/INDEX.md` with the created foundation skills.

## Step 6: Create Phase Map

For each phase identified in step 3i:
1. Create directory `phases/phase-[N]/`
2. Create `phases/phase-[N]/phase.md` with: Phase Name, Goal, Key Deliverables (bulleted), Entry Criteria, Exit Criteria, Dependencies on previous phases.
3. Create `phases/phase-[N]/INDEX.md` with header and empty task table.
4. Update `phases/INDEX.md` with the phase entry.

## Step 7: Update Root Files

**CLAUDE.md:** Update with:
- Project name and one-liner
- Stack summary
- Phase list with names
- Team members (if team mode)
- Any project-specific conventions implied by the stack

**INDEX.md:** Update with current project state, link to all populated files.

## Step 8: Generate Gap Report

Review all answers. For every question that was answered vaguely, partially, or with uncertainty, create an entry in `atlas/gaps.md`:
- Gap ID (G001, G002, ...)
- The question that remains open
- Source (which setup question triggered it)
- Status: OPEN
- Resolved In: (empty)

## Step 9: Update Progress

In `status/progress.md`, update:
- Setup Complete: yes
- Preview Approved: no (not yet)
- Current Phase: 1 (pending planning)
- Team Mode: yes/no

## Step 10: Present Full Preview

Present a complete preview report:

```
PROJECT PREVIEW: [PROJECT_NAME]
================================

[ONE_LINER]

Problem: [PROBLEM] for [TARGET_USERS]

Stack:
- [each technology with category]

Phases:
1. [Phase name] — [goal]
2. [Phase name] — [goal]
...

Foundation Skills Created:
- [skill name] ([category])
...

Success Criteria:
- [each criterion]

Known Gaps: [N]
- [list each gap briefly]

Team: [solo / N developers]
```

Then ask: "Does this look right? Tell me what to adjust before we proceed."

## Step 11: Handle Adjustments

If the user requests changes:
1. Apply each change to the relevant files.
2. Re-present only the changed sections.
3. Ask again: "Anything else to adjust?"

Repeat until the user approves.

## Step 12: Mark Approved

Once the user says it looks good:
1. Update `status/progress.md`: set "Preview Approved: yes"
2. Write the approval timestamp to `atlas/setup.md`

Present the final summary:

```
Setup complete for [PROJECT_NAME].

Files created/updated:
- project/overview.md
- project/architecture.md
- project/data-model.md
- project/integrations.md
- phases/INDEX.md
- phases/phase-[N]/phase.md (for each phase)
- skills/INDEX.md
- skills/foundation/[each skill]
- atlas/gaps.md
- status/progress.md
- CLAUDE.md
- INDEX.md
[- team/members.md (if team mode)]

Foundation skills: [list names]
Phases planned: [N]
Known gaps: [N] (see atlas/gaps.md)

Preview approved: yes
Next step: Run /plan-phase 1 to detail the first phase.
```
