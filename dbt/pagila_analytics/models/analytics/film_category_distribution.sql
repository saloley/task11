{{
    config(
        materialized='view',
        tags=['analytics', 'category']
    )
}}

-- Film Category Distribution Analysis
-- Shows the distribution of films across different categories

with film_category as (
    select * from {{ ref('stg_film_category') }}
),

categories as (
    select * from {{ ref('stg_category') }}
),

films as (
    select * from {{ ref('stg_film') }}
),

category_distribution as (
    select
        c.category_name,
        count(distinct fc.film_id) as film_count,
        round(avg(f.rental_rate), 2) as avg_rental_rate,
        round(avg(f.duration_minutes), 0) as avg_duration_minutes,
        round(avg(f.replacement_cost), 2) as avg_replacement_cost,
        
        -- Distribution percentage
        round(
            count(distinct fc.film_id)::decimal / 
            sum(count(distinct fc.film_id)) over () * 100, 
            2
        ) as percentage_of_total
        
    from categories c
    left join film_category fc on c.category_id = fc.category_id
    left join films f on fc.film_id = f.film_id
    group by c.category_name
    order by film_count desc
)

select * from category_distribution
