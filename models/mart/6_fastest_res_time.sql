WITH resolution_time AS 
(
SELECT parent_id AS category, 
ROUND( AVG(DATETIME_DIFF(resolved_at_tz, created_at_tz, HOUR)), 2 ) as res_time_hrs
FROM {{ ref('stg_chat_cat') }} 
GROUP BY parent_id
),

fastest_res_category AS
(
    SELECT * FROM resolution_time
    ORDER BY res_time_hrs ASC
    LIMIT 10
)

SELECT * FROM fastest_res_category