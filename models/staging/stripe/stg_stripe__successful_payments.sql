with payments as (
    select * from {{ ref('stg_stripe__payments')}}

    where payment_status not in ('fail')
)

select 
    order_id
    , order_value_dollars
    , payment_date
    , payment_id
    , payment_method
    , payment_status
from payments

