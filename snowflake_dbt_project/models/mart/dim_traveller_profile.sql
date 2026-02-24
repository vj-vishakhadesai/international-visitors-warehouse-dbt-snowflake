{{ config(materialized='table') }}

select
    RESPONSE_ID,
    GENDER,
    AGE_RANGE,
    COUNTRY_OF_RESIDENCE,
    COUNTRY_OF_RESIDENCE_GROUP,
    AU_STATE_OF_ORIGIN

from {{ ref('int_survey_main_header') }}