# Atlas Setup Examples

Reference templates showing how to answer the 11 `/atlas-setup` questions for different project types. Copy-paste the answers as Atlas asks each question, then customize for your specific project.

## Available Examples

| Example | Type | Phases | Tasks | Complexity |
|---------|------|--------|-------|------------|
| [Unity 2D Game](unity-2d-game.md) | Flappy Bird clone | 4 | ~16 | Simple |
| [CLI Tool](cli-tool.md) | Note-taking CLI | 3 | ~8 | Simple |
| [Roguelite Game](unity-roguelite.md) | Cult of the Lamb-inspired | 7 | ~35 | Complex |
| [Web App](web-app.md) | Expense tracker (React + Express) | 6 | ~28 | Medium |
| [Chrome Extension](chrome-extension.md) | Shopify admin helper | 5 | ~23 | Medium |
| [Blank Template](template.md) | Fill in your own | - | - | Any |

## How to Use

1. Pick the example closest to your project
2. Open it side-by-side with your Atlas session
3. Paste each answer when Atlas asks the corresponding question
4. Customize the details for YOUR project (names, features, stack specifics)
5. Review the preview Atlas generates — this is your cheapest correction point

## Tips for Great Setup Answers

- **Be specific, not vague.** "A CLI that converts CSV to JSON" beats "a productivity tool."
- **Success criteria should be testable.** "Responds in under 100ms" beats "is fast."
- **Failure conditions are guardrails.** They prevent Atlas from shipping something that technically works but feels wrong.
- **Non-scope prevents creep.** Explicitly say what you're NOT building.
- **Phases should be playable milestones.** Each phase should produce something you can see/use/test.
- **Risks should have mitigations.** Don't just list problems — say how you'll handle them.

## After Setup

```
/atlas-run --supervised          # First time (pause at gates)
/atlas-run --full-permission     # You trust the plan (full autopilot)
```
