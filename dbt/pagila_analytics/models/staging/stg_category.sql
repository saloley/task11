{{
    config(
        materialized='view',
        tags=['staging', 'category']
    )
}}

with source as (
    select * from {{ source('pagila_raw', 'category') }}
),

renamed as (
    select
        -- Primary key
        category_id,
        
        -- Category attributes
        name as category_name,
        
        -- Metadata
        last_update as source_last_update,
        current_timestamp() as dbt_loaded_at
        
    from source
)

select * from renamed
