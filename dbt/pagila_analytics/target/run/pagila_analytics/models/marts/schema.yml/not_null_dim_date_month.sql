
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select month
from PAGILA_SAKILA_DW.DBT_ANALYTICS_marts.dim_date
where month is null



  
  
      
    ) dbt_internal_test