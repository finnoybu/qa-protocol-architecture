# Agent Credential Model
Version: v1.0.0
Status: Active
Owner: Systems QA
Last Updated: 2026-02-19 15:04:46

---

## 1. Purpose

Define the authoritative credential model for agent-side administrative prompts (e.g., cytool “Enter supervisor password”) and how credentials are resolved across configuration layers.

This model is used to design and validate tests involving uninstall passwords, tamper protection, and admin token features.

---

## 2. Credential Types

### 2.1 Uninstall Password (Administrative Password) — User Credential
A human-managed password used for agent administrative operations.

Sources (highest specificity wins):

1. **Agent Settings profile override** (targeted agents/policies)
2. **Server Settings override** (admin-configured global value)
3. **Global default uninstall password** (tenant default)

Only one uninstall password is valid at any moment for a given endpoint, determined by highest specificity.

---

### 2.2 Temporary Token — User Credential
A time-bound password created by an administrator for a specific endpoint.

Characteristics:
- Created via the **All Endpoints** workflow (when supported)
- Valid for **1–21 days**
- Overrides uninstall password **while active**
- Can be retrieved/viewed only when a token is active (UI may hide “View” otherwise)
- A token hash can be retrieved agent-side (e.g., via cytool token query) and decrypted via UI “Retrieve Token”

---

### 2.3 Rolling Token — System Credential
A system-managed credential used by the backend for server-initiated administrative operations.

Characteristics:
- Automatically generated per endpoint
- Rotates every **14 days**
- **Not user-visible**
- **Not retrievable**
- No manual rotation/expiration controls
- Not directly testable by “viewing the token value”

Testing guidance:
- Rolling token behavior must be validated **behaviorally** via supported server-to-agent flows (if/when such flows exist).
- Do not design tests that assume the rolling token can be displayed or copied.

---

## 3. Credential Resolution Priority (When Prompted)

When the agent prompts: **“Enter supervisor password:”**

Valid credentials are resolved as:

1. **Temporary Token** (only if active / not expired)
2. **Uninstall Password** (highest specificity among: Agent Settings override > Server override > Default)

Notes:
- Temporary token supersedes uninstall password during its active window.
- Rolling token does not participate in user-entered credential resolution (system-only).

---

## 4. Validation Requirements

Any feature affecting credentials must validate:

- Correct priority (Temporary token overrides uninstall password)
- Specificity (Agent Settings override supersedes server and default)
- Expiration behavior (temporary token invalid post-expiry)
- Negative attempt behavior (incorrect password rejected, no silent success)
- Rollback integrity (post-disable, credentials revert to baseline model)

---

End of Model (v1.0.0)
