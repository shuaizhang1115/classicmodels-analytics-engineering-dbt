select
    {{ dbt_utils.generate_surrogate_key(['products.product_code']) }} as product_key,
    products.product_code,
    products.product_name,
    products.product_line,
    productlines.product_line_description,
    products.product_scale,
    products.product_vendor,
    products.product_description,
    products.quantity_in_stock,
    products.buy_price,
    products.msrp
from {{ ref('stg_products') }} as products
left join {{ ref('stg_productlines') }} as productlines
    on products.product_line = productlines.product_line
