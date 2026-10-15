with customers as (
    select * from {{ref('stg_jaffle_shop__customers')}}
)

, orders as (
    select * from {{ ref('stg_jaffle_shop__orders')}}
)

, payments as (
    select * from {{ref('stg_stripe__successful_payments')}}
)


select 
    b.customer_id,
    b.name as full_name,
    b.last_name as surname,
    b.first_name as givenname,
    min(order_date) as first_order_date,
    min(case when a.is_not_return then order_date end) as first_non_returned_order_date,
    max(case when a.is_not_return then order_date end) as most_recent_non_returned_order_date,
    COALESCE(max(user_order_seq),0) as order_count,
    COALESCE(count(distinct case when a.order_status != 'returned' then c.order_id else null end),0) as non_returned_order_count,
    sum(case when a.is_not_return then c.order_value_dollars else 0 end) as total_lifetime_value,
    sum(case when a.is_not_return then c.order_value_dollars else 0 end)/NULLIF(count(distinct case when a.is_not_return then c.order_id else null end),0) as avg_non_returned_order_value,
    array_agg(distinct a.order_id order by a.order_id) as order_ids

from orders a

join customers b
on a.customer_id = b.customer_id

left outer join payments c
on a.order_id = c.order_id

group by 1,2,3,4