# Setup Guide

This document explains how to initialize and configure a Claude Atlas project. There are two commands: `/atlas-init` creates the folder structure, and `/atlas-setup` fills it with your project definition.

---

## Setup Status

- **Setup Complete:** yes
- **Preview Approved:** yes
- **Approved:** 2026-03-11
- **Gaps at setup:** 7 (all resolved)
- **Decisions logged:** 9 (see memory/decisions.md)

---

## /atlas-init -- Create the Structure

Run this once at the beginning. It creates every folder and placeholder file that Atlas needs.

### What It Does (Step by Step)

1. Verifies the current directory is a git repository.
2. Creates the folder structure:
   ```
   project/          -- overview.md, architecture.md, data-model.md, integrations.md
   phases/           -- (empty, filled by /plan-phase)
   tasks/            -- (empty, filled by /plan-phase)
   checkpoints/
     pending/
     passed/
   skills/
     INDEX.md
     foundation/
     active/
     archive/
     imported/
   memory/           -- decisions.md, mistakes.md, patterns.md
   status/           -- progress.md, blockers.md, drift.md
   team/             -- workstreams.md, sync-log.md
   hooks/            -- (empty, for automation scripts)
   atlas/            -- setup.md, commands.md, workflow.md, gaps.md
   ```
3. Creates CLAUDE.md with the agent protocol template.
4. Creates INDEX.md with the switchboard template.
5. Initializes all memory files with headers and empty sections.
6. Initializes skills/INDEX.md with the skill registry format.
7. Initializes status files with headers.
8. Reports what was created.

### After Init

The structure exists but contains no project-specific content. Run `/atlas-setup` next.

---

## /atlas-setup -- Define Your Project

This is a guided conversation. Claude asks questions, you answer, and Atlas fills the spec files. The conversation follows a fixed sequence.

### The Conversation Sequence

#### 1. Project Identity
- **Project name** -- What is this project called?
- **Project type** -- What kind of software is this? (web app, CLI tool, library, game, mobile app, API service, etc.)
- **Description** -- One to three sentences. What does it do and for whom?

#### 2. Tech Stack
- **Languages and frameworks** -- What are you building with?
- **Rationale** -- Why these choices? (Atlas stores the reasoning, not just the names.)
- **Infrastructure** -- Where does it run? (cloud provider, hosting, database, etc.)

#### 3. Team Size
- **How many developers?** -- If more than one, Atlas activates team mode.
- **If team mode**: Who are the developers? What are their strengths? (Used for workstream assignment.)

#### 4. Success Criteria
- **What does success look like?** -- Concrete, measurable outcomes.
- **Hard failure conditions** -- What would make this project a failure? (Atlas watches for these.)

#### 5. Phase Outline
- **Rough phases** -- What are the major stages of this project?
- You do not need detailed tasks yet. Just the themes: "Foundation", "Core Features", "Integration", "Polish", etc.
- Atlas will break these into tasks later with `/plan-phase`.

#### 6. Known Risks
- **What could go wrong?** -- Technical risks, unknowns, dependencies on external systems.
- These become the initial entries in `atlas/gaps.md`.

### What Gets Filled

After the conversation, Atlas writes:

| File | Content |
|------|---------|
| `project/overview.md` | Name, type, description, success criteria, failure conditions |
| `project/architecture.md` | Tech stack, high-level system design, module boundaries |
| `project/data-model.md` | Initial data entities (if discussed), placeholder if not |
| `project/integrations.md` | External services, APIs, auth flows (if discussed), placeholder if not |
| `phases/phase-N/phase.md` | One plan file per phase with theme and rough scope |
| `skills/foundation/` | Foundation skills based on project type (e.g., react patterns, express conventions) |
| `atlas/gaps.md` | Known risks converted to gap entries |
| `CLAUDE.md` | Project details section filled with actual values |
| `INDEX.md` | Project state updated |
| `status/progress.md` | Initialized with phase list |

### Foundation Skills

Based on the project type, Atlas creates starter skills in `skills/foundation/`. Examples:

- **Web app (React)**: component patterns, state management conventions, routing structure
- **API service (Express)**: endpoint conventions, error handling, middleware patterns
- **CLI tool**: argument parsing conventions, output formatting, error codes
- **Game (Unity)**: scene structure, prefab conventions, event patterns

These are not generic -- they are tailored to the specific tech stack declared in the conversation.

### Gap Report

After filling everything, Atlas generates a gap report:

- What questions were not answered during setup
- What is assumed but not confirmed
- What will need to be resolved before certain phases can start

Each gap gets an entry in `atlas/gaps.md` with a unique ID and status.

### Preview

At the end of setup, Atlas offers `/atlas-preview`. This is the final step before execution:

- Displays the full project definition
- Shows the phase map with rough scope
- Lists all foundation skills created
- Lists all open gaps
- Asks: "Does this look right? Approve to proceed, or tell me what to change."

The human must approve the preview before `/atlas-run` can execute.

---

## Verifying Setup

After `/atlas-setup` completes, verify:

1. `project/overview.md` has name, type, description, success criteria, and failure conditions.
2. `project/architecture.md` has tech stack and at least a high-level module list.
3. `phases/` has one plan file per phase with a theme.
4. `skills/foundation/` has at least one skill for the project type.
5. `atlas/gaps.md` has entries for any unanswered questions or known risks.
6. `CLAUDE.md` project details section is filled (no `[NOT CONFIGURED]` placeholders).
7. `INDEX.md` project state shows the correct project name and phase count.

If any of these are missing, run `/atlas-setup` again. It is idempotent -- it will fill what is missing without overwriting what exists.

---

## Incomplete Setup

If setup was interrupted or partially completed:

- Run `/atlas-setup` again. It detects existing content and only asks about what is missing.
- Alternatively, fill the files manually following the templates in each file.
- Run `/status` to see what Atlas thinks is configured and what is not.
