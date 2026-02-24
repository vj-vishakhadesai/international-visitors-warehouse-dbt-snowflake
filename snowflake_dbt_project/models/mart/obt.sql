{% set congigs = [
    {
        "table" : "IVS_ANALYTICS_DWH.INTERMEDIATE.INT_ITINERARY",
        "columns" : "INT_ITINERARY.*",
        "alias" : "INT_ITINERARY"
    },
    { 
        "table" : "IVS_ANALYTICS_DWH.INTERMEDIATE.INT_TRANSPORT_METHOD",
        "columns" : "INT_TRANSPORT_METHOD.TRANSPORT_METHOD",
        "alias" : "INT_TRANSPORT_METHOD",
        "join_condition" : "INT_ITINERARY.RESPONSE_ID =INT_TRANSPORT_METHOD.RESPONSE_ID "
    },
    {
        "table" : "IVS_ANALYTICS_DWH.INTERMEDIATE.INT_VISITORS_SATISFACTION",
        "columns" : "INT_VISITORS_SATISFACTION.SATISFACTION_RATING,INT_VISITORS_SATISFACTION.RECOMMEND_RATING",
        "alias" : "INT_VISITORS_SATISFACTION",
        "join_condition" : "INT_TRANSPORT_METHOD.RESPONSE_ID = INT_VISITORS_SATISFACTION.RESPONSE_ID"
    }
] %}



SELECT 
    {% for config in congigs %}
        {{ config['columns'] }}{% if not loop.last %},{% endif %}
    {% endfor %}
FROM
    {% for config in congigs %}
    {% if loop.first %}
      {{ config['table'] }} AS {{ config['alias'] }}
    {% else %}
        LEFT JOIN {{ config['table'] }} AS {{ config['alias'] }}
        ON {{ config['join_condition'] }}
        {% endif %}
        {% endfor %}