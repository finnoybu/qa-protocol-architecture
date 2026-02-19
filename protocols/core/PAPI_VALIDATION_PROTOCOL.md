# PAPI Validation Protocol

Version: v1.0.0  
Status: Active  
Owner: Systems QA  

---

## 1. Purpose

Define standardized validation methodology for:

- Public API (PAPI) module exposure
- Add/Edit profile validation
- Backend rejection logic
- Feature flag gating enforcement

---

## 2. Core Endpoints

Primary endpoint:

POST  
/public_api/v1/profiles/prevention/get_modules

Validate:

- Module presence when feature enabled
- Module absence when feature disabled

---

## 3. Positive Validation

When feature enabled:

- Module returned in get_modules
- Add/Edit accepts valid JSON
- Profile save successful
- No unexpected schema errors

---

## 4. Negative Validation

When feature disabled:

- Module not returned
- Add/Edit request rejected
- Validation error returned
- No silent acceptance

---

## 5. Malformed JSON Testing

Submit:

- Incorrect field type
- Missing required fields
- Invalid enum values
- Unexpected nested object

Expected:

- 4xx validation error
- Clear message
- No DB mutation

---

## 6. Forbidden JSON Testing

Submit:

- Valid schema
- Feature field included while FF disabled

Expected:

- Explicit rejection
- No silent storage

---

## 7. RBAC Validation

Test:

- Non-admin role
- MSSP parent vs child
- Restricted role

Expected:

- Permission enforcement
- No privilege escalation

---

End of Protocol (v1.0.0)
