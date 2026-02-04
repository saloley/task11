
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select payment_amount
from PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_payment
where payment_amount is null



  
  
      
    ) dbt_internal_test