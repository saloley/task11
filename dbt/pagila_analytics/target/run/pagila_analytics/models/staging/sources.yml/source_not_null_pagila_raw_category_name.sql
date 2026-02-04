
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select name
from PAGILA_SAKILA_DW.PAGILA_RAW.category
where name is null



  
  
      
    ) dbt_internal_test