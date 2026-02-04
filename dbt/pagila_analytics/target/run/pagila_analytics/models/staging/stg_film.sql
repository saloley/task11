
  create or replace   view PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_film
  
  
  
  
  as (
    

with source as (
    select * from PAGILA_SAKILA_DW.PAGILA_RAW.film
),

renamed as (
    select
        -- Primary key
        film_id,
        
        -- Film attributes
        title,
        description,
        release_year,
        language_id,
        
        -- Rental information
        rental_duration,
        rental_rate::decimal(4,2) as rental_rate,
        replacement_cost::decimal(5,2) as replacement_cost,
        
        -- Film characteristics
        length as duration_minutes,
        rating,
        special_features,
        
        -- Metadata
        last_update as source_last_update,
        current_timestamp() as dbt_loaded_at
        
    from source
)

select * from renamed
  );

