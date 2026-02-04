
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    rental_id as unique_field,
    count(*) as n_records

from PAGILA_SAKILA_DW.DBT_ANALYTICS_marts.fact_rental
where rental_id is not null
group by rental_id
having count(*) > 1



  
  
      
    ) dbt_internal_test