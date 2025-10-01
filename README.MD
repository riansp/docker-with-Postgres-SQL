# 🚀 CRM Complaints Analysis -- Data Engineer Test Case

This project uses **PostgreSQL with Docker** (via Play with Docker /
PWD) to ingest CSV data and run analytical queries.

## 📂 Project Structure

    docker-with-Postgres-SQL/
    │── docker-compose.yml
    │── data/
    │   ├── CRMEvents.csv
    │   ├── CRMCallCenterLogs.csv
    │── queries/
    │   ├── avg_agent.sql
    │   ├── avg_product.sql
    │   ├── avg_res_time.sql
    │   ├── top_issue.sql
    │── init/
    │   └── init.sql
    │── README.md

------------------------------------------------------------------------

## ⚙️ 1. Setup Environment on Play with Docker (PWD)

1.  Open [Play with Docker](https://labs.play-with-docker.com/).\
2.  Start a new instance.\
3.  Clone the repository from GitHub:

``` bash
git clone https://github.com/riansp/docker-with-Postgres-SQL.git
cd docker-with-Postgres-SQL
```

------------------------------------------------------------------------

## 🐳 2. Run Docker Compose

``` bash
docker compose up -d
```

Check running containers:

``` bash
docker ps
```

You should see the `crm_postgres` service running with port mapping
`5432:5432`.

------------------------------------------------------------------------

## 📥 3. Load CSV Data into Database

Import CSV files from the `data/` folder:

``` bash
docker exec -i crm_postgres psql -U admin -d crm_db -c "\copy crm_events FROM '/data/CRMEvents.csv' CSV HEADER;"
docker exec -i crm_postgres psql -U admin -d crm_db -c "\copy crm_call_logs FROM '/data/CRMCallCenterLogs.csv' CSV HEADER;"
```

Verify the data:

``` bash
docker exec -i crm_postgres psql -U admin -d crm_db -c "SELECT * FROM crm_events LIMIT 5;"
```

------------------------------------------------------------------------

## 📊 4. Run Analytical Queries

Several SQL scripts are available in the `queries/` folder. Run them as
follows:

``` bash
docker exec -i crm_postgres psql -U admin -d crm_db -f /queries/avg_agent.sql
docker exec -i crm_postgres psql -U admin -d crm_db -f /queries/avg_product.sql
docker exec -i crm_postgres psql -U admin -d crm_db -f /queries/avg_res_time.sql
docker exec -i crm_postgres psql -U admin -d crm_db -f /queries/top_issue.sql
```

> ⚠️ **Note:** Ensure the `queries/` folder is mounted into the
> container via `docker-compose.yml`. Otherwise, move it under
> `data/queries/` so that it is accessible.

------------------------------------------------------------------------

## 🧹 5. Stop & Clean Up

To stop the container:

``` bash
docker compose down
```

------------------------------------------------------------------------

### ✅ Workflow Summary in PWD

1.  Clone the GitHub repo\
2.  Run `docker compose up -d`\
3.  Import CSV data using `\copy`\
4.  Execute SQL queries from `.sql` files\
5.  Run `docker compose down` when finished
