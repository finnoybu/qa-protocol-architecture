# Test Design Standard
Version: v1.0.0
Status: Active
Owner: Systems QA
Last Updated: 2026-02-19 15:04:46

---

## 1. Purpose

Define a consistent, repeatable methodology for designing QA test cycles and individual test cases across CRTX  features.

This standard governs **how we design tests**, not how we execute them.

---

## 2. Design Principles

1. **Baseline first**: Establish pre-feature behavior with feature flags disabled or absent.
2. **One flag at a time**: Enable exactly one feature flag per phase unless an explicit dependency requires otherwise.
3. **Hierarchy-respecting**: Parent flags must gate child behavior. Never test child-only activation with parent disabled unless explicitly required.
4. **Full lifecycle**: Every phase must validate Enable → Positive → Negative → Disable → Rollback integrity.
5. **Multiple validation surfaces**: UI, WebUI (DevTools), PAPI, and Backend enforcement are first-class test targets.
6. **No implied knowledge**: Steps must be readable by an engineer unfamiliar with the feature’s prior behavior.
7. **Deterministic outcomes**: Expected results must be concrete and verifiable (no “works correctly”).
8. **Step count constraints**:
   - Target ≤ 10 steps per test
   - Hard cap ≤ 15 steps per test
   - Split tests when lifecycle becomes too large

---

## 3. Required Flow Types Per Feature/Flag

Each feature flag phase must include, at minimum:

### 3.1 Baseline Flow (FF disabled)
Validate:
- Feature is not exposed in UI or PAPI
- WebUI payloads do not contain feature fields
- Backend rejects forbidden feature payloads
- Endpoint behavior matches documented pre-feature baseline

### 3.2 Positive Flow (FF enabled)
Validate:
- UI exposure appears where expected
- PAPI returns expected modules and accepts valid configuration
- Endpoint behavior reflects enabled configuration
- Auditing/Action Center events appear where expected

### 3.3 Negative Flows (FF enabled)
At least one intentional failure per phase, such as:
- Invalid credential attempt
- Malformed JSON submission
- Valid-but-forbidden JSON submission (where applicable)
- Unauthorized RBAC attempt
- Expired token attempt (where applicable)

### 3.4 Rollback Flow (FF disabled after being enabled)
Validate:
- UI exposure removed
- PAPI exposure removed
- WebUI payloads no longer include feature fields
- No orphan enforcement remains on endpoint
- Tenant state indistinguishable from baseline (artifact-free rollback)

---

## 4. Validation Surfaces (Design Checklist)

A test suite must include coverage across these surfaces:

- **UI**: module visibility, context menu presence, profile configuration exposure
- **WebUI**: DevTools capture of relevant endpoints (e.g., get_config, get_profile_view_by_id)
- **PAPI**: get_modules, add/edit profile acceptance/rejection, error codes/messages
- **Backend enforcement**: validation rejection, no silent storage, no DB mutation on invalid requests
- **RBAC**: admin vs non-admin roles; MSSP parent/child where applicable
- **Rollback**: artifact-free rollback verification

---

## 5. Tenant Execution Order (Design Rule)

- **Platform tenant first** (authoritative execution)
- **Legacy tenant last** (sanity repeat)

Design tests to explicitly state this sequence in steps or expectations.

---

## 6. Priority Ordering Rules

When sorting tests for execution priority:

1. Baseline (all flags disabled)
2. Parent flags (enable/validate/rollback)
3. Child flags (enable/validate/rollback) only after parent confirmed
4. Min-version / gating flags (after behavior-level flags)
5. Full-stack all-flags-enabled sanity
6. Export/Import integrity
7. Backend/DB tamper and handler recovery
8. MSSP parent/child
9. Practical edge cases (disconnect/expiration/race conditions)

---

## 7. Output Format Requirements

- Test cases intended for Jira/Zephyr import must follow the repo’s CSV standard.
- If delimiter collisions are likely, use an alternate delimiter (e.g., `~`) and document it in the cycle README.

---

End of Standard (v1.0.0)
