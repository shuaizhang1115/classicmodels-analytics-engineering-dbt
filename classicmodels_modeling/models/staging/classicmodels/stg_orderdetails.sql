select
    ordernumber::integer as order_number,
    productcode::varchar as product_code,
    quantityordered::integer as quantity_ordered,
    priceeach::numeric(12, 2) as price_each,
    orderlinenumber::integer as order_line_number
from {{ source('classicmodels', 'orderdetails') }}
