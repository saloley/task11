from datetime import datetime
import logging
from airflow.sdk import dag, task
from airflow.operators.bash import BashOperator


DBT_PROJECT_DIR = '/opt/airflow/dbt/pagila_analytics'
DBT_PROFILES_DIR = '/opt/airflow/dbt/pagila_analytics'

@dag(
    dag_id='dbt_pagila_transformation',
    start_date=datetime(2026, 1, 1),
    schedule='0 2 * * *',  # Daily at 2 AM
    catchup=False,
    tags=['dbt', 'transformation', 'snowflake'],
    description='Transform Pagila data using dbt',
)
def dbt_transformation_dag():

    @task
    def log_start():
        logger = logging.getLogger(__name__)
        logger.info("Starting dbt transformation pipeline")
    
    # Install dbt dependencies
    dbt_deps = BashOperator(
        task_id='dbt_deps',
        bash_command=f'cd {DBT_PROJECT_DIR} && dbt deps --profiles-dir {DBT_PROFILES_DIR}',
    )
    
    # Check source freshness
    dbt_source_freshness = BashOperator(
        task_id='dbt_source_freshness',
        bash_command=f'cd {DBT_PROJECT_DIR} && dbt source freshness --profiles-dir {DBT_PROFILES_DIR}',
    )
    
    # Staging layer
    dbt_run_staging = BashOperator(
        task_id='dbt_run_staging',
        bash_command=f'cd {DBT_PROJECT_DIR} && dbt run --select staging --profiles-dir {DBT_PROFILES_DIR}',
    )
    
    dbt_test_staging = BashOperator(
        task_id='dbt_test_staging',
        bash_command=f'cd {DBT_PROJECT_DIR} && dbt test --select staging --profiles-dir {DBT_PROFILES_DIR}',
    )
    
    # Intermediate layer
    dbt_run_intermediate = BashOperator(
        task_id='dbt_run_intermediate',
        bash_command=f'cd {DBT_PROJECT_DIR} && dbt run --select intermediate --profiles-dir {DBT_PROFILES_DIR}',
    )
    
    # Marts layer
    dbt_run_marts = BashOperator(
        task_id='dbt_run_marts',
        bash_command=f'cd {DBT_PROJECT_DIR} && dbt run --select marts --profiles-dir {DBT_PROFILES_DIR}',
    )
    
    dbt_test_marts = BashOperator(
        task_id='dbt_test_marts',
        bash_command=f'cd {DBT_PROJECT_DIR} && dbt test --select marts --profiles-dir {DBT_PROFILES_DIR}',
    )
    
    # Analytics layer
    dbt_run_analytics = BashOperator(
        task_id='dbt_run_analytics',
        bash_command=f'cd {DBT_PROJECT_DIR} && dbt run --select analytics --profiles-dir {DBT_PROFILES_DIR}',
    )
    
    # Generate documentation
    dbt_docs = BashOperator(
        task_id='dbt_docs_generate',
        bash_command=f'cd {DBT_PROJECT_DIR} && dbt docs generate --profiles-dir {DBT_PROFILES_DIR}',
    )
    
    @task
    def log_completion():
        logger = logging.getLogger(__name__)
        logger.info("dbt transformation completed successfully - 28 models created")
    

    start = log_start()
    complete = log_completion()
    
    start >> dbt_deps >> dbt_source_freshness >> dbt_run_staging >> dbt_test_staging
    dbt_test_staging >> dbt_run_intermediate >> dbt_run_marts >> dbt_test_marts
    dbt_test_marts >> dbt_run_analytics >> dbt_docs >> complete

dag_instance = dbt_transformation_dag()