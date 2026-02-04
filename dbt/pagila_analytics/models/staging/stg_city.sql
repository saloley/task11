{{
    config(
        materialized='view',
        tags=['staging', 'city']
    )
}}

with source as (
    select * from {{ source('pagila_raw', 'city') }}
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
