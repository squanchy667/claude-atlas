# Skill Marketplace

> Shipped in v1. Core marketplace is built into Atlas.

## What Shipped (v1)

The Skill Marketplace is live with local import, publish, and browse capabilities.

### 4 Skill Packs (18 skills total)

| Pack | Skills | What It Covers |
|------|--------|---------------|
| general | 5 | Git workflow, testing, error handling, code review, documentation |
| web-app | 5 | Components, state, API integration, auth, forms |
| api-service | 5 | REST design, database, validation, middleware, logging |
| cli-tool | 3 | Arguments, output formatting, configuration |

Packs live in `marketplace/packs/` and are included with every Atlas installation.

### Commands

- **`/skill import [pack/name]`** — Import a single skill or an entire pack from `marketplace/packs/` into `skills/imported/`. Checks for duplicates against active and foundation skills before importing.
- **`/skill publish [name]`** — Export a project skill to `marketplace/community/` with provenance metadata (project, author, date, tier, usage count). Validates required sections before publishing.
- **`/skill browse [pack?]`** — List all marketplace packs and skills, or drill into a specific pack to see skill summaries.

### Community Publishing

Users can publish their own skills to `marketplace/community/`. Each published skill includes a `source.md` with provenance metadata. To share with the Atlas community, commit and push.

---

## Planned for v2

### Online Marketplace Portal

A hosted marketplace where Atlas users can discover, rate, and install skills from a central registry — no manual git operations required.

### Skill Ratings and Reviews

- **Times Used** — how many projects have imported this skill
- **Success Rate** — percentage of imports where the skill was used (not immediately archived)
- **Star Ratings** — users rate skills after using them (1-5 stars)
- **Reviews** — short text feedback on applicability and quality

### Verified Publishers

Trusted contributors earn a "Verified" badge. Their skills are prioritized in search results and recommended more aggressively.

### Auto-Recommendations

Based on the project type detected during `/atlas-setup`, Atlas suggests relevant marketplace skills automatically. For example, a SaaS project gets recommendations for auth, multi-tenancy, and billing skills.

---

## Template Marketplace

Alongside skills, the marketplace hosts project templates (see project-templates.md for full specification).

**How templates fit in:** Skills are reusable knowledge fragments. Templates are complete project blueprints that bundle skills, phase structures, architecture patterns, and pre-identified gaps. A template might include 10-15 skills as part of its curated pack.

**Template marketplace features:**
- Browse templates by project type (SaaS, API, CLI, game, extension, library)
- Preview template structure: phases, task counts, included skills, estimated complexity
- Import a template during `/atlas-setup` — it pre-fills 70% of the project structure
- Rate and review templates after use (same rating system as skills)
- Community-created templates alongside official ones

**Template lifecycle:**
1. User completes a project through Atlas
2. `/atlas-retro` offers to create a template from the project
3. User reviews and generalizes the template (anonymize, generalize task descriptions)
4. `/skill publish --template [name]` pushes to marketplace
5. Other users discover and import the template

**Revenue:** Free basic templates (saas-starter, rest-api, cli-tool, open-source-library). Premium specialized templates with deeper task breakdowns, more skills, and calibrated estimates from collective intelligence.

---

## Plugin/Command Marketplace

The marketplace also hosts community-created commands (see plugin-system.md for full specification).

**How commands fit in:** Skills are knowledge that Claude references during tasks. Templates are project blueprints used at setup time. Commands are executable workflows that extend Atlas's command set. A deploy command, a security audit command, a changelog generator — these are domain-specific workflows that not every project needs.

**Command marketplace features:**
- Browse commands by category (deployment, security, testing, documentation, estimation)
- Preview command structure: purpose, prerequisites, skill dependencies, process steps
- Import a command via `/atlas-import-command @user/name` — copies to `.claude/commands/`
- Dependency resolution: if a command requires skills, Atlas offers to import them
- Rate and review commands after use

**Command lifecycle:**
1. User scaffolds a new command with `/atlas-extend [name]`
2. User customizes the command for their workflow
3. `/atlas-extend --publish [name]` validates and packages the command
4. Pushed to `marketplace/commands/[author]/[name]/`
5. Other users discover and import the command

**Quality control:** Commands must follow Atlas conventions (respect agreements, update status, log drift, commit properly). The `/atlas-extend --publish` command validates these requirements before allowing publication. Community review adds a human quality layer.

---

## Collective Intelligence Layer

Above skills, templates, and commands sits the collective intelligence layer (see cross-project-intelligence.md for full specification).

**How intelligence fits in:** Skills encode what to do. Templates encode how to structure. Commands encode workflows. Intelligence encodes what actually happens when people build things — the real data from real projects.

**Intelligence in the marketplace:**
- Stored in `marketplace/intelligence/` organized by project type
- Contains anonymized estimation data, mistake catalogs, pattern catalogs, quality benchmarks
- Feeds into `/atlas-setup` (recommendations), `/plan-phase` (calibrated estimates), and `/atlas-retro` (cross-project comparison)
- Updated periodically as new project intelligence reports are published

**What makes it valuable:**
- Skills can be read and copied. Templates can be cloned. Intelligence from hundreds of completed projects is a data asset that compounds over time and cannot be replicated without the same volume of real project data.
- New Atlas users benefit from collective intelligence from day one (no cold start for estimation, no repeating common mistakes)
- The data gets better as more projects complete — a true network effect

**Privacy:** All intelligence is anonymized before aggregation. No project names, company names, developer names, code snippets, or proprietary information. Only patterns, categories, and aggregated statistics. Publishing is always opt-in.

---

## Unified Marketplace Architecture

The marketplace is a single repository with three content types plus the intelligence layer:

```
marketplace/
├── packs/                      # Official skill packs (shipped with Atlas)
│   ├── general/
│   ├── web-app/
│   ├── api-service/
│   └── cli-tool/
├── community/                  # Community-published skills
│   ├── INDEX.md
│   └── [skill-name]/
├── templates/                  # Project templates
│   ├── INDEX.md
│   ├── saas-starter/           # Official templates
│   ├── rest-api/
│   ├── cli-tool/
│   ├── open-source-library/
│   └── community/              # Community templates
│       └── [author]/
│           └── [template-name]/
├── commands/                   # Community commands (plugins)
│   ├── INDEX.md
│   ├── atlas-team/             # Official commands
│   │   └── [command-name]/
│   └── community/              # Community commands
│       └── [author]/
│           └── [command-name]/
└── intelligence/               # Collective intelligence data
    ├── saas/
    │   ├── estimation.json
    │   ├── mistakes.json
    │   ├── patterns.json
    │   └── benchmarks.json
    ├── api/
    ├── cli/
    ├── game/
    ├── extension/
    └── library/
```

**One repo, unified tooling:** All marketplace operations use the same infrastructure:
- `/skill browse [type?]` — browse skills, templates, or commands
- `/skill import [pack/name]` — import a skill or skill pack
- `/atlas-import-command @user/name` — import a command
- Template import happens during `/atlas-setup`

**Indexing:** Each content directory has an `INDEX.md` that is auto-generated from metadata files. The index includes: name, description, author, version, rating, download count, last updated. This enables quick browsing without reading individual files.

**Versioning:** All content types use semantic versioning. The marketplace stores all versions. Users can pin to specific versions or track latest.

---

## Community Contribution Workflow

The contribution workflow is the same for skills, templates, and commands:

1. **Fork** the marketplace repository
2. **Create** the content in the appropriate directory:
   - Skills: `community/[skill-name]/`
   - Templates: `templates/community/[author]/[template-name]/`
   - Commands: `commands/community/[author]/[command-name]/`
3. **Validate** using the appropriate tool:
   - Skills: `/skill publish [name]` validates required sections
   - Templates: template.json schema validation
   - Commands: `/atlas-extend --publish [name]` validates Atlas conventions
4. **PR** to the marketplace repository with:
   - Content files
   - Metadata (author, version, description, dependencies)
   - Brief description of what the content does and why it is useful
5. **Review** by:
   - Automated validation (schema, required sections, Atlas convention compliance)
   - Community review (usefulness, quality, overlap with existing content)
   - Atlas team review for security (no data exfiltration, no destructive operations, no malicious instructions)
6. **Merge** — content is merged and automatically indexed
7. **Indexed** — INDEX.md files are regenerated, content is discoverable via browse commands

**Review criteria:**
- Does it follow the required format?
- Does it do what it claims?
- Does it respect Atlas conventions (for commands)?
- Does it overlap significantly with existing content? (duplicates should improve, not duplicate)
- Is it safe? (no instructions to delete files, exfiltrate data, or bypass Atlas integrity rules)

**Contribution recognition:**
- Contributors are credited by username in metadata
- Frequent contributors earn "Verified" badge
- Most-imported content is highlighted in marketplace browse results

---

## Revenue Model

- **Community skills** — free to publish and import
- **Community templates** — free to publish and import
- **Community commands** — free to publish and import
- **Premium curated packs** — maintained by the Atlas team, regularly updated with community contributions
- **Premium templates** — deeper task breakdowns, more skills, calibrated estimates from collective intelligence
- **Collective intelligence access** — free for basic insights, premium for detailed analytics and cross-project benchmarking
- All content remains owned by creators with MIT-style licensing
