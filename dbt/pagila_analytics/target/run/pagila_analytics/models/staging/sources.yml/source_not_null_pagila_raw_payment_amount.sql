
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select amount
from PAGILA_SAKILA_DW.PAGILA_RAW.payment
where amount is null



  
  
      
    ) dbt_internal_test