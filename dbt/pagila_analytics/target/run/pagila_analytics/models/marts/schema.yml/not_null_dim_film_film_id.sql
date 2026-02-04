
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select film_id
from PAGILA_SAKILA_DW.DBT_ANALYTICS_marts.dim_film
where film_id is null



  
  
      
    ) dbt_internal_test