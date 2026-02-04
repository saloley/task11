
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select rental_date
from PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_rental
where rental_date is null



  
  
      
    ) dbt_internal_test