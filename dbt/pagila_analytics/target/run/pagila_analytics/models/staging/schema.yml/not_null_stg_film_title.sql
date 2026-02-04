
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select title
from PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_film
where title is null



  
  
      
    ) dbt_internal_test