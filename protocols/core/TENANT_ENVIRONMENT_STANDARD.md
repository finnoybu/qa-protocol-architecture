# Tenant Environment Standard
Version: v1.0.0
Status: Active
Owner: Systems QA
Last Updated: 2026-02-19 15:04:46

---

## 1. Purpose

Define prerequisites and environmental controls for executing Cortex XDR / XSIAM test cycles in a consistent and repeatable way.

This standard prevents test failures caused by hidden tenant drift, stale feature flags, or inconsistent agent fleets.

---

## 2. Required Tenants

### 2.1 Platform Tenant (Primary)
Used for authoritative validation and full coverage.

### 2.2 Legacy Tenant (Sanity)
Used for a lighter repeat pass to confirm no platform-specific regressions.

Rule:
- Execute the full flow on Platform first.
- Repeat only the required sanity subset on Legacy last.

---

## 3. Agent Fleet Requirements

A test cycle must declare and verify:

- Supported OS coverage (Windows / macOS / Linux as applicable)
- Minimum required agent versions
- Mixed version fleet (required when version gating is in-scope)
- At least one endpoint per OS with stable connectivity

Recommended baseline for version-gated features:
- One agent below min-version threshold
- One agent at/above threshold
- One agent recently upgraded (upgrade-path validation)

---

## 4. Feature Flag State Discipline

Before execution:

1. Capture current feature flag state (screenshot or exported config).
2. Set the test cycle baseline:
   - Feature flags disabled or not present (baseline phase)
   - Confirm in backend config source (e.g., configmap-feature-flags, get_config)

During execution:

- Enable one feature flag per phase unless dependency requires otherwise.
- Confirm propagation (pod restart / refresh / cache invalidation) before validating UI or API exposure.

After each phase:

- Disable the flag and confirm rollback integrity (UI/WebUI/PAPI/endpoint).

---

## 5. Caching & Propagation Controls

Because UI and API exposure may be cached, the cycle must define how propagation is validated, such as:

- Browser hard refresh / cache clear
- Tenant service refresh / pod restart (if applicable)
- Re-fetch of get_config and get_profile_view_by_id
- Re-run PAPI get_modules

Evidence of propagation should be captured when bugs are suspected.

---

## 6. RBAC & Accounts

A cycle must define required roles/accounts:

- Admin account (full privileges)
- Non-admin / restricted account (RBAC negative testing)
- MSSP Parent and Child accounts (if MSSP validation is in-scope)

---

## 7. Environmental “Stop Conditions”

Testing must stop and be escalated if any of the following are observed:

- Tenant appears to have unknown/undeclared feature flags enabled
- Baseline cannot be established (feature visible while flags disabled)
- Endpoint fleet cannot meet stated version requirements
- PAPI returns inconsistent module definitions across tenants without explanation

---

## 8. Required Artifacts Per Cycle

Store under `artifacts/`:

- Evidence screenshots (UI/WebUI)
- Exported profiles (exports)
- PAPI request/response captures (as files, redacted if needed)
- Minimal cycle notes (what changed / what failed / where to look)

---

End of Standard (v1.0.0)
