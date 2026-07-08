with order_date_bounds as (
    select
        min(order_date) as min_date,
        max(coalesce(shipped_date, required_date, order_date)) as max_date
    from {{ ref('stg_orders') }}
),

date_spine as (
    select generate_series(min_date, max_date, interval '1 day')::date as date_day
    from order_date_bounds
)

select
    date_day,
    extract(isodow from date_day)::integer as day_of_week,
    extract(day from date_day)::integer as day_of_month,
    extract(doy from date_day)::integer as day_of_year,
    extract(week from date_day)::integer as week_of_year,
    extract(month from date_day)::integer as month_of_year,
    to_char(date_day, 'Month') as month_name,
    extract(quarter from date_day)::integer as quarter_of_year,
    extract(year from date_day)::integer as year_number
from date_spine
