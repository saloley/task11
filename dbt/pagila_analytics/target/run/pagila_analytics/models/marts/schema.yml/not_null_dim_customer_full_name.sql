
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select full_name
from PAGILA_SAKILA_DW.DBT_ANALYTICS_marts.dim_customer
where full_name is null



  
  
      
    ) dbt_internal_test