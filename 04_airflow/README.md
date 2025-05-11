# Module 4: Orchestration with Airflow

## Overview 

Use Airflow scheduler and UI to run Mod 1 & 2 every hour

### DAG 

- **Name**: `full_pipeline`
- **Tasks**:
  1. `ingest` → runs `01_ingest/check.sh`
  2. `transform` → runs `02_dbt/check.sh`
- **Schedule**: `@hourly`
- **Retries**: 1 (with 5 min backoff)

## Run Airflow 

```bash 
docker compose -f docker-compose.airflow.yml up -d
```

## Note
- some duplicated files (to ensure Mods 1, 2, 3 still run given the changes necessary for Mod 4)
- revised check.sh from Mod 1 & 2 to remove the need to bring up docker within Airflow
- changed host from `localhost` to `airflow-postgres` therefore load_csv.py needed to be duplicated