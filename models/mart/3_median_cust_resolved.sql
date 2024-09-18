WITH daily_counts AS 
(
SELECT EXTRACT(DATE FROM resolved_at_tz) as date, count(*) AS resolved_count 
FROM {{ ref('stg_chat_cat') }} 
WHERE resolved_at_tz is not null
AND is_customer_initiated
group by EXTRACT(DATE FROM resolved_at_tz)
),

median_count AS
(
    SELECT PERCENTILE_CONT(resolved_count, 0.5) OVER() AS median_row_count
    FROM daily_counts
    LIMIT 1

)

SELECT * FROM median_count