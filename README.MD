# CRM Complaints Analysis 

This project demonstrates a data engineering workflow to analyze CRM complaints and call center logs. The goal is to calculate the average resolution time of complaints across different dimensions (product, issue type, agent) and present insights in a summarized form.

1. Tech Stack

PostgreSQL (containerized via Docker)
Docker Compose for orchestration
Python + Pandas (for initial data preprocessing if needed)
SQL for data transformation and aggregation
Matplotlib / Tableau (optional for visualization)

2. Project Structure

├── docker-compose.yml      # Docker services (Postgres, Adminer)
├── init.sql                # Schema creation
├── load_data.sh            # Script to load CSV data into Postgres
├── CRMEvents.csv           # Source data (CRM events)
├── CRMCallCenterLogs.csv   # Source data (CRM call logs)
├── queries.sql             # Example analytical queries
└── README.md               # Documentation

3. Setup Instructions

Step 1 – Start PostgreSQL with Docker

bash
docker-compose up -d


This will launch:

PostgreSQL database (localhost:5432)
Adminer web UI (localhost:8080)

Step 2 – Initialize Schema

bash
docker exec -i crm-postgres psql -U postgres -d crm < init.sql

Step 3 – Load Data

bash
bash load_data.sh

This script copies CSV files into the container and loads them into the corresponding tables.

Step 4 – Run Queries

bash
docker exec -it crm-postgres psql -U postgres -d crm -f queries.sql

Example output:

Average resolution time overall = 11 minutes 39 seconds
By Issue → Application processing delay takes the longest (15 min 48 sec).
By Agent → AVNI is the fastest (10 min 20 sec), BENSION the slowest (12 min 46 sec).

4. Workflow Summary

1. Data ingestion → Import raw CSV (Excel source) into PostgreSQL.
2. Data modeling → Create tables for CRM Events & Call Logs.
3. Data integration → Join both tables on `Complaint_ID`.
4. Data transformation → Calculate resolution time (seconds → minutes).
5. Analytics → Aggregate averages by dimensions (Product, Issue, Agent).
6. Visualization → Charts & slide deck summarizing findings.

5. Key Insights

Overall resolution is efficient (< 12 minutes).
Certain issues (e.g., application processing delay) are bottlenecks.
Agent performance varies; best practices from top agents can be shared.

✅ This pipeline can be extended for automation, monitoring, and visualization with BI tools like Tableau or Power BI.
