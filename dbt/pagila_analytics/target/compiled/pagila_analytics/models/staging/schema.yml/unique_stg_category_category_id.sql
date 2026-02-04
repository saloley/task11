
    
    

select
    category_id as unique_field,
    count(*) as n_records

from PAGILA_SAKILA_DW.DBT_ANALYTICS_staging.stg_category
where category_id is not null
group by category_id
having count(*) > 1


