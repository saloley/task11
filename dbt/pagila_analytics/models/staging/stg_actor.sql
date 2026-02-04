{{
    config(
        materialized='view',
        tags=['staging', 'actor']
    )
}}

with source as (
    select * from {{ source('pagila_raw', 'actor') }}
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
