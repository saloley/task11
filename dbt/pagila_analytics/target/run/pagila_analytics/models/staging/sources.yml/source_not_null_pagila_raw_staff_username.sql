
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select username
from PAGILA_SAKILA_DW.PAGILA_RAW.staff
where username is null



  
  
      
    ) dbt_internal_test