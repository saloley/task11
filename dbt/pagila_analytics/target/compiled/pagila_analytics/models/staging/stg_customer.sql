

with source as (
    select * from PAGILA_SAKILA_DW.PAGILA_RAW.customer
),

renamed as (
    select
        -- Primary key
        customer_id,
        
        -- Foreign keys
        store_id,
        address_id,
        
        -- Customer attributes
        first_name,
        last_name,
        first_name || ' ' || last_name as full_name,
        email,
        
        -- Status
        case 
            when active = 1 then true 
            when active = 0 then false
            else null
        end as is_active,
        
        -- Dates
        create_date,
        
        -- Metadata
        last_update as source_last_update,
        current_timestamp() as dbt_loaded_at
        
    from source
)

select * from renamed