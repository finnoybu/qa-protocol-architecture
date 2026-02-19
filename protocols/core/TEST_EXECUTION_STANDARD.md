# TEST EXECUTION STANDARD
Version: 1.0.0

## Purpose

Define the authoritative standard for writing and executing QA test cases across all Cortex-related feature validations.

---

## Core Principles

1. All tests begin on Platform tenant.
2. Final validation step repeats on Legacy tenant unless explicitly excluded.
3. No test may exceed 15 steps (10 preferred).
4. Each step must contain:
   - Clear action
   - Required test data (if applicable)
   - Deterministic expected result
5. Expected Result must be observable and verifiable.

---

## Execution Layers

Every feature must be validated across:

- UI / Web Console
- PAPI / Public API
- Backend behavior
- Agent behavior
- Rollback state (if applicable)

No feature is considered validated until all layers are tested.

---

## Token / Password Rules

Hierarchy enforcement must follow:

Global Default > Global Set by Admin > Agent Settings Override

Temporary Tokens are valid only if active (not expired).

---

## Documentation Requirements

Each test must include:

- Title
- Objective
- Preconditions
- ID / Step / Test Data / Expected Result table

---

## MSSP Rule

If feature affects endpoint control or policy, Parent ↔ Child validation is mandatory.

---

End of Document
