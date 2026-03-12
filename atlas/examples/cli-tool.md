# Atlas Setup Example — CLI Tool (QuickNote)

Based on the QuickNote project: 8 tasks, 3 phases, 55 tests passing, completed in 1 session.

---

## Q1 — Project Name
```
QuickNote
```

## Q2 — Description
```
A CLI tool for taking, listing, and searching notes from the terminal.
```

## Q3 — Problem
```
Developers lose quick thoughts because switching to a notes app breaks their flow. The friction of leaving the terminal — opening a browser, navigating to a notes app, waiting for it to load — means ideas, TODOs, and debugging insights get lost. Existing terminal-based solutions are either too complex (require learning a markup language, syncing to a service) or too limited (plain text files with no search). Target audience: solo developers who spend most of their day in the terminal on macOS or Linux, comfortable with CLI tools, want to capture thoughts in under 2 seconds.
```

## Q4 — Stack
```
Runtime: Node.js 18+. Language: TypeScript. CLI Framework: Commander.js. Storage: Local JSON file (no database). Build: tsup (bundler). Testing: vitest. Package Distribution: npm global install. Version Control: Git.
```

## Q5 — Team Size
```
1
```

## Q6 — Success Criteria
```
- Can add a note in under 2 seconds (single command, no interactive prompts required)
- Can search notes by keyword and get results instantly (sub-second for files under 10MB)
- Notes persist between sessions (stored on disk, survive terminal close and system restart)
- Works on macOS and Linux without platform-specific configuration
- Tags auto-extracted from #hashtags in note text
- Search highlights matching terms in results
- List supports sorting and JSON output for piping
- Delete command with confirmation
- Professional help text for all commands
```

## Q7 — Failure Conditions
```
- Adding a note requires more than one command
- Notes are lost between sessions (data corruption, storage not persisted)
- Installation requires setup beyond npm install -g (no config files, no database, no env vars)
```

## Q8 — Non-Scope
```
- GUI or web interface (terminal-only)
- Cloud sync (all data stays local)
- Collaboration or sharing (single-user tool)
- Mobile app (desktop CLI only)
- Encryption (notes stored as plain JSON)
- Rich text or markdown formatting
```

## Q9 — Phases
```
Phase 1 — Foundation: Project setup (TypeScript, Commander.js, tsup, vitest), JSON file storage module with atomic writes and corruption recovery, CLI scaffold with add/list/search commands wired to note service. Result: working CLI that can add, list, and search notes.

Phase 2 — Core Enhancements: Enhanced add command (multi-word without quotes, stdin pipe input), enhanced list command (--json flag, --sort option, relative date formatting, ls alias), enhanced search (--tag flag, ANSI bold highlighting, no results message). Result: CLI feels complete and polished.

Phase 3 — Polish and Ship: Error handling and edge cases (empty validation, corruption recovery, delete command with confirmation, --verbose flag), help text, README, npm prep (.npmignore, npm link verification). Result: ready to publish.
```

## Q10 — Risks
```
- File locking: two processes writing simultaneously could corrupt data. Mitigation: atomic writes (write to temp file, then rename) with backup file for recovery.
- JSON storage scaling: large files may slow down read/write. Mitigation: define max file size threshold, document limitation, and keep scope to personal note-taking volumes.
- Cross-platform path differences: macOS vs Linux home directory, file permissions. Mitigation: use Node.js path module and os.homedir() consistently.
```

## Q11 — Integrations
```
No external services or APIs. Fully offline, local tool. npm packages: commander (CLI framework), uuid (note IDs). Dev dependencies: typescript, tsup, vitest. No environment variables, no auth, no cloud services.
```

---

## What Was Actually Built (QuickNote Stats)

| Metric | Value |
|--------|-------|
| Total tasks | 8 |
| Phases | 3 |
| Test files | 3 |
| Tests passing | 55 |
| Sessions | 1 |
| Time to complete | Single session |

## Key Patterns Discovered

- **Atomic writes with backup** — Write to temp file, rename to target, keep previous as .backup
- **Corruption recovery chain** — Try primary file → try backup → start fresh (never crash)
- **Auto-tag extraction** — Parse #hashtags from note text at write time, store as array
- **Relative date formatting** — "just now", "2 hours ago", "yesterday" instead of timestamps
- **ANSI bold highlighting** — Wrap search matches in `\x1b[1m...\x1b[0m` for terminal emphasis

## Gotchas

- Commander.js variadic arguments need special handling for multi-word notes without quotes
- stdin pipe detection: check `!process.stdin.isTTY` before trying to read from pipe
- npm link for local testing — verify the bin entry in package.json points to the built output
