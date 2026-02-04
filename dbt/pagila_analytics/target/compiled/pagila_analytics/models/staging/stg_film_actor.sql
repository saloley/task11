

with source as (
    select * from PAGILA_SAKILA_DW.PAGILA_RAW.film_actor
),

renamed as (
    select
        -- Composite key
        film_id,
        actor_id,
        
        -- Metadata
        last_update as source_last_update,
        current_timestamp() as dbt_loaded_at
        
    from source
)

select * from renamed