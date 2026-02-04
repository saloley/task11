
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select city_id
from PAGILA_SAKILA_DW.PAGILA_RAW.address
where city_id is null



  
  
      
    ) dbt_internal_test