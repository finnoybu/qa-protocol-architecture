# PAPI Validation Protocol
Version: v1.0.0

## Required Tests Per Feature

1. get_modules exposure
2. Add/Edit profile with valid payload
3. Malformed JSON rejection
4. Valid-but-forbidden JSON rejection
5. RBAC enforcement validation

## Mandatory Endpoint

POST /public_api/v1/profiles/prevention/get_modules

Validate:
- Module present when enabled
- Module absent when disabled
