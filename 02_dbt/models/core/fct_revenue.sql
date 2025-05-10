{{ config(alias="fct_revenue") }}

select
  date_trunc('day', occurred_at) as day,
  count(*) as total_transactions,
  sum(amount) as total_revenue
from {{ ref('stg_transactions') }}
group by 1
