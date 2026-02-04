
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select year
from PAGILA_SAKILA_DW.DBT_ANALYTICS_marts.dim_date
where year is null



  
  
      
    ) dbt_internal_test