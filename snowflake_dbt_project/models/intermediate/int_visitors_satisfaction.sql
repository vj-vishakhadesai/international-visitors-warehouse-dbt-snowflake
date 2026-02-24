{{config(materialized='table')}}

select 
RESPONSE_ID,
nullif(SATISFACTION_RATING, 'NA') as SATISFACTION_RATING,
nullif(EXPECTATION_RATING, 'NA') as EXPECTATION_RATING,
nullif(RECOMMEND_RATING, 'NA') as RECOMMEND_RATING
from
{{ref("stg_visitors_satisfaction")}}