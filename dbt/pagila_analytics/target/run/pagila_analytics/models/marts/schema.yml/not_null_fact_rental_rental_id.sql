
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select rental_id
from PAGILA_SAKILA_DW.DBT_ANALYTICS_marts.fact_rental
where rental_id is null



  
  
      
    ) dbt_internal_test