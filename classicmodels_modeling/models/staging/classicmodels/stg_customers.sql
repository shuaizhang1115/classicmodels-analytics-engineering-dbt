select
    customernumber::integer as customer_number,
    customername::varchar as customer_name,
    contactlastname::varchar as contact_last_name,
    contactfirstname::varchar as contact_first_name,
    phone::varchar as phone,
    addressline1::varchar as address_line_1,
    nullif(addressline2, '')::varchar as address_line_2,
    city::varchar as city,
    nullif(state, '')::varchar as state,
    postalcode::varchar as postal_code,
    country::varchar as country,
    salesrepemployeenumber::integer as sales_rep_employee_number,
    creditlimit::numeric(12, 2) as credit_limit
from {{ source('classicmodels', 'customers') }}
