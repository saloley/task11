{{
    config(
        materialized='view',
        tags=['intermediate', 'facts']
    )
}}

with rentals as (
    select * from {{ ref('stg_rental') }}
),

inventory as (
    select * from {{ ref('stg_inventory') }}
),

films as (
    select * from {{ ref('stg_film') }}
),

payments as (
    select * from {{ ref('stg_payment') }}
),

rental_facts as (
    select
        r.rental_id,
        r.rental_date,
        r.return_date,
        r.customer_id,
        r.staff_id,
        
        -- Film information
        i.inventory_id,
        i.film_id,
        i.store_id,
        f.title as film_title,
        f.rating as film_rating,
        f.rental_rate,
        f.rental_duration as expected_rental_days,
        
        -- Rental duration
        r.rental_duration_hours,
        case 
            when r.rental_duration_hours is not null 
            then round(r.rental_duration_hours / 24.0, 2)
            else null
        end as rental_duration_days,
        
        -- Rental status
        r.is_currently_rented,
        case
            when r.return_date is null then 'Active'
            when r.rental_duration_hours <= (f.rental_duration * 24) then 'On Time'
            else 'Late'
        end as rental_status,
        
        -- Late fees calculation (if applicable)
        case
            when r.return_date is not null 
                and r.rental_duration_hours > (f.rental_duration * 24)
            then round(
                ((r.rental_duration_hours - (f.rental_duration * 24)) / 24.0) * f.rental_rate, 
                2
            )
            else 0
        end as late_fee_amount,
        
        -- Payment information
        coalesce(p.payment_amount, 0) as payment_amount,
        p.payment_date,
        
        -- Metadata
        r.dbt_loaded_at
        
    from rentals r
    inner join inventory i on r.inventory_id = i.inventory_id
    inner join films f on i.film_id = f.film_id
    left join payments p on r.rental_id = p.rental_id
)

select * from rental_facts
