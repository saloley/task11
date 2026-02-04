
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select language_id
from PAGILA_SAKILA_DW.PAGILA_RAW.language
where language_id is null



  
  
      
    ) dbt_internal_test