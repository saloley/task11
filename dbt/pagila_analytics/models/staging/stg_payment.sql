{{
    config(
        materialized='view',
        tags=['staging', 'payment']
    )
}}

with source as (
    select * from {{ source('pagila_raw', 'payment') }}
),

renamed as (
    select
        -- Primary key
        payment_id,
        
        -- Foreign keys
        customer_id,
        staff_id,
        rental_id,
        
        -- Payment details
        amount::decimal(5,2) as payment_amount,
        payment_date,
        
        -- Metadata
        current_timestamp() as dbt_loaded_at
        
    from source
)

select * from renamed
