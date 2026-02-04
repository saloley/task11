
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    (film_id || '-' || category_id) as unique_field,
    count(*) as n_records

from PAGILA_SAKILA_DW.PAGILA_RAW.film_category
where (film_id || '-' || category_id) is not null
group by (film_id || '-' || category_id)
having count(*) > 1



  
  
      
    ) dbt_internal_test