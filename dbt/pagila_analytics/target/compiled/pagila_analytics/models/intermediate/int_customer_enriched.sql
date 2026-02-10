

with customers as (
    select * from PAGILA_SAKILA_DW.STAGING.stg_customer
),

addresses as (
    select * from PAGILA_SAKILA_DW.STAGING.stg_address
),

cities as (
    select * from PAGILA_SAKILA_DW.STAGING.stg_city
),

countries as (
    select * from PAGILA_SAKILA_DW.STAGING.stg_country
),

customer_enriched as (
    select
        c.customer_id,
        c.store_id,
        
        -- Customer details
        c.first_name,
        c.last_name,
        c.full_name,
        c.email,
        c.is_active,
        c.create_date,
        
        -- Address details
        a.address_id,
        a.address,
        a.address2,
        a.district,
        a.postal_code,
        a.phone,
        
        -- Location details
        ci.city_id,
        ci.city_name,
        co.country_id,
        co.country_name,
        
        -- Full location string
        ci.city_name || ', ' || co.country_name as full_location,
        
        -- Metadata
        c.dbt_loaded_at
        
    from customers c
    inner join addresses a on c.address_id = a.address_id
    inner join cities ci on a.city_id = ci.city_id
    inner join countries co on ci.country_id = co.country_id
)

select * from customer_enriched