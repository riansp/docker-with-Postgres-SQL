-- 2. Average per Product
SELECT
  e.product,
  ROUND(AVG(EXTRACT(EPOCH FROM (
    CASE WHEN c.ser_exit < c.ser_start THEN c.ser_exit + INTERVAL '24 hours' - c.ser_start
         ELSE c.ser_exit - c.ser_start END
  )))/60::numeric, 2) AS avg_minutes
FROM crm_events e
JOIN crm_call_logs c ON e.complaint_id = c.complaint_id
WHERE c.ser_start IS NOT NULL AND c.ser_exit IS NOT NULL
GROUP BY e.product
ORDER BY avg_minutes DESC;