select
    officecode::varchar as office_code,
    city::varchar as city,
    phone::varchar as phone,
    addressline1::varchar as address_line_1,
    nullif(addressline2, '')::varchar as address_line_2,
    nullif(state, '')::varchar as state,
    country::varchar as country,
    postalcode::varchar as postal_code,
    territory::varchar as territory
from {{ source('classicmodels', 'offices') }}
