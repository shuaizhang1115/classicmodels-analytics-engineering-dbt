select
    productcode::varchar as product_code,
    productname::varchar as product_name,
    productline::varchar as product_line,
    productscale::varchar as product_scale,
    productvendor::varchar as product_vendor,
    productdescription::text as product_description,
    quantityinstock::integer as quantity_in_stock,
    buyprice::numeric(12, 2) as buy_price,
    msrp::numeric(12, 2) as msrp
from {{ source('classicmodels', 'products') }}
