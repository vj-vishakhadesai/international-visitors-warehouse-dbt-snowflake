{{config(materialized='table')}}

select 
RESPONSE_ID,
TRANSPORT_METHOD
from {{ref("stg_transport_method")}}