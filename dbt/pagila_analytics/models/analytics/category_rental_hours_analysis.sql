{{
    config(
        materialized='view',
        tags=['analytics', 'category', 'rental_duration']
    )
}}

-- Category Rental Hours Analysis
-- Analyzes average rental duration by film category

with rental_facts as (
    select * from {{ ref('int_rental_facts') }}
),

film_categories as (
    select * from {{ ref('stg_film_category') }}
),

categories as (
    select * from {{ ref('stg_category') }}
),

category_rental_hours as (
    select
        c.category_name,
        
        -- Rental counts
        count(distinct rf.rental_id) as total_rentals,
        count(distinct rf.film_id) as unique_films,
        
        -- Rental duration metrics (hours)
        round(avg(rf.rental_duration_hours), 2) as avg_rental_hours,
        round(min(rf.rental_duration_hours), 2) as min_rental_hours,
        round(max(rf.rental_duration_hours), 2) as max_rental_hours,
        round(stddev(rf.rental_duration_hours), 2) as stddev_rental_hours,
        
        -- Rental duration metrics (days)
        round(avg(rf.rental_duration_days), 2) as avg_rental_days,
        round(min(rf.rental_duration_days), 2) as min_rental_days,
        round(max(rf.rental_duration_days), 2) as max_rental_days,
        
        -- Late return analysis
        count(distinct case when rf.rental_status = 'Late' then rf.rental_id end) as late_returns,
        round(
            count(distinct case when rf.rental_status = 'Late' then rf.rental_id end)::decimal / 
            nullif(count(distinct rf.rental_id), 0) * 100, 
            2
        ) as late_return_percentage,
        
        -- Revenue impact
        round(sum(rf.late_fee_amount), 2) as total_late_fees,
        round(avg(rf.late_fee_amount), 2) as avg_late_fee
        
    from categories c
    inner join film_categories fc on c.category_id = fc.category_id
    inner join rental_facts rf on fc.film_id = rf.film_id
    where rf.rental_duration_hours is not null
    group by c.category_name
    order by avg_rental_hours desc
)

select * from category_rental_hours
