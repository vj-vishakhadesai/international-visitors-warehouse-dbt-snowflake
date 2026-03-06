{{ config(materialized='incremental') }}

select * from {{source("raw", "survey_main_header")}}

{% if is_incremental() %}
    WHERE DATE > (SELECT MAX(DATE) FROM {{ this }})
{% endif %}