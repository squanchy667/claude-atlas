# Test Spec: [PHASE]-[TASK]

<!-- Fill BEFORE writing implementation code. Tests define the contract. -->

## Test Philosophy

<!-- What does "working" mean for this task? One paragraph, plain language. -->

[PHILOSOPHY — e.g., "This task is working when a user can sign up with a valid email and password, receive appropriate error messages for invalid input, and the resulting user record exists in the database with a hashed password."]

## Test Cases

| Name | What It Proves | Input | Expected Output | Pass Criteria |
|------|---------------|-------|-----------------|---------------|
| [TEST_NAME] | [WHAT_THIS_VALIDATES] | [INPUT_DATA] | [EXPECTED_RESULT] | [HOW_TO_KNOW_IT_PASSED] |
| [TEST_NAME] | [WHAT_THIS_VALIDATES] | [INPUT_DATA] | [EXPECTED_RESULT] | [HOW_TO_KNOW_IT_PASSED] |
| [TEST_NAME] | [WHAT_THIS_VALIDATES] | [INPUT_DATA] | [EXPECTED_RESULT] | [HOW_TO_KNOW_IT_PASSED] |
| [TEST_NAME] | [WHAT_THIS_VALIDATES] | [INPUT_DATA] | [EXPECTED_RESULT] | [HOW_TO_KNOW_IT_PASSED] |

## Edge Cases

<!-- Boundary conditions, unusual inputs, error paths. -->

- [EDGE — e.g., "Empty string for email field"]
- [EDGE — e.g., "Email with maximum allowed length (254 characters)"]
- [EDGE — e.g., "Concurrent signup with the same email"]
- [EDGE]

## Explicitly Not Tested

<!-- What this test spec does not cover, and why. -->

- [NOT_TESTED — e.g., "Email delivery — tested in the email service task, not here"]
- [NOT_TESTED — e.g., "UI styling — visual regression tests are out of scope for this phase"]

## Test Command

```bash
[COMMAND — e.g., "npm test -- --testPathPattern=signup"]
```

---

**CRITICAL RULE: Tests are sacred. Fix the code to pass the test. Never change the test to match broken code.**
