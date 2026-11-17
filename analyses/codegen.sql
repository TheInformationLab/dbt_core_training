{{ codegen.generate_source(
    name = 'jaffle_shop' ,
    schema_name= 'jaffle_shop', 
    database_name= 'dbt-training-511114' ,
    table_names = ['orders', 'customers'] , 

    generate_columns= true)


    
    }}