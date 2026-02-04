
  create or replace   view PAGILA_SAKILA_DW.DBT_ANALYTICS_analytics.films_not_in_inventory
  
  
  
  
  as (
    

-- Films Not In Inventory Analysis
-- Identifies films that exist in catalog but have no inventory copies

with films as (
    select * from PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_film
),

inventory as (
    select * from PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_inventory
),

film_categories as (
    select * from PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_film_category
),

categories as (
    select * from PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_category
),

films_without_inventory as (
    select
        f.film_id,
        f.title,
        f.description,
        f.release_year,
        f.rating,
        f.rental_rate,
        f.duration_minutes,
        f.replacement_cost,
        c.category_name,
        
        -- Potential revenue loss (assuming average rental rate)
        f.rental_rate as potential_revenue_per_rental
        
    from films f
    left join inventory i on f.film_id = i.film_id
    left join film_categories fc on f.film_id = fc.film_id
    left join categories c on fc.category_id = c.category_id
    where i.inventory_id is null
    order by f.title
)

select * from films_without_inventory
  );

