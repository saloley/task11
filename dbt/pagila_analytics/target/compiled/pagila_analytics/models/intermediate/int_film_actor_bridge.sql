

with film_actor as (
    select * from PAGILA_SAKILA_DW.STAGING.stg_film_actor
),

films as (
    select * from PAGILA_SAKILA_DW.STAGING.stg_film
),

actors as (
    select * from PAGILA_SAKILA_DW.STAGING.stg_actor
),

enriched as (
    select
        fa.film_id,
        fa.actor_id,
        
        -- Film details
        f.title,
        f.rating,
        f.rental_rate,
        
        -- Actor details
        a.full_name as actor_name,
        a.first_name,
        a.last_name,
        
        -- Metadata
        fa.dbt_loaded_at
        
    from film_actor fa
    inner join films f on fa.film_id = f.film_id
    inner join actors a on fa.actor_id = a.actor_id
)

select * from enriched