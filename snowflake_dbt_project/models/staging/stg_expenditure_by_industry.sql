{{ config(materialized='table') }}

select * from {{source("raw", "expenditure_by_industry")}}