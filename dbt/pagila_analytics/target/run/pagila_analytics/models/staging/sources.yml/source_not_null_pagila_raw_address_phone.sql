
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select phone
from PAGILA_SAKILA_DW.PAGILA_RAW.address
where phone is null



  
  
      
    ) dbt_internal_test