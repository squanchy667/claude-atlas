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

## Revenue Model

- **Community skills** — free to publish and import
- **Premium curated packs** — maintained by the Atlas team, regularly updated with community contributions
- Skills remain owned by their creators with MIT-style licensing
