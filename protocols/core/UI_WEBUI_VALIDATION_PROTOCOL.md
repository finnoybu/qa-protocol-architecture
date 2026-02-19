# UI / WebUI Validation Protocol

Version: v1.0.0  
Status: Active  
Owner: Systems QA  

---

## 1. Purpose

Define standardized validation methodology for:

- UI surface validation
- Browser WebUI network inspection
- Hidden field detection
- Feature flag gating validation

Applies to all Cortex feature flag testing.

---

## 2. Validation Layers

Every feature must be validated across:

1. Visible UI
2. Hidden UI (network calls)
3. Profile view JSON
4. Config JSON
5. Absence validation when disabled

---

## 3. UI Validation

Validate:

- Module visibility
- Context menu presence
- Profile configuration availability
- Correct default values
- Save / Apply behavior

When feature is disabled:

- Module must not appear
- Context menu option must not appear
- No partial rendering
- No hidden toggle remnants

---

## 4. WebUI (Browser DevTools) Validation

Use Chrome DevTools → Network tab.

Inspect:

- `get_profile_view_by_id`
- `get_config`
- Profile save payloads

Validate:

- Feature fields present when enabled
- Feature fields absent when disabled
- No hidden alpha flags leaking into payload
- No unexpected default injection

---

## 5. Absence Testing Rule

When feature flag is disabled:

- Field must not appear in UI
- Field must not appear in payload
- Field must not be accepted via modified request

If backend accepts forbidden field → FAIL

---

## 6. Failure Conditions

Fail if:

- UI shows disabled feature
- Hidden field present in payload
- Feature can be enabled via request tampering
- Partial rendering observed

---

End of Protocol (v1.0.0)
