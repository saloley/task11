
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select payment_date
from PAGILA_SAKILA_DW.PAGILA_RAW.payment
where payment_date is null



  
  
      
    ) dbt_internal_test