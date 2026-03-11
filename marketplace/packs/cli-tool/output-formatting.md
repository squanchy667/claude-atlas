# Skill: Output Formatting

**Tier:** Foundation
**Category:** UI/UX
**Created:** Marketplace
**Status:** Active
**Times Used:** 0

## What This Skill Solves
CLI tools that dump unformatted text are hard to scan. Tools that over-format are hard to pipe. This skill covers formatting output for both humans and machines.

## The Approach
Detect whether output is a terminal or a pipe. Format for humans in terminal, structure for machines in pipe. Always support `--output json` for programmatic use.

## When to Use This
- Any CLI that produces output beyond a single line
- Tools that other tools will consume via piping
- Progress indicators for long-running operations

## When NOT to Use This
- Silent tools that only signal success/failure via exit code

## Steps
1. **Detect terminal**: `process.stdout.isTTY` (Node), `sys.stdout.isatty()` (Python). Format accordingly.
2. **Tables for structured data**: aligned columns, header row, consistent width. Libraries: `cli-table3` (Node), `tabulate` (Python).
3. **Colors for emphasis only**: green for success, red for error, yellow for warning, dim for secondary. Never rely on color alone.
4. **Progress bars for long operations**: show percentage, ETA, current item. Libraries: `ora` or `cli-progress` (Node), `tqdm` (Python).
5. **Spinners for indeterminate operations**: when you can't calculate percentage, show a spinner with status text.
6. **JSON output mode**: `--output json` or `--json` flag. Output valid JSON to stdout. Errors to stderr.
7. **Quiet mode**: `--quiet` or `-q` suppresses all non-essential output. Only errors and the final result.
8. **Stderr for status, stdout for data**: progress bars, spinners, and status messages go to stderr. Results go to stdout. This makes piping work.
9. **Summary at the end**: for multi-step operations, end with a summary. "Created 5 files, skipped 2, 1 error."
10. **No trailing newline on piped data** if the consumer expects raw values.

## Example
```
# Human terminal output
✓ Phase 1 planned (5 tasks)
✓ Phase 2 planned (8 tasks)
⚠ Phase 3 has 2 unresolved gaps

Summary: 3 phases, 13 tasks, 2 gaps
Next: Run /plan-phase 1 to detail tasks

# Machine output (--json)
{"phases":3,"tasks":13,"gaps":2,"status":"planned"}
```

## Gotchas
- Windows terminals have limited Unicode support. Test box-drawing characters and emoji on Windows.
- CI environments are not TTY. Never assume colors or interactive features.
- Long lines wrap badly in narrow terminals. Cap output width at 80 chars or detect terminal width.
- Piping to `less` loses colors unless you use `--color=always`.

## Related Skills
- argument-design — output flags are part of argument design
- error-handling — error display follows the same formatting rules
