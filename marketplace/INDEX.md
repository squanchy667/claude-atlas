# Skill Marketplace

> Pre-built skills for common project patterns. Import any skill into your project with `/skill import [pack/name]`.

## Packs

| Pack | Skills | Description |
|------|--------|-------------|
| general | 5 | Universal patterns that apply to any project |
| web-app | 5 | Frontend and full-stack web application patterns |
| api-service | 5 | Backend API and service patterns |
| cli-tool | 3 | Command-line tool patterns |

## All Skills

### general/
| Skill | What It Solves |
|-------|---------------|
| git-workflow | Branching strategy, commit conventions, PR process |
| testing-strategy | What to test, how to structure tests, when to skip |
| error-handling | Consistent error capture, propagation, and reporting |
| code-review-checklist | Systematic review process that catches real issues |
| documentation-patterns | When and how to document without over-documenting |

### web-app/
| Skill | What It Solves |
|-------|---------------|
| component-architecture | Component design, composition, prop patterns |
| state-management | Local vs global state, when to use each |
| api-integration | Data fetching, caching, loading/error states |
| auth-flow | Authentication and authorization patterns |
| form-handling | Validation, submission, error display, multi-step forms |

### api-service/
| Skill | What It Solves |
|-------|---------------|
| rest-api-design | Endpoint naming, status codes, response shapes, versioning |
| database-patterns | Query design, migrations, transactions, connection pooling |
| input-validation | Validation at system boundaries, schema-first approach |
| middleware-design | Request pipeline, error middleware, auth guards |
| logging-observability | Structured logging, request tracing, health checks |

### cli-tool/
| Skill | What It Solves |
|-------|---------------|
| argument-design | CLI argument structure, help text, subcommands |
| output-formatting | Progress indicators, tables, colors, machine-readable output |
| config-management | Config files, environment variables, defaults, precedence |

## How to Use

Import a single skill:
```
/skill import general/git-workflow
```

Import an entire pack:
```
/skill import general
```

Browse what's available:
```
/skill browse
```
