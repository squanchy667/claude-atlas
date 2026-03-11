# Skill

You are managing the skill system. Skills are reusable knowledge documents that capture patterns, approaches, and lessons. They live in the `skills/` directory hierarchy and are referenced by tasks during planning and execution.

Parse $ARGUMENTS to extract the action and optional name.

Expected format: `[create|promote|scan|import|publish|browse] [name?]`

Examples:
- `create react-form-patterns`
- `promote phase-1-task-3/api-error-handling`
- `scan`
- `import general/git-workflow`
- `import web-app`
- `publish api-error-handling`
- `browse`
- `browse general`

Extract:
- ACTION: one of create, promote, scan, import, publish, browse
- NAME: the skill name or path (optional for scan and browse)

---

## Action: create

Create a new skill from scratch.

### 1. Parse Skill Name

Extract the skill name from $ARGUMENTS. If no name is provided, ask: "What should this skill be called? Use kebab-case (e.g., 'react-form-patterns')."

### 2. Check for Duplicates

Read `skills/INDEX.md`.

Check `skills/active/` for a skill with a similar name or purpose. If a similar skill exists, say: "A similar active skill already exists: [name]. Are you sure you want to create a new one, or should you update the existing one?"

Check `skills/archive/` for a similar skill. If found, say: "A similar skill exists in the archive: [path]. Consider promoting it with `/skill promote [path]` instead of creating a new one."

If the user confirms they want a new skill, proceed.

### 3. Gather Definition

Ask the following questions. Wait for each answer.

a. "What problem does this skill solve?"
b. "What category does it belong to? (e.g., frontend, backend, testing, infrastructure, patterns, workflow)"
c. "Is this a permanent skill or a scaffold-only skill that is only useful during initial setup?"

### 4. Create Skill File

Determine the destination:
- If created during a task (check `status/progress.md` for an active task): create in the task directory and note for phase-end archival.
- If created during setup or outside a task: create in `skills/foundation/`.

Create `SKILL.md` (or `[name].md` in foundation):

```markdown
# [Skill Name]

**Tier:** [Foundation / Task / Active]
**Category:** [category]
**Created:** [today's date]
**Status:** Active

## What It Solves
[one paragraph describing the problem this skill addresses]

## Approach
[step-by-step approach — concrete, actionable steps]

## When To Use
[specific conditions or triggers that indicate this skill applies]

## When NOT To Use
[conditions where this skill is wrong or harmful]

## Steps
1. [step 1]
2. [step 2]
3. [step 3]

## Example
[a concrete example showing the skill applied]

## Gotchas
- [known pitfall 1]
- [known pitfall 2]

## Related Skills
- [other skill name] — [relationship]
```

### 5. Update Index

Add the skill to `skills/INDEX.md` in the appropriate section (Foundation, Active, or Archive) with columns: Skill, Category, Created, Status.

### 6. Confirm

Say: "Skill created: [name] in [location]. It is now available for task planning."

---

## Action: promote

Promote an archived skill to active status.

### 1. Parse Archive Path

Extract the archive path from $ARGUMENTS. This should be relative to `skills/archive/`. For example: `phase-1-task-3/api-error-handling`.

If the path is not provided or does not resolve to a file, list the contents of `skills/archive/` and ask the user to pick one.

### 2. Read the Skill

Read the skill's markdown file from `skills/archive/[path]`.

If the file does not exist, say: "No skill found at skills/archive/[path]. Use `/skill scan` to see available skills."

### 3. Present for Approval

Present the skill summary:

```
Skill Promotion Proposal
==========================
Name: [skill name]
Created in: [phase/task where it was created]
Category: [category]

What it solves:
[summary from the skill file]

Promote to active? This will make it available for all future tasks.
(yes / no)
```

### 4. Execute Promotion

If the user approves:
1. Move the skill file from `skills/archive/[path]/` to `skills/active/[skill-name].md`.
2. Update the skill's Tier field to "Active" and Status to "Active".
3. Update `skills/INDEX.md`: remove from Archive section, add to Active section.
4. Log the promotion: append to `memory/decisions.md` an entry noting the promotion, the reason, and the date.

If the user declines:
1. Leave the skill in archive.
2. Say: "Skill remains in archive. It can be promoted later."

---

## Action: scan

Scan available skills and match them to the current context.

### 1. Determine Context

Read `status/progress.md` to find the current phase and task.

If a task is active:
- Read `[task directory]/task.md` for the task definition.
- Read `[task directory]/agreement.md` if it exists.

If no task is active:
- Read the current phase's `phase.md` for general context.

### 2. Load Skill Index

Read `skills/INDEX.md` to get the full inventory.

### 3. Scan Each Category

**Foundation skills (skills/foundation/):** Read each skill file. Assess relevance to the current task or phase on a scale: HIGH, MEDIUM, LOW, NONE.

**Active skills (skills/active/):** Same assessment.

**Archive skills (skills/archive/):** Same assessment, but only for skills matching the current task's domain.

### 4. Present Results

Present a ranked list:

```
Skill Scan Results
===================

Relevant to: [current task or phase]

HIGH relevance:
  - [skill name] ([category]) — [one-line reason]
  - [skill name] ([category]) — [one-line reason]

MEDIUM relevance:
  - [skill name] ([category]) — [one-line reason]

LOW relevance:
  - [skill name] ([category]) — [one-line reason]

Not relevant: [count] skills

Gaps identified:
  - No skill exists for [specific challenge]. Consider: /skill create [suggested-name]
  - No skill exists for [specific challenge]. Consider: /skill create [suggested-name]
```

If no gaps are identified, say: "No skill gaps identified. Existing skills cover the current task's needs."

### 5. Suggest Actions

If archived skills scored HIGH relevance, suggest: "Consider promoting [skill name] from archive to active: `/skill promote [path]`"

If gaps were found, suggest specific skill creation commands.

---

## Action: import

Import a skill or skill pack from the marketplace.

### 1. Parse Argument

Extract the import target from $ARGUMENTS.

- If the argument contains a `/`, it is a specific skill (e.g., `general/git-workflow`). Split into pack name and skill name.
- If the argument has no `/`, it is a whole pack name (e.g., `web-app`).

### 2. Verify Existence

Check if the skill(s) exist in `marketplace/packs/[path]`.

- For a specific skill: check that `marketplace/packs/[pack]/[name].md` exists.
- For a whole pack: check that the directory `marketplace/packs/[pack]/` exists and contains `.md` files.

If not found, say: "No skill or pack found at marketplace/packs/[path]. Run `/skill browse` to see available packs."

### 3. Check for Duplicates

For each skill being imported, check `skills/active/` and `skills/foundation/` for skills with similar names or purposes.

If a similar skill exists, warn: "Existing skill [name] covers similar ground. Import anyway? (y/n)"

If the user declines, skip that skill and continue with the rest.

### 4. Import

**If importing a single skill:**
1. Read the skill file from `marketplace/packs/[pack]/[name].md`.
2. Create the directory `skills/imported/[name]/` if it does not exist.
3. Copy the skill content to `skills/imported/[name]/SKILL.md`.
4. Update `skills/INDEX.md` with the new imported skill in the "Imported (from Marketplace)" section.

**If importing a whole pack:**
1. List all `.md` files in `marketplace/packs/[pack]/`.
2. For each file:
   a. Read the skill file.
   b. Create the directory `skills/imported/[name]/` if it does not exist.
   c. Copy the skill content to `skills/imported/[name]/SKILL.md`.
   d. Update `skills/INDEX.md` with the imported skill.

### 5. Summary

Present: "Imported [N] skill(s) from [pack]: [list names]"

---

## Action: publish

Publish a project skill to the marketplace for sharing.

### 1. Find the Skill

Search for the skill in this order:
1. `skills/active/[name]/SKILL.md`
2. `skills/foundation/[name]/SKILL.md`
3. `skills/archive/`

If found in archive, warn: "This skill is archived. Promote it to active first, or publish from archive?"

If not found anywhere, say: "No skill named [name] found. Run `/skill scan` to see available skills."

### 2. Validate

Read the skill file and verify it contains all required sections:
- What It Solves
- Approach
- Steps
- Example
- Gotchas

If any section is missing, say: "Skill [name] is missing required section(s): [list]. Add them before publishing."

### 3. Create Marketplace Package

Create the directory `marketplace/community/[name]/` and add two files:

**SKILL.md** — Copy of the skill file.

**source.md** — Provenance metadata:
```markdown
# Source

- **Project**: [project name from CLAUDE.md PROJECT_NAME]
- **Author**: [git user name or "Anonymous"]
- **Date Published**: [today's date]
- **Original Tier**: [Foundation / Active / Archive]
- **Times Used**: [count from skills/INDEX.md or "Unknown"]
```

### 4. Update Marketplace Index

Add the skill to `marketplace/INDEX.md` under a "Community" section.

### 5. Confirm

Present: "Skill [name] published to marketplace/community/. To share with the Claude Atlas community, commit and push."

---

## Action: browse

Browse available skills in the marketplace.

### 1. Load Index

Read `marketplace/INDEX.md`.

### 2. Display

**If no pack is specified** (`/skill browse`):
- Display the full marketplace index: all packs with their skill counts.
- Then list all skills grouped by pack.

**If a pack is specified** (`/skill browse [pack]`):
- Display only that pack's skills with their "What It Solves" summaries.
- If the pack does not exist, say: "No pack named [pack] found. Run `/skill browse` to see all packs."

### 3. Call to Action

End with: "To import a skill: `/skill import [pack/name]`"
