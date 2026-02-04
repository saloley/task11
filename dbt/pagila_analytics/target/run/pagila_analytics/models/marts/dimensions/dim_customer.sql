
  
    

create or replace transient table PAGILA_SAKILA_DW.DBT_ANALYTICS_marts.dim_customer
    
    
    
    as (

with customer_enriched as (
    select * from PAGILA_SAKILA_DW.DBT_ANALYTICS_intermediate.int_customer_enriched
),

dim_customer as (
    select
        customer_id,
        store_id,
        
        -- Customer information
        first_name,
        last_name,
        full_name,
        email,
        is_active,
        create_date,
        
        -- Address information
        address_id,
        address,
        address2,
        district,
        postal_code,
        phone,
        
        -- Location information
        city_id,
        city_name,
        country_id,
        country_name,
        full_location,
        
        -- Metadata
        dbt_loaded_at,
        current_timestamp() as dbt_updated_at
        
    from customer_enriched
)

select * from dim_customer
    )
;


  