#!/usr/bin/env bash


echo "Bringing up Postgres…"
docker-compose up -d

echo "Waiting for Postgres health…"
for i in {1..10}; do
  if docker exec openshop-postgres pg_isready -U analytics; then break; fi
  sleep 2
done

echo "Loading sample CSV…"
python3 load_csv.py

echo " Runnung dbt models…"
docker-compose run --rm dbt deps
docker-compose run --rm dbt run --models staging.stg_transactions core.fct_revenue

echo "Testing dbt models…"
docker-compose run --rm dbt test --models staging.stg_transactions core.fct_revenue

echo "Generating docs…"
docker-compose run --rm dbt docs generate

echo "Module 2 complete!"