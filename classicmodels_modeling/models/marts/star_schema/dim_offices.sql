select
    {{ dbt_utils.generate_surrogate_key(['office_code']) }} as office_key,
    office_code,
    city,
    phone,
    address_line_1,
    address_line_2,
    state,
    country,
    postal_code,
    territory
from {{ ref('stg_offices') }}
