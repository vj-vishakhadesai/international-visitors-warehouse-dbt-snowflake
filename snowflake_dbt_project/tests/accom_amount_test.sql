{{ config(severity='warn') }}

select
    1
from 
    {{ source('raw','expenditure_by_industry') }}
WHERE 
    COST_ACCOMM < 0