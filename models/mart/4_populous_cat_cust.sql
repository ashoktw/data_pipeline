WITH customer_chat AS 
(
SELECT parent_id AS category, count(*) as chat_count 
FROM {{ ref('stg_chat_cat') }} 
WHERE is_customer_initiated
GROUP BY parent_id
),

populous_cat AS
(
    SELECT * FROM customer_chat
    ORDER BY chat_count DESC
    LIMIT 10
)

SELECT * FROM populous_cat