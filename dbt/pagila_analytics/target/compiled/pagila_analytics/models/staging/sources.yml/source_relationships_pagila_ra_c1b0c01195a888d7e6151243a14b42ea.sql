
    
    

with child as (
    select category_id as from_field
    from PAGILA_SAKILA_DW.PAGILA_RAW.film_category
    where category_id is not null
),

parent as (
    select category_id as to_field
    from PAGILA_SAKILA_DW.PAGILA_RAW.category
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


