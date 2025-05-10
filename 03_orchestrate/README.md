# Module 3: Orchestration PoC 

this module combined modules 1 and 2 in a single script.

## Files 
- **orchestrate.sh**: runs Module 1 (Ingest->Postgres) then Module 2 (dbt run/test).
- **check.sh**: test wrapper that exits non-zero on failure.

## Quick Start 
```bash
cd 03_orchestrate
check.sh
```