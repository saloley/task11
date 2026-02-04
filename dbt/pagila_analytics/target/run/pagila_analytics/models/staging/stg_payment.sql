
  create or replace   view PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_payment
  
  
  
  
  as (
    

with source as (
    select * from PAGILA_SAKILA_DW.PAGILA_RAW.payment
),

renamed as (
    select
        -- Primary key
        payment_id,
        
        -- Foreign keys
        customer_id,
        staff_id,
        rental_id,
        
        -- Payment details
        amount::decimal(5,2) as payment_amount,
        payment_date,
        
        -- Metadata
        current_timestamp() as dbt_loaded_at
        
    from source
)

select * from renamed
  );

