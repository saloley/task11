
  create or replace   view PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_film_category
  
  
  
  
  as (
    

with source as (
    select * from PAGILA_SAKILA_DW.PAGILA_RAW.film_category
),

renamed as (
    select
        -- Composite key
        film_id,
        category_id,
        
        -- Metadata
        last_update as source_last_update,
        current_timestamp() as dbt_loaded_at
        
    from source
)

select * from renamed
  );

