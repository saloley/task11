{{
    config(
        materialized='view',
        tags=['analytics', 'customer', 'geography']
    )
}}

-- Customer Distribution By City Analysis
-- Shows geographic distribution of customers

with customer_enriched as (
    select * from {{ ref('int_customer_enriched') }}
),

rentals as (
    select * from {{ ref('stg_rental') }}
),

payments as (
    select * from {{ ref('stg_payment') }}
),

city_distribution as (
    select
        ce.city_name,
        ce.country_name,
        ce.full_location,
        
        -- Customer counts
        count(distinct ce.customer_id) as total_customers,
        count(distinct case when ce.is_active then ce.customer_id end) as active_customers,
        
        -- Activity metrics
        count(distinct r.rental_id) as total_rentals,
        round(sum(p.payment_amount), 2) as total_revenue,
        
        -- Averages
        round(
            count(distinct r.rental_id)::decimal / 
            nullif(count(distinct ce.customer_id), 0), 
            2
        ) as avg_rentals_per_customer,
        
        round(
            sum(p.payment_amount) / 
            nullif(count(distinct ce.customer_id), 0), 
            2
        ) as avg_revenue_per_customer,
        
        -- Customer percentage
        round(
            count(distinct ce.customer_id)::decimal / 
            sum(count(distinct ce.customer_id)) over () * 100, 
            2
        ) as customer_percentage
        
    from customer_enriched ce
    left join rentals r on ce.customer_id = r.customer_id
    left join payments p on r.rental_id = p.rental_id
    group by 
        ce.city_name,
        ce.country_name,
        ce.full_location
    order by total_customers desc
)

select * from city_distribution
