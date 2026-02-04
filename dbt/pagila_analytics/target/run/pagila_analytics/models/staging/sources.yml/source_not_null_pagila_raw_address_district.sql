
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select district
from PAGILA_SAKILA_DW.PAGILA_RAW.address
where district is null



  
  
      
    ) dbt_internal_test