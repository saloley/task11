
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select address
from PAGILA_SAKILA_DW.PAGILA_RAW.address
where address is null



  
  
      
    ) dbt_internal_test