# Future Feature: Plugin System

> Planned for v2. Scaffolding command could ship earlier. Sharing requires marketplace infrastructure.

## Overview

The Plugin System enables users to create, share, and import custom Atlas commands beyond the core set. Atlas provides the framework, conventions, and scaffolding tools. The community builds domain-specific extensions.

This is not a traditional plugin system with APIs and hooks. Claude Code commands are markdown files in `.claude/commands/`. A "plugin" in Atlas is simply a well-structured command file that follows Atlas conventions --- respecting agreements, updating status, committing properly, and integrating with the Atlas file structure. The Plugin System provides tooling to create these commands correctly, share them through the marketplace, and import them with dependency resolution.

## How Commands Work in Claude Code

Claude Code loads markdown files from `.claude/commands/` as slash commands. Each file becomes a command:
- `.claude/commands/deploy.md` becomes `/deploy`
- `.claude/commands/security-audit.md` becomes `/security-audit`

The markdown content is the prompt that Claude follows when the command is invoked. There is no compilation, no API, no runtime --- just a markdown file that instructs Claude how to behave.

Atlas extends this by establishing conventions for how commands should interact with Atlas's file structure, tracking systems, and workflow rules.

## The `/atlas-extend` Command

### Creating a New Command

```
/atlas-extend [name]
```

Scaffolds a new command file in `.claude/commands/` with the correct structure for Atlas integration.

**Interactive process:**

1. Atlas asks: "What should this command do?" (one-sentence description)
2. Atlas asks: "What files does it read?" (Atlas files it needs for context)
3. Atlas asks: "What files does it write or modify?" (Atlas files it changes)
4. Atlas asks: "Does it require any skills?" (skill dependencies)
5. Atlas generates the command file with all Atlas conventions built in

**Generated command structure:**

```markdown
# /[name] — [One-sentence description]

## Purpose
[What this command does and when to use it]

## Prerequisites
- [Required files that must exist]
- [Required skills that must be imported]
- [Required project state (e.g., "at least one phase completed")]

## Inputs
- [What the user provides when invoking the command]
- [Optional parameters]

## Process

### Step 1: Context Loading
Read the following files:
- [List of Atlas files this command needs]
- [Any project-specific files]

### Step 2: Validation
Before proceeding, verify:
- [Pre-conditions that must be true]
- [Files that must exist]
- [State requirements]

### Step 3: [Core action]
[Detailed instructions for what Claude should do]
[Reference specific Atlas conventions]

### Step 4: [Additional steps as needed]
[Each step should be concrete and actionable]

### Step 5: Update Atlas State
After completing the core action:
- Update `status/progress.md` with what changed
- If any drift occurred, log in the appropriate `drift.md`
- If decisions were made, log in `memory/decisions.md`

### Step 6: Commit
Commit changes with message format: `[command-name] Brief description of what was done`

### Step 7: Summary
Output a summary with:
- What was done
- Files created or modified
- Any issues or warnings
- Recommended next steps

## Error Handling
- If [condition], then [recovery action]
- If a required file is missing, stop and tell the user what to create
- Never silently skip steps — report what was skipped and why

## Metadata
- **Author:** [username]
- **Version:** 1.0.0
- **Requires skills:** [list or "none"]
- **Atlas version:** >=1.0.0
```

### Publishing a Command

```
/atlas-extend --publish [name]
```

Packages a command for sharing to the marketplace:

1. Validates that the command file follows the Atlas command format
2. Checks that all sections are present (purpose, prerequisites, process, error handling, metadata)
3. Extracts metadata (author, version, skill dependencies)
4. Creates a package in `marketplace/commands/[author]/[name]/`:
   - `command.md` --- the command file itself
   - `metadata.json` --- extracted metadata for indexing
   - `README.md` --- auto-generated description for marketplace listing
5. If the command depends on skills, verifies those skills exist in the marketplace

## Importing Commands

```
/atlas-import-command @[author]/[name]
```

Imports a command from the marketplace into the current project:

1. Reads `marketplace/commands/[author]/[name]/metadata.json`
2. Checks skill dependencies --- if the command requires skills, checks if they are available:
   - Already imported in the project? Continue.
   - Available in marketplace? Offer to import.
   - Not available? Warn and ask whether to proceed without.
3. Copies `command.md` to `.claude/commands/[name].md`
4. Reports what was imported and any dependency actions taken

```
Imported: /deploy from @jane/deploy
Dependencies:
  - logging-observability skill (already imported)
  - aws-deployment skill (imported from marketplace)
Location: .claude/commands/deploy.md
```

## Example Community Commands

### `/deploy` --- Deployment with Rollback Tracking

Manages deployments with environment awareness and rollback capability.

**What it does:**
1. Reads `project/architecture.md` for deployment targets
2. Reads `status/progress.md` to verify the current phase is complete
3. Runs deployment scripts (user-configured per environment)
4. Records deployment in `deployments/deploy-[timestamp].md` with: version, environment, commit hash, deployer, rollback instructions
5. If deployment fails, provides rollback command and logs the failure
6. Updates `status/progress.md` with deployment status

**Why it is a plugin, not core:** Deployment workflows are highly project-specific. The core Atlas does not assume any deployment target.

### `/security-audit` --- OWASP Security Checklist

Scans the codebase against common security vulnerabilities.

**What it does:**
1. Reads the codebase structure
2. Checks against OWASP Top 10 categories
3. Scans for: hardcoded secrets, SQL injection vectors, XSS vulnerabilities, insecure dependencies, missing auth checks, exposed error details
4. Generates `audits/security-[date].md` with findings, severity, and remediation suggestions
5. Creates tasks for critical findings (if approved by human)

**Required skills:** security-patterns (foundation), error-handling (general pack)

### `/performance-check` --- Benchmark Against Criteria

Runs performance benchmarks against criteria defined in the project's agreement.

**What it does:**
1. Reads agreement.md files for performance criteria (response times, memory limits, etc.)
2. Runs configured benchmark scripts
3. Compares results to criteria
4. Generates `audits/performance-[date].md` with pass/fail per criterion
5. Flags any criteria that are close to failing (within 20% of threshold)

### `/changelog` --- Generate Changelog from Outcomes

Generates a structured changelog from outcome.md files.

**What it does:**
1. Reads all `outcome.md` files for a given phase range or release tag
2. Groups outcomes by category (features, fixes, improvements, breaking changes)
3. Generates `CHANGELOG.md` entry with conventional changelog format
4. Links to relevant tasks and PRs

### `/handoff` --- Generate Developer Handoff Document

Creates a comprehensive context document for passing the project to another developer.

**What it does:**
1. Reads: overview, architecture, data model, decisions, current progress, active blockers, known gaps
2. Generates a single handoff document with: project summary, current state, architecture overview, key decisions and rationale, active work and blockers, setup instructions, known issues
3. Writes to `handoff/handoff-[date].md`

### `/estimate` --- Historical Estimation

Estimates a task or phase using historical data and collective intelligence.

**What it does:**
1. Reads the task or phase specification
2. Categorizes each task by type (auth, database, API, UI, etc.)
3. Checks personal calibration data (if available)
4. Checks collective intelligence for the project type (if available)
5. Provides calibrated estimates with confidence intervals
6. Flags task types where the user historically underestimates

**Required skills:** None, but requires `~/.atlas/intelligence/personal/calibration.json` for personal estimates or marketplace intelligence data for collective estimates.

## Guidelines for Community Commands

Commands published to the marketplace must follow these guidelines. The `/atlas-extend --publish` command validates these before allowing publication.

### Required Sections

Every command must include:
1. **Purpose:** Clear one-paragraph description of what the command does
2. **Prerequisites:** Files, skills, and project state required
3. **Inputs:** What the user provides when invoking
4. **Process:** Step-by-step instructions with numbered steps
5. **Error handling:** How to handle common failures
6. **Metadata:** Author, version, skill dependencies, Atlas version compatibility

### Atlas Integration Rules

Commands must:
- **Respect agreements.** Never modify an approved agreement's acceptance criteria or checkpoint parameters.
- **Update status.** If the command changes project state, update `status/progress.md`.
- **Log drift.** If the command discovers or causes deviation from an agreement, log it in the appropriate `drift.md`.
- **Log decisions.** If the command makes or discovers architectural decisions, log in `memory/decisions.md`.
- **Commit properly.** Use conventional message format: `[command-name] Brief description`.
- **Never modify tests.** Commands must not weaken assertions, skip tests, or modify test files to make something pass. (Atlas integrity rules apply to commands too.)

### Quality Standards

Commands should:
- Be idempotent where possible (running twice should not break anything)
- Provide clear output at each step (no silent operations)
- Include rollback or undo guidance for destructive operations
- Document what files they create or modify
- Handle missing files gracefully (tell the user what to create, do not crash)

### Review Process

When a command is published to the marketplace via PR:
1. Automated validation checks for required sections and Atlas integration rules
2. Community review for quality and usefulness
3. Atlas team review for security (no data exfiltration, no destructive operations)
4. If approved, merged and indexed in marketplace

## Marketplace Integration

Commands are stored in `marketplace/commands/` alongside skills in `marketplace/packs/` and templates in `marketplace/templates/`:

```
marketplace/
├── packs/              # Skill packs (existing)
├── community/          # Community skills (existing)
├── templates/          # Project templates (new — see project-templates.md)
├── commands/           # Community commands (new)
│   ├── INDEX.md        # Browsable index of all commands
│   ├── atlas-team/     # Official commands
│   │   ├── deploy/
│   │   └── changelog/
│   └── community/      # Community commands
│       ├── jane/
│       │   └── security-audit/
│       └── bob/
│           └── performance-check/
└── intelligence/       # Collective intelligence (new — see cross-project-intelligence.md)
```

### Browsing Commands

```
/skill browse commands
```

Lists available marketplace commands with descriptions, ratings, and download counts. Can filter by category (deployment, security, testing, documentation) or required skills.

### Rating and Reviews

Same system as skill ratings (see skill-marketplace.md):
- Times imported
- Star ratings (1-5)
- Short text reviews
- "Verified" badge for trusted contributors

## Versioning

Commands include a version in their metadata. When a command is updated:
- The marketplace stores all versions
- Importing always gets the latest version by default
- `/atlas-import-command @user/name@1.0.0` pins to a specific version
- Breaking changes require a major version bump and a migration note

## Status

- **`/atlas-extend` scaffolding** could ship in v1.5. It only creates a local file --- no marketplace needed.
- **`/atlas-extend --publish`** requires marketplace infrastructure.
- **`/atlas-import-command`** requires marketplace infrastructure.
- **Marketplace command section** ships alongside the marketplace (v2).
