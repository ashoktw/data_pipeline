WITH resolution_rate AS 
(
SELECT parent_id AS category, COUNTIF(resolved_at_tz IS NOT NULL) / COUNT(*) as res_rate
FROM {{ ref('stg_chat_cat') }} 
GROUP BY parent_id
),

lowest_res_category AS
(
    SELECT * FROM resolution_rate
    ORDER BY res_rate ASC
    LIMIT 10
)

SELECT * FROM lowest_res_category