select
    productline::varchar as product_line,
    textdescription::text as product_line_description
from {{ source('classicmodels', 'productlines') }}
