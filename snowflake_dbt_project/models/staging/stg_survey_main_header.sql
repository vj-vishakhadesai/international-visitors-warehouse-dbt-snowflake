{{ config(materialized='table') }}

select * from {{source("raw", "survey_main_header")}}