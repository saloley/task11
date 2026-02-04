
  create or replace   view PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_category
  
  
  
  
  as (
    

with source as (
    select * from PAGILA_SAKILA_DW.PAGILA_RAW.category
),

renamed as (
    select
        -- Primary key
        category_id,
        
        -- Category attributes
        name as category_name,
        
        -- Metadata
        last_update as source_last_update,
        current_timestamp() as dbt_loaded_at
        
    from source
)

select * from renamed
  );

