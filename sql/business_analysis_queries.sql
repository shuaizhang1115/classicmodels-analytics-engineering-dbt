-- Example 1: Monthly revenue trend
select
    date_trunc('month', order_date)::date as order_month,
    round(sum(line_revenue), 2) as revenue,
    round(sum(line_profit), 2) as profit
from obt.orders_obt
group by 1
order by 1;

-- Example 2: Revenue and margin by product line
select
    product_line,
    round(sum(line_revenue), 2) as revenue,
    round(sum(line_profit), 2) as profit,
    round(sum(line_profit) / nullif(sum(line_revenue), 0), 4) as gross_margin_pct
from obt.orders_obt
group by 1
order by revenue desc;

-- Example 3: Top customers by revenue
select
    customer_name,
    customer_country,
    round(sum(line_revenue), 2) as revenue,
    count(distinct order_number) as orders
from obt.orders_obt
group by 1, 2
order by revenue desc;

-- Example 4: Late shipment rate by sales office
select
    sales_office_territory,
    sales_office_city,
    count(distinct order_number) as total_orders,
    count(distinct order_number) filter (where is_late_shipment) as late_orders,
    round(
        count(distinct order_number) filter (where is_late_shipment)::numeric
        / nullif(count(distinct order_number), 0),
        4
    ) as late_order_rate
from obt.orders_obt
where order_status in ('Shipped', 'Resolved')
group by 1, 2
order by late_order_rate desc;

-- Example 5: Sales representative performance
select
    sales_rep_name,
    sales_office_territory,
    count(distinct customer_number) as customers,
    count(distinct order_number) as orders,
    round(sum(line_revenue), 2) as revenue,
    round(sum(line_profit), 2) as profit
from obt.orders_obt
group by 1, 2
order by revenue desc;
