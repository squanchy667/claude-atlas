# Skill: Argument Design

**Tier:** Foundation
**Category:** Architecture
**Created:** Marketplace
**Status:** Active
**Times Used:** 0

## What This Skill Solves
CLI tools with confusing argument structures frustrate users. This skill provides patterns for designing intuitive, discoverable command-line interfaces.

## The Approach
Follow established conventions (POSIX, GNU). Subcommand pattern for complex tools. Flags for options. Positional args for required inputs. Help text that actually helps.

## When to Use This
- Designing a new CLI tool
- Refactoring a CLI that has grown organically and become confusing
- Adding subcommands to an existing tool

## When NOT to Use This
- Interactive TUI applications — different UX patterns apply
- Tools with a single purpose and no options (simple scripts)

## Steps
1. **Subcommands for nouns or verbs**: `atlas skill create`, `atlas skill promote`. Not `atlas-create-skill`.
2. **Positional args for required inputs**: `atlas plan-phase 1` not `atlas plan-phase --number 1`.
3. **Flags for optional behavior**: `--verbose`, `--output json`, `--dry-run`.
4. **Short flags for frequent options**: `-v` for verbose, `-o` for output. Long flags for rare options.
5. **Boolean flags don't take values**: `--verbose` not `--verbose true`.
6. **`--help` on every command and subcommand.** Auto-generated from the arg definitions.
7. **`--version` on the root command.**
8. **Default behavior should be safe.** Destructive operations require `--force` or confirmation.
9. **Error messages include the fix**: "Unknown flag --verboze. Did you mean --verbose?" not just "Unknown flag."
10. **Exit codes**: 0 for success, 1 for user error, 2 for system error. Document them.

## Example
```
atlas <command> [options]

Commands:
  init          Create Atlas folder structure
  setup         Define project through guided conversation
  run           Execute project phases
  plan-phase    Break a phase into tasks
  task          Task lifecycle management
  checkpoint    Human review walkthrough
  skill         Manage reusable skills
  status        Current project state

Options:
  --help, -h    Show help
  --version     Show version
  --verbose, -v Show detailed output

Examples:
  atlas init
  atlas setup
  atlas task phase-1 task-3 start
  atlas skill import general/testing-strategy
```

## Gotchas
- Too many required flags is a code smell — the tool is trying to do too much in one command.
- `--no-color` should always be supported for CI/piped output.
- Respect `NO_COLOR` and `FORCE_COLOR` environment variables.
- Tab completion is worth the effort. Users expect it.

## Related Skills
- output-formatting — how to display results
- config-management — where to store persistent settings
