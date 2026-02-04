
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select category_name
from PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_category
where category_name is null



  
  
      
    ) dbt_internal_test