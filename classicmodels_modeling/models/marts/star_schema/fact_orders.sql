with order_lines as (
    select * from {{ ref('stg_orderdetails') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

employees as (
    select * from {{ ref('stg_employees') }}
),

offices as (
    select * from {{ ref('stg_offices') }}
),

products as (
    select * from {{ ref('stg_products') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['order_lines.order_number', 'order_lines.order_line_number']) }} as fact_order_key,
    {{ dbt_utils.generate_surrogate_key(['customers.customer_number']) }} as customer_key,
    {{ dbt_utils.generate_surrogate_key(['employees.employee_number']) }} as employee_key,
    {{ dbt_utils.generate_surrogate_key(['offices.office_code']) }} as office_key,
    {{ dbt_utils.generate_surrogate_key(['products.product_code']) }} as product_key,
    orders.order_number,
    order_lines.order_line_number,
    orders.order_date,
    orders.required_date,
    orders.shipped_date,
    orders.order_status,
    order_lines.quantity_ordered,
    order_lines.price_each,
    products.buy_price,
    round(order_lines.quantity_ordered * order_lines.price_each, 2) as line_revenue,
    round(order_lines.quantity_ordered * (order_lines.price_each - products.buy_price), 2) as line_profit,
    case
        when orders.shipped_date is null then null
        else orders.shipped_date - orders.order_date
    end as days_to_ship,
    case
        when orders.shipped_date is null then null
        when orders.shipped_date > orders.required_date then true
        else false
    end as is_late_shipment
from order_lines
join orders
    on order_lines.order_number = orders.order_number
join customers
    on orders.customer_number = customers.customer_number
join employees
    on customers.sales_rep_employee_number = employees.employee_number
join offices
    on employees.office_code = offices.office_code
join products
    on order_lines.product_code = products.product_code
