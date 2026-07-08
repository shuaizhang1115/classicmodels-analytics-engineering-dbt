select
    ordernumber::integer as order_number,
    orderdate::date as order_date,
    requireddate::date as required_date,
    nullif(shippeddate::text, '')::date as shipped_date,
    status::varchar as order_status,
    nullif(comments, '')::varchar as order_comments,
    customernumber::integer as customer_number
from {{ source('classicmodels', 'orders') }}
