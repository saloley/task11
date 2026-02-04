
    
    

select
    customer_id as unique_field,
    count(*) as n_records

from PAGILA_SAKILA_DW.DBT_ANALYTICS_marts.dim_customer
where customer_id is not null
group by customer_id
having count(*) > 1


