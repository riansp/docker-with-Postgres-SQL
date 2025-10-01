CREATE TABLE IF NOT EXISTS crm_events (
  date_received DATE,
  product TEXT,
  sub_product TEXT,
  issue TEXT,
  sub_issue TEXT,
  consumer_complaint_narrative TEXT,
  tags TEXT,
  consumer_consent_provided TEXT,
  submitted_via TEXT,
  date_sent_to_company DATE,
  company_response_to_consumer TEXT,
  timely_response TEXT,
  consumer_disputed TEXT,
  complaint_id TEXT PRIMARY KEY,
  client_id TEXT
);

CREATE TABLE IF NOT EXISTS crm_call_logs (
  date_received DATE,
  complaint_id TEXT,
  rand_client TEXT,
  phonefinal TEXT,
  vru_line TEXT,
  call_id BIGINT,
  priority INTEGER,
  type TEXT,
  outcome TEXT,
  server TEXT,
  ser_start TIME,
  ser_exit TIME,
  ser_time TEXT
);

-- \COPY crm_events(date_received, product, sub_product, issue, sub_issue, consumer_complaint_narrative,
--                  tags, consumer_consent_provided, submitted_via, date_sent_to_company, company_response_to_consumer,
--                  timely_response, consumer_disputed, complaint_id, client_id) FROM 'data\CRMEvents.csv' WITH CSV HEADER;
-- \COPY crm_call_logs(date_received, complaint_id, rand_client, phonefinal, vru_line, call_id, priority, type, outcome, 
--                     server, ser_start, ser_exit, ser_time) FROM 'data\CRMCallCenterLogs.csv' WITH CSV HEADER;