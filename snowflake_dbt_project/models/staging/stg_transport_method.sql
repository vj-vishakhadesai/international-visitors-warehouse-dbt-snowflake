{{ config(materialized='table') }}

select * from {{source("raw", "transform_method")}}