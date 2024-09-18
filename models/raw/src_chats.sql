SELECT id, chat_category_id, 
EXTRACT( DATETIME FROM created_at AT TIME ZONE 'Australia/Melbourne') AS created_at_tz,
is_customer_initiated,
EXTRACT( DATETIME FROM resolved_at AT TIME ZONE 'Australia/Melbourne') AS resolved_at_tz
FROM
{{ source('customer_chat', 'de_test_chats') }}

{% if not var('complete_data') %}
    WHERE created_at_tz
    >= DATETIME_SUB(CURRENT_DATETIME('Australia/Melbourne'), 
    INTERVAL {{ var('interval_duration') }} {{ var('interval_name') }})
{% endif %}



