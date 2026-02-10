
  create or replace   view PAGILA_SAKILA_DW.STAGING.stg_country
  
  
  
  
  as (
    

with source as (
    select * from PAGILA_SAKILA_DW.PAGILA_RAW.country
),

renamed as (
    select
        -- Primary key
        country_id,
        
        -- Country attributes
        country as country_name,
        
        -- Metadata
        last_update as source_last_update,
        current_timestamp() as dbt_loaded_at
        
    from source
)

select * from renamed
  );

