{{ config(
    materialized='incremental',
    unique_key='RESPONSE_ID',
    incremental_strategy='merge'
) }}


with survey as (
    select *
    from {{ ref('int_survey_main_header') }}
),

expenditure as (
    select *
    from {{ ref('int_expenditure_by_industry') }}
)

select

    s.RESPONSE_ID,
    s.CREATED_AT,  
    s.NO_DAYS_IN_NZ,
    s.TREATED_SPEND,
    s.POPULATION_WEIGHT,
    s.VEM_POP_WEIGHT,
    e.COST_ACCOMM,
    e.COST_DOM_TRAVEL,
    e.COST_FOOD_DRINK,
    e.COST_ENTERTAINMENT,
    e.COST_SHOPPING,
    e.COST_OTHER,
    e.COST_TOUR_PACKAGE,
    e.COST_DOM_FLIGHTS,
    e.COST_CAR_RENTALS,
    e.COST_EATING_OUT,
    e.COST_DAY_CRUISE,
    e.EXC_COST_INT_FLIGHTS,
    e.EXC_COST_MULTI_NIGHT_CRUISE,
    e.EXC_COST_TRAVEL_INSURANCE

from survey s
left join expenditure e
    on s.RESPONSE_ID = e.RESPONSE_ID

--{% if is_incremental() %}
 --   where s.CREATED_AT >  (select max(s.CREATED_AT) from {{ this }})
--{% endif %}
