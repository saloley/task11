{{
    config(
        materialized='table',
        tags=['marts', 'dimension', 'date']
    )
}}

with date_spine as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2005-01-01' as date)",
        end_date="cast('2030-12-31' as date)"
    ) }}
),

dim_date as (
    select
        cast(date_day as date) as date_key,
        
        -- Date parts
        extract(year from date_day) as year,
        extract(quarter from date_day) as quarter,
        extract(month from date_day) as month,
        extract(week from date_day) as week_of_year,
        extract(day from date_day) as day_of_month,
        extract(dayofweek from date_day) as day_of_week,
        extract(dayofyear from date_day) as day_of_year,
        
        -- Date labels
        to_char(date_day, 'YYYY-MM-DD') as date_string,
        to_char(date_day, 'Month') as month_name,
        to_char(date_day, 'Mon') as month_short_name,
        to_char(date_day, 'Day') as day_name,
        to_char(date_day, 'Dy') as day_short_name,
        
        -- Fiscal periods (assuming fiscal year = calendar year)
        concat('Q', extract(quarter from date_day), '-', extract(year from date_day)) as fiscal_quarter,
        concat(to_char(date_day, 'Mon'), '-', extract(year from date_day)) as fiscal_month,
        
        -- Week labels
        concat('W', lpad(cast(extract(week from date_day) as varchar), 2, '0'), '-', extract(year from date_day)) as week_label,
        
        -- Boolean flags
        case when extract(dayofweek from date_day) in (0, 6) then true else false end as is_weekend,
        case when extract(dayofweek from date_day) between 1 and 5 then true else false end as is_weekday,
        
        -- First/Last day flags
        case when extract(day from date_day) = 1 then true else false end as is_first_day_of_month,
        case when extract(day from date_day) = extract(day from last_day(date_day)) then true else false end as is_last_day_of_month,
        
        -- Metadata
        current_timestamp() as dbt_loaded_at,
        current_timestamp() as dbt_updated_at
        
    from date_spine
)

select * from dim_date
