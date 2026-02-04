
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select payment_date_key
from PAGILA_SAKILA_DW.DBT_ANALYTICS_marts.fact_revenue
where payment_date_key is null



  
  
      
    ) dbt_internal_test