from datetime import datetime
import logging
import os
from airflow.sdk import dag, task
from airflow.providers.airbyte.operators.airbyte import AirbyteTriggerSyncOperator

# Configuration
AIRBYTE_CONN_ID = 'airbyte_default'
PAGILA_CONNECTION_ID = os.getenv('AIRBYTE_CONNECTION_PAGILA_ID', '')
SAKILA_CONNECTION_ID = os.getenv('AIRBYTE_CONNECTION_SAKILA_ID', '')

@dag(
    dag_id='airbyte_pagila_sakila_replication',
    start_date=datetime(2026, 1, 1),
    schedule='0 1 * * *',  
    catchup=False,
    tags=['airbyte', 'replication', 'pagila', 'sakila'],
    description='Replicate Pagila and Sakila data to Snowflake via Airbyte',
)
def airbyte_replication_dag():

    @task
    def log_start():
        logger = logging.getLogger(__name__)
        logger.info("Starting Airbyte data replication")
    
    # Sync Pagila
    sync_pagila = AirbyteTriggerSyncOperator(
        task_id='sync_pagila_to_snowflake',
        airbyte_conn_id=AIRBYTE_CONN_ID,
        connection_id=PAGILA_CONNECTION_ID,
        asynchronous=False,
        wait_seconds=10,
        timeout=3600,
    )
    
    # Check if Sakila is configured
    @task.branch
    def check_sakila_configured():
        if SAKILA_CONNECTION_ID and SAKILA_CONNECTION_ID.strip():
            return 'sync_sakila_to_snowflake'
        else:
            return 'sakila_skipped'
    
    # Sync Sakila
    sync_sakila = AirbyteTriggerSyncOperator(
        task_id='sync_sakila_to_snowflake',
        airbyte_conn_id=AIRBYTE_CONN_ID,
        connection_id=SAKILA_CONNECTION_ID,
        asynchronous=False,
        wait_seconds=10,
        timeout=3600,
    )
    
    @task
    def sakila_skipped():
        logger = logging.getLogger(__name__)
        logger.info("Sakila sync skipped - connection not configured")
    
    @task(trigger_rule='none_failed')
    def log_completion():
        logger = logging.getLogger(__name__)
        logger.info("Airbyte replication completed successfully")
    

    start = log_start()
    sakila_check = check_sakila_configured()
    sakila_skip = sakila_skipped()
    complete = log_completion()
    
    start >> sync_pagila >> sakila_check
    sakila_check >> [sync_sakila, sakila_skip]
    [sync_pagila, sync_sakila, sakila_skip] >> complete

dag_instance = airbyte_replication_dag()