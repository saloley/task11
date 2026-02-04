{{
    config(
        materialized='view',
        tags=['staging', 'country']
    )
}}

with source as (
    select * from {{ source('pagila_raw', 'country') }}
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
