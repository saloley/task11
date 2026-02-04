
    
    

select
    language_id as unique_field,
    count(*) as n_records

from PAGILA_SAKILA_DW.PAGILA_RAW.language
where language_id is not null
group by language_id
having count(*) > 1


