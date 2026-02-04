{{
    config(
        materialized='table',
        tags=['marts', 'fact', 'revenue']
    )
}}

with payments as (
    select * from {{ ref('stg_payment') }}
),

rentals as (
    select * from {{ ref('stg_rental') }}
),

inventory as (
    select * from {{ ref('stg_inventory') }}
),

films as (
    select * from {{ ref('stg_film') }}
),

film_categories as (
    select * from {{ ref('stg_film_category') }}
),

categories as (
    select * from {{ ref('stg_category') }}
),

fact_revenue as (
    select
        -- Fact key
        p.payment_id,
        
        -- Dimension keys
        cast(p.payment_date as date) as payment_date_key,
        p.customer_id,
        p.staff_id,
        r.rental_id,
        i.inventory_id,
        i.film_id,
        i.store_id,
        c.category_id,
        
        -- Timestamps
        p.payment_date,
        r.rental_date,
        r.return_date,
        
        -- Revenue measures
        p.payment_amount as payment_amount,
        f.rental_rate as standard_rental_rate,
        
        -- Revenue components
        case 
            when p.payment_amount > f.rental_rate 
            then p.payment_amount - f.rental_rate
            else 0
        end as late_fee_revenue,
        
        f.rental_rate as rental_revenue,
        
        -- Degenerate dimensions
        f.title as film_title,
        f.rating as film_rating,
        c.category_name,
        
        -- Metadata
        p.dbt_loaded_at,
        current_timestamp() as dbt_updated_at
        
    from payments p
    inner join rentals r on p.rental_id = r.rental_id
    inner join inventory i on r.inventory_id = i.inventory_id
    inner join films f on i.film_id = f.film_id
    left join film_categories fc on f.film_id = fc.film_id
    left join categories c on fc.category_id = c.category_id
)

select * from fact_revenue
