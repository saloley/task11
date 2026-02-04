
    
    

select
    rental_id as unique_field,
    count(*) as n_records

from PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_rental
where rental_id is not null
group by rental_id
having count(*) > 1


