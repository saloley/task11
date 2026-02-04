
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    (film_id || '-' || actor_id) as unique_field,
    count(*) as n_records

from PAGILA_SAKILA_DW.PAGILA_RAW.film_actor
where (film_id || '-' || actor_id) is not null
group by (film_id || '-' || actor_id)
having count(*) > 1



  
  
      
    ) dbt_internal_test