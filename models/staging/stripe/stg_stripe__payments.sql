

with source as (

    select * from {{ source('stripe', 'payments') }}

),

renamed as (

    select
        id as payment_id
        , orderid as order_id
        , paymentmethod as payment_method
        , status as payment_status
        , {{ cents_to_dollars('amount') }} as order_value_dollars
        , created as payment_date
        -- , _batched_at

    from source

)


select * from renamed

