
    
    

select
    rental_id as unique_field,
    count(*) as n_records

from PAGILA_SAKILA_DW.PAGILA_RAW.rental
where rental_id is not null
group by rental_id
having count(*) > 1


