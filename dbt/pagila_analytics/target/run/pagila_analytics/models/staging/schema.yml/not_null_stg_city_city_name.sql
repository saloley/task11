
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select city_name
from PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_city
where city_name is null



  
  
      
    ) dbt_internal_test