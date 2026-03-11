# Skill: Config Management

**Tier:** Foundation
**Category:** Data
**Created:** Marketplace
**Status:** Active
**Times Used:** 0

## What This Skill Solves
Configuration scattered across environment variables, config files, flags, and hardcoded defaults is a debugging nightmare. This skill establishes a single, predictable configuration system with clear precedence.

## The Approach
Layered configuration with explicit precedence: CLI flags > environment variables > project config file > user config file > defaults. Every config value has exactly one source of truth at runtime.

## When to Use This
- Any tool that has configurable behavior
- When configuration has grown organically and sources conflict
- Setting up a new project's configuration system

## When NOT to Use This
- Single-purpose scripts with no configuration
- Libraries (they should accept config as parameters, not read files)

## Steps
1. **Define all config values** in one place: a schema or type definition. Name, type, default, description, source.
2. **Precedence order** (highest to lowest):
   - CLI flags: `--port 3000`
   - Environment variables: `PORT=3000`
   - Project config: `.projectrc.json` or `project.config.js` in the project root
   - User config: `~/.config/toolname/config.json`
   - Defaults: hardcoded in the schema
3. **Config file format**: JSON or YAML. JSON for simple configs, YAML for complex ones with comments. Never invent a custom format.
4. **Config file discovery**: walk up from current directory looking for the config file. Stop at home directory or git root.
5. **Environment variable naming**: `TOOLNAME_SECTION_KEY`. All uppercase, underscores, prefixed with tool name.
6. **Validate on load**: parse and validate all config at startup. Fail fast with clear messages. "Invalid value for port: 'abc'. Expected a number between 1 and 65535."
7. **Print resolved config**: support `--show-config` that prints the final merged config and which source each value came from.
8. **Secrets never in config files**: API keys, tokens, passwords. Use environment variables or a secret manager. Config files get committed.
9. **Config init command**: `tool init-config` creates a config file with defaults and comments explaining each option.
10. **Document every option** in the README with default values and examples.

## Example
```typescript
// Config schema
const configSchema = {
  port: { type: 'number', default: 3000, env: 'APP_PORT', description: 'Server port' },
  logLevel: { type: 'string', default: 'info', env: 'APP_LOG_LEVEL', enum: ['debug', 'info', 'warn', 'error'] },
  database: {
    url: { type: 'string', required: true, env: 'DATABASE_URL', description: 'Database connection string' },
    poolSize: { type: 'number', default: 10, env: 'DB_POOL_SIZE' },
  },
};

// Precedence resolution
function resolveConfig(flags, env, projectFile, userFile, defaults) {
  return deepMerge(defaults, userFile, projectFile, envToConfig(env), flags);
}
```

## Gotchas
- `.env` files are NOT config files. They're developer convenience for setting environment variables. Never read them in production.
- Changing config file format between versions is a breaking change. Version your config format.
- Config validation errors should list ALL invalid values, not just the first one.
- Watch out for type coercion: `PORT=3000` is a string. Parse it.

## Related Skills
- argument-design — CLI flags are the highest-priority config source
- error-handling — config validation errors need clear messages
