# Agreement: [PHASE]-[TASK]

<!-- Fill before starting implementation. This is the contract between human and Claude. -->

**Agreement status:** [PROPOSED / APPROVED / IN REVISION]
**Approved by:** [NAME / TIMESTAMP]

## Demo Moment

<!-- Plain human language. When this task is done, what does the human physically see? -->

[DEMO — e.g., "When done, you will open the browser, navigate to /signup, enter an email and password, click Submit, and see a confirmation message. The user will appear in the database."]

## Checkpoint Parameters

<!-- 3-4 specific things the human will physically check in the running program. Not code review items — observable behavior. -->

1. [CHECK — e.g., "Submitting the form with a valid email creates a new user row in the database"]
2. [CHECK — e.g., "Submitting with an invalid email shows an inline error message without page reload"]
3. [CHECK — e.g., "Submitting with a duplicate email shows 'Email already registered' message"]
4. [CHECK — e.g., "Password field enforces minimum 8 characters with visual feedback"]

## Scope Boundary

### In Scope (confirmed)

- [IN — items agreed by both sides]
- [IN]
- [IN]

### Out of Scope (confirmed)

- [OUT — items explicitly excluded by agreement]
- [OUT]
- [OUT]

## Skill Manifest

<!-- Which existing skills this task will use. See tasks/templates/skills.md for the full manifest. -->

- [SKILL_NAME] — [WHY_RELEVANT]
- [SKILL_NAME] — [WHY_RELEVANT]

## Achilles' Heels

<!-- Where this task is most likely to be hard or fail. Be honest. -->

- [HEEL — e.g., "Email validation regex — edge cases with international domains"]
- [HEEL — e.g., "Race condition if two signups happen simultaneously with the same email"]

## New Skills Proposed

<!-- If any Achilles' heel requires a new skill, propose it here. -->

- [SKILL — e.g., "email-validation skill: centralized validation logic for email format and domain checks"]
- None needed

## Known Unknowns

<!-- Things that might require stopping implementation and having a conversation. -->

- [UNKNOWN — e.g., "Should we support OAuth signup in this task or defer to a later task?"]
- [UNKNOWN — e.g., "Rate limiting on signup — is this in scope?"]
