
    
    

select
    film_id as unique_field,
    count(*) as n_records

from PAGILA_SAKILA_DW.PAGILA_RAW.film
where film_id is not null
group by film_id
having count(*) > 1


