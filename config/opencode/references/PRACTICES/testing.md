# Testing Practices

Tests exist to catch regressions and document intent, not to inflate coverage.
The `tester` agent follows these; human-written tests should too.

## What to test

- Branching logic, boundary conditions, error paths, and anything touching
  persistence, auth, money, or external services.
- Public contracts and user-visible behavior. Skip trivial accessors and
  generated code.

## When to write tests

- Write the test alongside the feature, not deferred. For risky changes, write
  the failing test first, then the implementation.
- Every reproducible bug fix gets a regression test named after the bug.

## How to write tests

- **Names state the expected behavior**: `pay_decreases_balance_by_Amount`,
  not `testPay1`.
- **One assertion concept per test.** A test should fail for one reason.
- **Arrange / Act / Assert**, in that order, visibly.
- **Isolate**: no shared mutable state, no test-order dependence, no network or
  real filesystem where a fake works. Randomness must be seeded.
- **Fixtures over setup duplication.** Factories over brittle literals.
- **Test the contract, not the implementation** so refactors don't break tests.

## Layers

- **Unit**: fast, isolated, cover the bulk of logic.
- **Integration**: how units compose; real components where cheap.
- **End-to-end**: few, one per critical user journey; tolerate slowness, never
  flakiness.
- **Property / fuzz**: where the domain fits invariants (parsers, math, codecs).
- Boundary and error cases for every layer.

## Coverage

- Coverage is a side effect, not a target. 100% with tautological assertions is
  worse than 70% with sharp ones. Aim for "the risky paths are covered," not a
  number.

## CI

- The suite must be green on `main` at all times. Flaky tests are bugs; fix or
  quarantine the same day, never disable silently.
- Keep the full suite fast: slow integration/e2e in a separate stage, cached
  dependencies, parallelized runs.

## Anti-patterns

- Mocking the system under test until the test asserts nothing.
- Catching all exceptions in a test handler so failures look like passes.
- `sleep`-based timing; use fakes/clocks or polling with timeout.
- Snapshot tests as a default; only when output is genuinely large and
  human-reviewed.