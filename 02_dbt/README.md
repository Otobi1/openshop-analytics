# Module 2: dbt Core transformations

## Overview 

Transforms `raw.transactions` into 
- `raw.st_transactions` (view)
- `analytics.fct_revenue` (table)
including tests and documentation 

## Setup 

```bash
cd 02_dbt
docker compose up -d

./check.sh
```