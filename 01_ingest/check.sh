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

echo "Verifying row count…"
docker exec -it openshop-postgres \
  psql -U analytics -d analytics -c "SELECT COUNT(*) FROM raw.transactions;" \
  | tee /dev/stderr

echo "Module 1 complete!"