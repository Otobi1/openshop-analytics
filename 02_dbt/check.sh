#!/usr/bin/env bash


echo "Bringing up Postgres…"
docker-compose up -d

echo "Waiting for Postgres health…"
for i in {1..10}; do
  if docker exec openshop-postgres pg_isready -U analytics; then break; fi
  sleep 2
done
# to make mod 2 work, without any orchestration, I had to add the mod 1 load csv py and the bash step here
# with mod 3 orchestration now, I can take it out, since, 3 calls 1 and the 2 
# echo "Loading sample CSV…"
# python3 load_csv.py

echo " Runnung dbt models…"
docker-compose run --rm dbt deps
docker-compose run --rm dbt run --models staging.stg_transactions core.fct_revenue

echo "Testing dbt models…"
docker-compose run --rm dbt test --models staging.stg_transactions core.fct_revenue

echo "Generating docs…"
docker-compose run --rm dbt docs generate

echo "Module 2 complete!"