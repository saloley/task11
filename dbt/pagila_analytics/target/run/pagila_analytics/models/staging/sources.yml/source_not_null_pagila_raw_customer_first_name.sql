
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select first_name
from PAGILA_SAKILA_DW.PAGILA_RAW.customer
where first_name is null



  
  
      
    ) dbt_internal_test