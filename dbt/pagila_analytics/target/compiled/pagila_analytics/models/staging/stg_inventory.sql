

with source as (
    select * from PAGILA_SAKILA_DW.PAGILA_RAW.inventory
),

renamed as (
    select
        -- Primary key
        inventory_id,
        
        -- Foreign keys
        film_id,
        store_id,
        
        -- Metadata
        last_update as source_last_update,
        current_timestamp() as dbt_loaded_at
        
    from source
)

select * from renamed