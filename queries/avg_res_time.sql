-- 1. Overall average resolution time (menit)
SELECT ROUND(
  (EXTRACT(EPOCH FROM AVG(
    CASE
      WHEN ser_exit < ser_start THEN ser_exit + INTERVAL '24 hours' - ser_start
      ELSE ser_exit - ser_start
    END
  ))/60)::numeric, 2
) AS avg_resolution_minutes
FROM crm_call_logs
WHERE ser_start IS NOT NULL AND ser_exit IS NOT NULL;