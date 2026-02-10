
  create or replace   view PAGILA_SAKILA_DW.STAGING.stg_actor
  
  
  
  
  as (
    

with source as (
    select * from PAGILA_SAKILA_DW.PAGILA_RAW.actor
),

renamed as (
    select
        -- Primary key
        actor_id,
        
        -- Actor attributes
        first_name,
        last_name,
        first_name || ' ' || last_name as full_name,
        
        -- Metadata
        last_update as source_last_update,
        current_timestamp() as dbt_loaded_at
        
    from source
)

select * from renamed
  );

