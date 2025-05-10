{{ config(alias="stg_transactions") }}

with source as (
  select * from raw.transactions
)

select
  transaction_id,
  customer_id,
  amount::numeric,
  currency,
  timestamp::timestamp as occurred_at
from source
