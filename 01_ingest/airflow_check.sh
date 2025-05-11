#!/usr/bin/env bash
set -euxo pipefail

# move into the module dir so that "data/" is on cwd
cd /opt/pipeline/modules/01_ingest

echo "Waiting for Postgres health…"
until pg_isready -h airflow-postgres -U analytics; do
  sleep 2
done

echo "Loading sample CSV…"
# now this will see ./data/sample_transactions.csv
/usr/bin/env python3 airflow_load_csv.py

# changed the host here to airflow-postgres instead of localhost
echo "Verifying row count…"
psql postgresql://analytics:analytics@airflow-postgres:5432/analytics \
  -c "SELECT COUNT(*) FROM raw.transactions;" \
  | tee /dev/stderr

echo "Module 1 complete!"
