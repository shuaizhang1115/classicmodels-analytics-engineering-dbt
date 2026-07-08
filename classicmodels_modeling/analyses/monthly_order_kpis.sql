select
    date_trunc('month', order_date)::date as order_month,
    count(distinct order_number) as orders,
    sum(quantity_ordered) as units_sold,
    round(sum(line_revenue), 2) as revenue,
    round(sum(line_profit), 2) as profit
from {{ ref('orders_obt') }}
group by 1
order by 1
