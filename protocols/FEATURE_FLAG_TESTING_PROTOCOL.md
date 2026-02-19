# Feature Flag Testing Protocol
Version: v1.0.0
Status: Active
Owner: Systems QA

## Purpose
Define standardized methodology for validating feature flags across UI, WebUI, PAPI, and backend surfaces.

## Core Rules

1. Platform tenant always executed first.
2. Legacy tenant always executed last.
3. Only one flag enabled at a time.
4. Parent flags must be enabled before children.
5. Children must be disabled before parent.
6. Every flag lifecycle must include:
   - Baseline
   - Enable (positive flow)
   - Negative tests
   - Rollback validation

## Required Validation Surfaces

- UI module visibility
- Context menus
- Action Center logging
- Browser DevTools network inspection
- PAPI get_modules validation
- Backend rejection of malformed and forbidden payloads

## Rollback Criteria

After disabling a flag:
- No module visible in UI
- No module returned in PAPI
- No stale config in export
- No orphan enforcement
- Tenant indistinguishable from baseline
