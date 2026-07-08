select
    {{ dbt_utils.generate_surrogate_key(['employee_number']) }} as employee_key,
    employee_number,
    first_name,
    last_name,
    first_name || ' ' || last_name as employee_name,
    email,
    job_title,
    office_code,
    reports_to
from {{ ref('stg_employees') }}
