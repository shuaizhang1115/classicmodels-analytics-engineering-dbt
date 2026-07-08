select
    {{ dbt_utils.generate_surrogate_key(['customer_number']) }} as customer_key,
    customer_number,
    customer_name,
    contact_first_name,
    contact_last_name,
    phone,
    address_line_1,
    address_line_2,
    city,
    state,
    postal_code,
    country,
    credit_limit,
    sales_rep_employee_number
from {{ ref('stg_customers') }}
