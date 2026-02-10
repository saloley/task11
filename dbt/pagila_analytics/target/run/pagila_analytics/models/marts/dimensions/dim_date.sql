
  
    

create or replace transient table PAGILA_SAKILA_DW.MARTS.dim_date
    
    
    
    as (

with date_spine as (
    





with rawdata as (

    

    

    with p as (
        select 0 as generated_number union all select 1
    ), unioned as (

    select

    
    p0.generated_number * power(2, 0)
     + 
    
    p1.generated_number * power(2, 1)
     + 
    
    p2.generated_number * power(2, 2)
     + 
    
    p3.generated_number * power(2, 3)
     + 
    
    p4.generated_number * power(2, 4)
     + 
    
    p5.generated_number * power(2, 5)
     + 
    
    p6.generated_number * power(2, 6)
     + 
    
    p7.generated_number * power(2, 7)
     + 
    
    p8.generated_number * power(2, 8)
     + 
    
    p9.generated_number * power(2, 9)
     + 
    
    p10.generated_number * power(2, 10)
     + 
    
    p11.generated_number * power(2, 11)
     + 
    
    p12.generated_number * power(2, 12)
     + 
    
    p13.generated_number * power(2, 13)
    
    
    + 1
    as generated_number

    from

    
    p as p0
     cross join 
    
    p as p1
     cross join 
    
    p as p2
     cross join 
    
    p as p3
     cross join 
    
    p as p4
     cross join 
    
    p as p5
     cross join 
    
    p as p6
     cross join 
    
    p as p7
     cross join 
    
    p as p8
     cross join 
    
    p as p9
     cross join 
    
    p as p10
     cross join 
    
    p as p11
     cross join 
    
    p as p12
     cross join 
    
    p as p13
    
    

    )

    select *
    from unioned
    where generated_number <= 9495
    order by generated_number



),

all_periods as (

    select (
        

    dateadd(
        day,
        row_number() over (order by 1) - 1,
        cast('2005-01-01' as date)
        )


    ) as date_day
    from rawdata

),

filtered as (

    select *
    from all_periods
    where date_day <= cast('2030-12-31' as date)

)

select * from filtered


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
    )
;


  