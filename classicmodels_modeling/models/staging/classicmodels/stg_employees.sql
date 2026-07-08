select
    employeenumber::integer as employee_number,
    lastname::varchar as last_name,
    firstname::varchar as first_name,
    extension::varchar as extension,
    email::varchar as email,
    officecode::varchar as office_code,
    nullif(reportsto::text, '')::integer as reports_to,
    jobtitle::varchar as job_title
from {{ source('classicmodels', 'employees') }}
