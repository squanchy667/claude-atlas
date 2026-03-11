# Checkpoint: [PHASE]-[TASK]

This checkpoint has two sections. Claude fills the self-validation. The human fills the review. Claude does NOT touch the human review section.

---

## Self-Validation (Claude fills)

### Does it work as specified?

[ANSWER — yes/no with brief explanation. Reference the agreement's demo moment.]

### Are all checkpoint parameters met?

| Parameter | Met? | Evidence |
|-----------|------|----------|
| [PARAM_1 — from agreement] | [yes / no / partial] | [HOW_VERIFIED] |
| [PARAM_2 — from agreement] | [yes / no / partial] | [HOW_VERIFIED] |
| [PARAM_3 — from agreement] | [yes / no / partial] | [HOW_VERIFIED] |
| [PARAM_4 — from agreement] | [yes / no / partial] | [HOW_VERIFIED] |

### Are all tests passing?

```
[TEST_OUTPUT — paste actual output]
```

### Were any rules violated?

[ANSWER — list any architectural rules, dependency rules, or conventions that were bent or broken. "None" if clean.]

### Honest Uncertainty

<!-- What are you not 100% confident about? This is the most important section. Hiding uncertainty here is a failure mode. -->

- [UNCERTAINTY — e.g., "The error handling for network timeouts is untested — I believe it works but cannot prove it"]
- [UNCERTAINTY — e.g., "Performance under load is unknown — tested with single user only"]

### Side Effects and Risks

- [SIDE_EFFECT — e.g., "Added a new database index — may slow writes slightly"]
- [SIDE_EFFECT — e.g., "Changed the User model — existing data needs migration"]

---

## Human Review (human fills — Claude does NOT touch this section)

### Checkpoint Walk-Through

| Parameter | Observation |
|-----------|-------------|
| [PARAM_1] | [WHAT_HUMAN_SAW] |
| [PARAM_2] | [WHAT_HUMAN_SAW] |
| [PARAM_3] | [WHAT_HUMAN_SAW] |
| [PARAM_4] | [WHAT_HUMAN_SAW] |

### Observations

[OBSERVATIONS — anything the human noticed while running the program that is not covered by the parameters above]

### Decision

**[APPROVED / REVISIONS REQUIRED / REJECTED]**

### Revisions Required

<!-- Only fill if decision is "revisions required." -->

- [REVISION — specific item to fix]
- [REVISION — specific item to fix]

### Sign-Off

**[NAME]** — **[DATE]**
