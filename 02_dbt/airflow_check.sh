#!/usr/bin/env bash
set -euxo pipefail

# change into the dbt project directory
cd /opt/pipeline/modules/02_dbt

echo "Running dbt deps…"
dbt deps

echo "Running dbt models…"
dbt run --models staging.stg_transactions core.fct_revenue

echo "Testing dbt models…"
dbt test --models staging.stg_transactions core.fct_revenue

echo "Generating docs…"
dbt docs generate

echo "Module 2 complete!"
