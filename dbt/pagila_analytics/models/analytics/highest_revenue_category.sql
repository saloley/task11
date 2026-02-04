{{
    config(
        materialized='view',
        tags=['analytics', 'revenue']
    )
}}

-- Highest Revenue Category Analysis
-- Shows which film categories generate the most revenue

with fact_revenue as (
    select * from {{ ref('fact_revenue') }}
),

category_revenue as (
    select
        category_name,
        count(distinct payment_id) as total_payments,
        count(distinct rental_id) as total_rentals,
        count(distinct film_id) as unique_films,
        
        -- Revenue metrics
        round(sum(payment_amount), 2) as total_revenue,
        round(sum(rental_revenue), 2) as rental_revenue,
        round(sum(late_fee_revenue), 2) as late_fee_revenue,
        
        -- Averages
        round(avg(payment_amount), 2) as avg_payment_amount,
        round(sum(payment_amount) / count(distinct film_id), 2) as revenue_per_film,
        
        -- Revenue percentage
        round(
            sum(payment_amount) / 
            sum(sum(payment_amount)) over () * 100, 
            2
        ) as revenue_percentage
        
    from fact_revenue
    where category_name is not null
    group by category_name
    order by total_revenue desc
)

select * from category_revenue
