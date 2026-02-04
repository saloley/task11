
  create or replace   view PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_city
  
  
  
  
  as (
    

with source as (
    select * from PAGILA_SAKILA_DW.PAGILA_RAW.city
),

renamed as (
    select
        -- Primary key
        city_id,
        
        -- Foreign keys
        country_id,
        
        -- City attributes
        city as city_name,
        
        -- Metadata
        last_update as source_last_update,
        current_timestamp() as dbt_loaded_at
        
    from source
)

select * from renamed
  );

