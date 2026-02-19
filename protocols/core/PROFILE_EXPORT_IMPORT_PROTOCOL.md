# Profile Export/Import Protocol
Version: v1.0.0
Status: Active
Owner: Systems QA
Last Updated: 2026-02-19 15:04:46

---

## 1. Purpose

Define standardized validation methodology for exporting, deleting, and importing Agent Settings profiles (and similar policy objects) to ensure configuration integrity across lifecycle operations.

This protocol is used when feature flags introduce new modules/fields that must persist correctly through export/import and must **not** leak when disabled.

---

## 2. Scope

Applies to:
- Agent Settings profiles
- Any profile type that supports export/import and contains feature-flag-gated modules

Validates:
- Module presence/absence integrity
- Field preservation
- Import compatibility across tenant variants (Platform/Legacy, MSSP Parent/Child where applicable)
- Rollback artifact-free behavior

---

## 3. Preconditions

- Tenant(s) available (Platform primary; Legacy sanity)
- Relevant feature flags and dependency flags are in a known state
- At least one endpoint exists that the profile can be assigned to (if behavioral validation is required)

---

## 4. Standard Workflow (Happy Path)

### Step A — Export
1. Navigate to the profile management area and export the target profile.
2. Confirm an export artifact is created (file download / export package).
3. Store export under `artifacts/exports/` with a timestamped name.

Expected:
- Export completes without error.
- Export artifact is downloadable and non-empty.

### Step B — Delete
1. Delete the target profile from the console.
2. Confirm deletion completes.
3. Confirm the profile is no longer selectable/assignable.

Expected:
- Profile deletion succeeds.
- No “ghost” profile remains in UI.

### Step C — Import
1. Import the previously exported profile.
2. Confirm import completes successfully.
3. Confirm imported profile appears in UI and is editable.

Expected:
- Import succeeds with no schema errors.
- Imported profile is functionally equivalent to the exported profile.

---

## 5. Module/Field Integrity Validation

After import, validate across surfaces:

### 5.1 UI
- Expected modules are visible when feature is enabled.
- Feature-gated modules are absent when feature is disabled.
- Default values remain consistent (no unexpected enablement).

### 5.2 WebUI (DevTools)
- Inspect `get_profile_view_by_id` (or equivalent) for the imported profile.
- Confirm:
  - Feature fields present only when allowed
  - No stale/hidden fields returned when disabled

### 5.3 PAPI
- `POST /public_api/v1/profiles/prevention/get_modules`
  - Module present when enabled
  - Module absent when disabled
- Add/Edit profile operations:
  - Accept valid payloads when enabled
  - Reject forbidden payloads when disabled

---

## 6. Negative / Edge Validation

At minimum, include one of the following per cycle when export/import is in-scope:

1. **Import while feature disabled**:
   - Export profile while enabled (contains feature fields)
   - Disable flag
   - Attempt import
   - Expect either:
     - Import rejects with clear validation error, or
     - Import succeeds but feature-gated fields are stripped/ignored (must be verified explicitly)

2. **Re-export after import**:
   - Export the imported profile and compare expected fields presence/absence relative to current flag state.

3. **Assignment sanity** (optional but recommended):
   - Assign imported profile to endpoint and validate behavioral effect (e.g., credential prompt behavior) matches expectation.

---

## 7. Evidence Requirements

Capture:
- Export artifact filename and timestamp
- Screenshot of successful import confirmation
- DevTools snippet showing relevant profile fields (redacted if needed)
- PAPI request/response captures for get_modules and add/edit behavior

---

End of Protocol (v1.0.0)
