
  create or replace   view PAGILA_SAKILA_DW.STAGING.stg_rental
  
  
  
  
  as (
    

with source as (
    select * from PAGILA_SAKILA_DW.PAGILA_RAW.rental
),

renamed as (
    select
        -- Primary key
        rental_id,
        
        -- Foreign keys
        inventory_id,
        customer_id,
        staff_id,
        
        -- Rental details
        rental_date,
        return_date,
        
        -- Calculated fields
        case 
            when return_date is not null 
            then datediff('hour', rental_date, return_date)
            else null
        end as rental_duration_hours,
        
        case 
            when return_date is null 
            then true 
            else false 
        end as is_currently_rented,
        
        -- Metadata
        last_update as source_last_update,
        current_timestamp() as dbt_loaded_at
        
    from source
)

select * from renamed
  );

