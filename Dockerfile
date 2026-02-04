
FROM apache/airflow:3.1.6


RUN pip install --no-cache-dir --user \
    apache-airflow-providers-airbyte \
    dbt-snowflake