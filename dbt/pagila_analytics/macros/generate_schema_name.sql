{% macro generate_schema_name(custom_schema_name, node) -%}
    {#- 
    This macro overrides the default schema naming to use custom schema names 
    WITHOUT the database prefix.
    
    Instead of: DBT_ANALYTICS_STAGING
    We get: STAGING
    -#}
    
    {%- set default_schema = target.schema -%}
    
    {%- if custom_schema_name is none -%}
        {{ default_schema | upper }}
    {%- else -%}
        {{ custom_schema_name | trim | upper }}
    {%- endif -%}

{%- endmacro %}