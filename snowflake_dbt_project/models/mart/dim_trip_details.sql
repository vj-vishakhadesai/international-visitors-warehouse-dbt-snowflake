{{ config(materialized='table') }}

select
    RESPONSE_ID,
    YEAR,
    QTR,
    INTERVIEW_DATE,
    ARRIVAL_DATE,
    AIRPORT,
    PURPOSE_OF_VISIT_MAIN,
    PURPOSE_SUBTYPE,
    ARRIVAL_METHOD,
    FIRST_NZ_TRIP,
    TRAVEL_TYPE,
    MAIN_TRANSPORT_TYPE,
    PACKAGE_DEAL,
    PKG_INCLUDED_AIRFARE,
    VISITED_NI,
    VISITED_SI,
    CURRENCY
from {{ ref('int_survey_main_header') }}