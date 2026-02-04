
  create or replace   view PAGILA_SAKILA_DW.DBT_ANALYTICS_analytics.top_children_actors
  
  
  
  
  as (
    

-- Top Children Film Actors Analysis
-- Identifies the most popular actors in children's films (G and PG rated)

with rentals as (
    select * from PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_rental
),

inventory as (
    select * from PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_inventory
),

films as (
    select * from PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_film
),

film_actor as (
    select * from PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_film_actor
),

actors as (
    select * from PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_actor
),

children_film_actors as (
    select
        a.actor_id,
        a.full_name as actor_name,
        a.first_name,
        a.last_name,
        
        -- Rental metrics for children's films
        count(distinct r.rental_id) as total_rentals_children_films,
        count(distinct f.film_id) as children_films_count,
        
        -- Film ratings breakdown
        count(distinct case when f.rating = 'G' then f.film_id end) as g_rated_films,
        count(distinct case when f.rating = 'PG' then f.film_id end) as pg_rated_films,
        
        -- Average rental metrics
        round(avg(f.rental_rate), 2) as avg_rental_rate,
        round(avg(f.duration_minutes), 0) as avg_film_duration
        
    from actors a
    inner join film_actor fa on a.actor_id = fa.actor_id
    inner join films f on fa.film_id = f.film_id and f.rating in ('G', 'PG')
    inner join inventory i on f.film_id = i.film_id
    inner join rentals r on i.inventory_id = r.inventory_id
    group by 
        a.actor_id,
        a.full_name,
        a.first_name,
        a.last_name
    order by total_rentals_children_films desc
)

select * from children_film_actors
  );

