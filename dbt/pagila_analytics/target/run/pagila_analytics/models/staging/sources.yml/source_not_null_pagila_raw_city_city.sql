
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select city
from PAGILA_SAKILA_DW.PAGILA_RAW.city
where city is null



  
  
      
    ) dbt_internal_test