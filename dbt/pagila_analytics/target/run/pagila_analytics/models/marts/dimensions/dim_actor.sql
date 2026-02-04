
  
    

create or replace transient table PAGILA_SAKILA_DW.DBT_ANALYTICS_marts.dim_actor
    
    
    
    as (

with actors as (
    select * from PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_actor
),

film_actor as (
    select * from PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_film_actor
),

actor_stats as (
    select
        actor_id,
        count(distinct film_id) as total_films
    from film_actor
    group by actor_id
),

dim_actor as (
    select
        a.actor_id,
        a.first_name,
        a.last_name,
        a.full_name,
        
        -- Actor statistics
        coalesce(ast.total_films, 0) as total_films,
        
        -- Metadata
        a.source_last_update,
        a.dbt_loaded_at,
        current_timestamp() as dbt_updated_at
        
    from actors a
    left join actor_stats ast on a.actor_id = ast.actor_id
)

select * from dim_actor
    )
;


  