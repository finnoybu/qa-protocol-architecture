# Backend Integrity & Handler Validation Protocol

Version: v1.0.0\
Status: Restricted\
Owner: Systems QA

------------------------------------------------------------------------

## 1. Purpose

Define a controlled, repeatable methodology for validating system
stability and recovery behavior when:

-   A profile/module record is manually altered in MySQL
-   A required module is missing or corrupted
-   Version control handlers are expected to restore integrity
-   secdo-init is restarted/scaled to trigger recovery logic

This protocol is intended for dev/QA tenants only and must be executed
with an explicit rollback plan.

------------------------------------------------------------------------

## 2. Preconditions and Safety Controls

-   Tenant: Dev/QA only (never production)
-   Access: Approved MySQL access (read/write) and ability to
    scale/restart services
-   Backups: You must export any impacted profile before DB modification
-   Rollback Plan: Documented steps to restore original profile state
-   Scope Control: Ensure changes are isolated to the specific
    tenant/environment under test

------------------------------------------------------------------------

## 3. Test A --- Remove Module From Saved Profile Record

### Goal

Validate the system's ability to safely handle a profile whose saved
module list is missing a required module.

### Steps

1.  Export the target Linux Agent Settings profile as a backup.
2.  Identify the saved profile record(s) in MySQL for the target
    profile.
3.  Remove the module object/entry for the target feature from the saved
    profile payload.
4.  Open the modified profile in the UI.
5.  Attempt to save the profile without further changes.
6.  Attempt to assign/push the profile to a Linux endpoint.

### Expected Results

-   UI loads without crash.
-   Save either auto-restores missing module safely or fails cleanly
    with validation error.
-   Push does not crash services.
-   No uncontrolled state (no duplication, no orphan configs).

------------------------------------------------------------------------

## 4. Test B --- Corrupt Module Payload and Validate Rejection/Repair

### Goal

Validate behavior when a module exists but has malformed schema/content.

### Steps

1.  Export the target profile as a backup.
2.  Modify the module payload to a malformed but parseable structure.
3.  Load profile in UI.
4.  Attempt to save profile.
5.  Attempt to push to endpoint.

### Expected Results

-   UI does not crash.
-   System either rejects save with validation error or repairs payload
    to valid defaults.
-   Push does not cause backend failure.
-   No silent acceptance of malformed module.

------------------------------------------------------------------------

## 5. Test C --- Handler Recovery Validation

### Goal

Validate that the appropriate handler exists and performs recovery after
restart.

### Steps

1.  Confirm the handler exists using: SELECT \* FROM
    version_control_handlers WHERE
    func_name='sync_linux_uninstall_password_modules';
2.  With the module removed/corrupted, restart/scale secdo-init.
3.  Re-check the same profile record in DB.
4.  Reload profile in UI.
5.  Export profile again.

### Expected Results

-   Handler record exists.
-   After restart, module is restored or system returns to known-safe
    state.
-   UI renders expected modules.
-   Export contains expected module definitions.

------------------------------------------------------------------------

## 6. Fail Conditions (Immediate Stop)

Stop immediately if:

-   Service crash or restart loop occurs
-   Profile save results in partial/corrupted state
-   Duplicate module injection
-   Orphan configuration persists after rollback
-   Cross-tenant bleed occurs

------------------------------------------------------------------------

## 7. Cleanup / Rollback Requirements

1.  Restore original profile from export or revert DB payload.
2.  Restart/scale secdo-init if required.
3.  Validate UI renders normally.
4.  Validate PAPI get_modules returns expected output.
5.  Validate profile export is clean.
6.  Validate endpoint enforcement is normal.

------------------------------------------------------------------------

End of Protocol (v1.0.0)
