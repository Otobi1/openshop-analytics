#!/usr/bin/env bash
set -euo pipefail

BASE="Users/tobi/Documents/Projects/openshop-analytics"
INGEST="$BASE/01_ingest"
DBT="$BASE/02_dbt"

echo "Starting full pipeline orchestration"

echo
echo "Module 1: Ingestion"
pushd "$INGEST" > /dev/null
bash check.sh
popd > /dev/null

echo
echo "Module 2: Transformation"
pushd "$DBT" > /dev/null
bash check.sh
popd > /dev/null

echo
echo "Orchestration succeeded!"

# 0 * * * * cd /Users/tobi/Documents/Projects/openshop-analytics/03_orchestrate && ./orchestrate.sh >> orchestrate.log 2>&1

