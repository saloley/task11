{{
    config(
        materialized='table',
        tags=['marts', 'fact', 'rental']
    )
}}

with rental_facts as (
    select * from {{ ref('int_rental_facts') }}
),

fact_rental as (
    select
        -- Fact key
        rental_id,
        
        -- Dimension keys
        cast(rental_date as date) as rental_date_key,
        cast(return_date as date) as return_date_key,
        customer_id,
        staff_id,
        inventory_id,
        film_id,
        store_id,
        
        -- Timestamps
        rental_date,
        return_date,
        
        -- Measures
        rental_duration_hours,
        rental_duration_days,
        rental_rate,
        expected_rental_days,
        late_fee_amount,
        payment_amount,
        payment_date,
        
        -- Degenerate dimensions
        film_title,
        film_rating,
        rental_status,
        is_currently_rented,
        
        -- Total revenue (rental + late fees)
        rental_rate + late_fee_amount as total_rental_revenue,
        
        -- Metadata
        dbt_loaded_at,
        current_timestamp() as dbt_updated_at
        
    from rental_facts
)

select * from fact_rental
