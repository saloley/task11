
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select manager_staff_id
from PAGILA_SAKILA_DW.PAGILA_RAW.store
where manager_staff_id is null



  
  
      
    ) dbt_internal_test