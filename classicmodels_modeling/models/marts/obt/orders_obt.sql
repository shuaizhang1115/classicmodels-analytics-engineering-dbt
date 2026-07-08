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
),

productlines as (
    select * from {{ ref('stg_productlines') }}
)

select
    orders.order_number,
    order_lines.order_line_number,
    orders.order_status,
    orders.order_date,
    orders.required_date,
    orders.shipped_date,
    case
        when orders.shipped_date is null then null
        else orders.shipped_date - orders.order_date
    end as days_to_ship,
    case
        when orders.shipped_date is null then null
        when orders.shipped_date > orders.required_date then true
        else false
    end as is_late_shipment,
    customers.customer_number,
    customers.customer_name,
    customers.city as customer_city,
    customers.state as customer_state,
    customers.country as customer_country,
    customers.credit_limit as customer_credit_limit,
    employees.employee_number as sales_rep_employee_number,
    employees.first_name || ' ' || employees.last_name as sales_rep_name,
    employees.job_title as sales_rep_title,
    offices.city as sales_office_city,
    offices.country as sales_office_country,
    offices.territory as sales_office_territory,
    products.product_code,
    products.product_name,
    products.product_line,
    productlines.product_line_description,
    products.product_scale,
    products.product_vendor,
    products.buy_price,
    products.msrp,
    order_lines.quantity_ordered,
    order_lines.price_each,
    round(order_lines.quantity_ordered * order_lines.price_each, 2) as line_revenue,
    round(order_lines.quantity_ordered * (order_lines.price_each - products.buy_price), 2) as line_profit,
    round(
        (order_lines.price_each - products.buy_price) / nullif(order_lines.price_each, 0),
        4
    ) as gross_margin_pct
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
left join productlines
    on products.product_line = productlines.product_line
