
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select country
from PAGILA_SAKILA_DW.PAGILA_RAW.country
where country is null



  
  
      
    ) dbt_internal_test