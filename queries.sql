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

-- 3. Top 10 Issues by avg time
SELECT
  e.issue,
  ROUND(AVG(EXTRACT(EPOCH FROM (
    CASE WHEN c.ser_exit < c.ser_start THEN c.ser_exit + INTERVAL '24 hours' - c.ser_start
         ELSE c.ser_exit - c.ser_start END
  )))/60::numeric, 2) AS avg_minutes
FROM crm_events e
JOIN crm_call_logs c ON e.complaint_id = c.complaint_id
WHERE c.ser_start IS NOT NULL AND c.ser_exit IS NOT NULL
GROUP BY e.issue
ORDER BY avg_minutes DESC
LIMIT 10;

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
