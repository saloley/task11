

with films as (
    select * from PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_film
),

film_categories as (
    select * from PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_film_category
),

categories as (
    select * from PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_category
),

film_with_category as (
    select
        f.film_id,
        f.title,
        f.description,
        f.release_year,
        f.language_id,
        f.rental_duration,
        f.rental_rate,
        f.duration_minutes,
        f.replacement_cost,
        f.rating,
        f.special_features,
        
        -- Category information
        c.category_id,
        c.category_name,
        
        -- Metadata
        f.source_last_update,
        f.dbt_loaded_at,
        current_timestamp() as dbt_updated_at
        
    from films f
    left join film_categories fc on f.film_id = fc.film_id
    left join categories c on fc.category_id = c.category_id
)

select * from film_with_category