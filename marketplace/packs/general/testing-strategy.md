# Skill: Testing Strategy

**Tier:** Foundation
**Category:** Testing
**Created:** Marketplace
**Status:** Active
**Times Used:** 0

## What This Skill Solves
Projects either over-test trivial code or under-test critical paths. This skill provides a clear framework for what to test, how to structure tests, and what to skip.

## The Approach
Test at three levels: unit tests for logic, integration tests for boundaries, and a handful of end-to-end tests for critical user journeys. The ratio is roughly 70/20/10.

## When to Use This
- Setting up the test infrastructure for a new project
- Deciding what tests to write for a specific task
- When test coverage is high but bugs still ship (testing the wrong things)

## When NOT to Use This
- Prototyping or throwaway code — skip tests entirely
- Pure UI styling — visual regression tools are better than unit tests

## Steps
1. **Unit tests** cover pure logic: transformations, calculations, validators, state machines. If a function takes input and returns output with no side effects, unit test it.
2. **Integration tests** cover boundaries: API endpoints, database queries, external service calls. Mock external services, use real database (test instance).
3. **End-to-end tests** cover critical journeys only: signup flow, purchase flow, the one thing that must never break. Keep these under 10.
4. **Test file location**: co-locate with source. `auth.ts` has `auth.test.ts` in the same directory.
5. **Test naming**: `describe('[Module]', () => { it('should [expected behavior] when [condition]') })`
6. **Arrange-Act-Assert** pattern for every test. Three sections, clearly separated.
7. **One assertion per test** is ideal. Multiple assertions are acceptable when testing a single logical outcome.
8. **Do not test implementation details.** Test behavior. If you refactor internals and tests break, the tests were wrong.
9. **Do not test framework code.** React renders components. Express routes requests. Trust them.
10. **Every bug gets a regression test.** Before fixing, write a test that fails. Fix. Test passes. Never regress.

## Example
```typescript
// Unit test — pure logic
describe('calculateDiscount', () => {
  it('should apply 10% discount when cart total exceeds 100', () => {
    const cart = { items: [{ price: 120 }] };
    const result = calculateDiscount(cart);
    expect(result.discount).toBe(12);
  });

  it('should apply no discount when cart total is under 100', () => {
    const cart = { items: [{ price: 50 }] };
    const result = calculateDiscount(cart);
    expect(result.discount).toBe(0);
  });
});

// Integration test — boundary
describe('POST /api/orders', () => {
  it('should create an order and return 201', async () => {
    const res = await request(app)
      .post('/api/orders')
      .send({ items: [{ id: 1, qty: 2 }] });
    expect(res.status).toBe(201);
    expect(res.body.orderId).toBeDefined();
  });
});
```

## Gotchas
- Flaky tests are worse than no tests. If a test fails intermittently, fix it or delete it.
- Test data should be self-contained. Never depend on database state from another test.
- Mocking too much makes tests pass but hides real bugs. Mock at the boundary, not inside your code.
- 100% coverage is not a goal. Critical path coverage is the goal.

## Related Skills
- error-handling — test error paths, not just happy paths
- input-validation — validation logic is the highest-value unit test target
