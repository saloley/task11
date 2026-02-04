{{
    config(
        materialized='view',
        tags=['staging', 'address']
    )
}}

with source as (
    select * from {{ source('pagila_raw', 'address') }}
),

renamed as (
    select
        -- Primary key
        address_id,
        
        -- Foreign keys
        city_id,
        
        -- Address attributes
        address,
        address2,
        district,
        postal_code,
        phone,
        
        -- Metadata
        last_update as source_last_update,
        current_timestamp() as dbt_loaded_at
        
    from source
)

select * from renamed
