{{ config(materialized='table') }}

select
RESPONSE_ID,
PLACE_STAYED,
cast(NIGHTS as NUMBER(38,0))as NIGHTS 
from {{ref("stg_itinerary")}}