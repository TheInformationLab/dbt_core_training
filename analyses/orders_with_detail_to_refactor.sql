select 
    b.id as customer_id,
    b.name as full_name,
    b.last_name as surname,
    b.first_name as givenname,
    min(order_date) as first_order_date,
    min(case when a.status NOT IN ('returned','return_pending') then order_date end) as first_non_returned_order_date,
    max(case when a.status NOT IN ('returned','return_pending') then order_date end) as most_recent_non_returned_order_date,
    COALESCE(max(user_order_seq),0) as order_count,
    COALESCE(count(distinct case when a.status != 'returned' then c.orderid else null end),0) as non_returned_order_count,
    round(sum(case when a.status NOT IN ('returned','return_pending') then c.amount/100.0 else 0 end),2) as total_lifetime_value,
    round(sum(case when a.status NOT IN ('returned','return_pending') then c.amount/100.0 else 0 end)/NULLIF(count(distinct case when a.status NOT IN ('returned','return_pending') then c.orderid else null end),0),2) as avg_non_returned_order_value,
    array_agg(distinct a.id order by a.id) as order_ids

from (
    select 
    row_number() over (partition by user_id order by order_date, id) as user_order_seq,
    *
    from jaffle_shop.orders
) a

join ( 
    select 
    first_name || ' ' || last_name as name, 
    * 
    from jaffle_shop.customers
) b
on a.user_id = b.id

left outer join stripe.payments c
on a.id = c.orderid

where a.status NOT IN ('pending') and c.status != 'fail'

group by b.id, b.name, b.last_name, b.first_name