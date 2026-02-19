# <Protocol Name>

Version: vX.Y.Z  
Status: DRAFT / ACTIVE / DEPRECATED  
Owner: QA  

---

## 1. Purpose

Define the validation objective and architectural intent of this protocol.

---

## 2. Scope

### In Scope
- Explicitly list covered validation surfaces.

### Out of Scope
- Explicitly list excluded areas.

---

## 3. Definitions

Define any required terminology.

---

## 4. Enforcement Rules

- MUST statements
- MUST NOT statements
- Lifecycle invariants
- Cross-flag or cross-module constraints

These are non-negotiable.

---

## 5. Required Validation Surfaces

| Surface | Required | Notes |
|----------|----------|-------|
| UI | Yes/No | |
| WebUI | Yes/No | |
| Platform Public API | Yes/No | |
| Backend | Yes/No | |
| Database Integrity | Yes/No | |
| RBAC | Yes/No | |
| Tenant Isolation | Yes/No | |
| Rollback | Yes | Always required |

---

## 6. Validation Procedure

High-level deterministic steps.

No product-specific instructions.
No environment-specific hardcoding.

---

## 7. Evidence Requirements

List required artifacts:

- API response capture
- Log evidence
- Database verification
- UI inspection evidence
- Export/import validation

---

## 8. Failure Conditions

Explicitly define what constitutes protocol failure.

---

## 9. Rollback / Cleanup

Define cleanup expectations and residual state verification.

---

## 10. Version History

Document structural changes.
s