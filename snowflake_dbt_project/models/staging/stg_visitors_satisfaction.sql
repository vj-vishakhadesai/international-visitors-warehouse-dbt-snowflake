{{ config(materialized='table') }}

select * from {{source("raw", "visitors_satisfaction")}}