{% macro cents_to_dollars(column_name, dp=2) %}

round( {{column_name}} * 1.0/100, {{ dp }}) 

{% endmacro %}