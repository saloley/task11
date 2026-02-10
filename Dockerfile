
FROM apache/airflow:3.1.6


RUN pip install --no-cache-dir --user \
    apache-airflow-providers-airbyte==5.3.2 \
    apache-airflow-providers-snowflake \
    dbt-snowflake