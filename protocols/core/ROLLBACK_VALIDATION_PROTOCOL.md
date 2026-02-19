# Rollback Validation Protocol
Version: v1.0.0

Every feature must validate:

- Clean disable
- No UI residue
- No PAPI residue
- No DB residue
- No enforcement residue

Rollback must produce a tenant state indistinguishable from baseline.
