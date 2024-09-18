SELECT
  EXTRACT(DAYOFWEEK FROM created_at_tz) as day_of_week_int,
  CASE EXTRACT(DAYOFWEEK FROM created_at_tz) 
    WHEN 1 THEN 'Sunday'
    WHEN 2 THEN 'Monday'
    WHEN 3 THEN 'Tuesday'
    WHEN 4 THEN 'Wednesday'
    WHEN 5 THEN 'Thursday'
    WHEN 6 THEN 'Friday'
    WHEN 7 THEN 'Saturday'
  END AS day_of_week,
  EXTRACT(HOUR FROM created_at_tz) as hour_of_day,
  COUNT(*) as chat_count
  FROM {{ ref('stg_chat_cat') }} 
GROUP BY day_of_week_int, day_of_week, hour_of_day
ORDER BY day_of_week_int, hour_of_day