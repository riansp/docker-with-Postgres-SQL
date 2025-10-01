-- 4. Per Agent/Server
SELECT
  c.server,
  COUNT(*) AS total_calls,
  ROUND(AVG(EXTRACT(EPOCH FROM (
    CASE WHEN c.ser_exit < c.ser_start THEN c.ser_exit + INTERVAL '24 hours' - c.ser_start
         ELSE c.ser_exit - c.ser_start END
  )))/60::numeric, 2) AS avg_minutes
FROM crm_call_logs c
WHERE c.ser_start IS NOT NULL AND c.ser_exit IS NOT NULL
GROUP BY c.server
ORDER BY avg_minutes ASC;