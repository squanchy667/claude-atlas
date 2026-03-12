---
name: atlas-init
description: Atlas atlas-init command
user-invocable: true
---

# Atlas Init

You are initializing the Claude Atlas folder structure in the current project directory.

## Step 1: Verify Git Repository

Check if the current directory is a git repository by running `git rev-parse --is-inside-work-tree`. If it is not, run `git init` to initialize one. Report the result.

## Step 2: Create Folder Structure

Create the following directory tree under the project root. If any directory already exists, skip it silently.

```
atlas/
project/
phases/
tasks/
skills/
  foundation/
  active/
  archive/
  imported/
hooks/
memory/
checkpoints/
  pending/
  passed/
status/
future/
team/
```

## Step 3: Create Core Files

Create the following files. If a file already exists, skip it and note that in the summary.

**atlas/**
- `setup.md` — Empty file with header: `# Atlas Setup Log`
- `commands.md` — Header: `# Available Commands` followed by a table listing all atlas commands: atlas-init, atlas-setup, atlas-run, plan-phase, task, checkpoint, complete-phase, skill, status. One row per command with name and one-line purpose.
- `workflow.md` — Header: `# Workflow` followed by the standard flow: setup > plan-phase > task plan > task start > implement > task complete > checkpoint > complete-phase. Write each step on its own line with a brief description.
- `gaps.md` — Header: `# Known Gaps` with an empty table: columns "ID", "Question", "Source", "Status", "Resolved In".

**project/**
- `overview.md` — Header: `# Project Overview` with placeholder sections: Name, Description, Problem, Target Users, Success Criteria, Anti-Goals, Risks.
- `architecture.md` — Header: `# Architecture` with placeholder sections: Stack, System Overview, Data Flow, Key Decisions.
- `data-model.md` — Header: `# Data Model` with a note: "Populated during /atlas-setup if data entities are discussed."
- `integrations.md` — Header: `# Integrations` with a note: "Populated during /atlas-setup if external services are discussed."

**phases/**
- `INDEX.md` — Header: `# Phase Index` with an empty table: columns "Phase", "Name", "Status", "Tasks", "Completed".

**skills/**
- `INDEX.md` — Header: `# Skills Index` with sections: Foundation, Active, Archive, Imported. Each section has an empty table: columns "Skill", "Category", "Created", "Status".

**hooks/**
- `file-tracker.sh` — Shell script stub with header comment: "# Tracks files modified during a task session" and a placeholder echo.
- `scope-guard.sh` — Shell script stub with header comment: "# Warns when modifications touch files outside the task's declared scope" and a placeholder echo.
- `session-end.sh` — Shell script stub with header comment: "# Runs at session end to capture state" and a placeholder echo.
- `test-integrity.sh` — Shell script stub with header comment: "# Validates test coverage after task completion" and a placeholder echo.

**memory/**
- `decisions.md` — Header: `# Decision Log` with columns "ID", "Date", "Decision", "Context", "Alternatives Considered", "Outcome".
- `mistakes.md` — Header: `# Mistakes Log` with columns "ID", "Date", "What Happened", "Root Cause", "Lesson", "Prevention".
- `patterns.md` — Header: `# Patterns` with columns "ID", "Pattern", "Context", "When To Use", "Example".
- `drift-log.md` — Header: `# Drift Log` with columns "ID", "Phase", "Task", "Type", "Severity", "Description", "Resolution".

**checkpoints/**
- `template.md` — A checkpoint template with sections: Task Reference, Agreement Summary, Checkpoint Parameters (table with "Parameter", "Expected", "Actual", "Status"), Self-Validation, Human Review, Decision (Approved / Revisions / Rejected).

**status/**
- `progress.md` — Header: `# Progress` with fields: Current Phase (none), Current Task (none), Last Completed (none), Setup Complete (no), Preview Approved (no).
- `blockers.md` — Header: `# Blockers` with an empty table: columns "ID", "Description", "Severity", "Blocked Tasks", "Status", "Resolution".

**Root files:**
- `CLAUDE.md` — Header: `# [Project Name] — Claude Atlas` with sections: Project (placeholder), Stack (placeholder), Phases (placeholder), Commands (list all 9 atlas commands with brief descriptions), Conventions (task numbering TXXX, branch naming feat/TXXX-name, commit format task(phase-N-task-N): description).
- `INDEX.md` — Header: `# Atlas Index` with a directory listing linking to each top-level folder and its purpose.

## Step 4: Make Hook Scripts Executable

Run `chmod +x hooks/*.sh` for all hook scripts created.

## Step 5: Report

Count the total directories created and files created (excluding those that already existed). Present the summary:

```
Atlas initialized.

Created: [N] directories, [M] files
Skipped: [K] (already existed)
Location: [absolute path]

Next step: Run /atlas-setup to define your project.
```
