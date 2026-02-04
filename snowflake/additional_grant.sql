-- 1. Даём право создавать схемы во всей базе данных (если ещё не давали)
GRANT CREATE SCHEMA ON DATABASE PAGILA_SAKILA_DW TO ROLE AIRFLOW_DEV_ROLE;

-- 2. Явно даём право на владение схемой PAGILA_RAW (самая важная привилегия)
GRANT OWNERSHIP ON SCHEMA PAGILA_SAKILA_DW.PAGILA_RAW TO ROLE AIRFLOW_DEV_ROLE REVOKE CURRENT GRANTS;