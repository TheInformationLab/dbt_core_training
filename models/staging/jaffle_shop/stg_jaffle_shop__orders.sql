

with source as (

    select * from {{ source('jaffle_shop', 'orders') }}

),

renamed as (

    select
        id as order_id
        , user_id as customer_id
        , order_date
        , status as order_status
        -- , _etl_loaded_at
        , row_number() OVER (partition by user_id order by order_date, id) as user_order_seq
        , status NOT IN('returned','return_pending') as is_not_return

    from source

)

select * from renamed

