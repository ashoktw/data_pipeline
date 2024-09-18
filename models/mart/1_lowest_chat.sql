WITH daily_counts AS 
(
SELECT EXTRACT(DATE FROM resolved_at_tz) as date, count(*) AS resolved_count 
FROM {{ ref('stg_chat_cat') }} 
WHERE resolved_at_tz is not null
group by EXTRACT(DATE FROM resolved_at_tz)
),

lowest_count AS
(
    SELECT * FROM daily_counts
    ORDER BY resolved_count ASC
    LIMIT 1
)

SELECT * FROM lowest_count