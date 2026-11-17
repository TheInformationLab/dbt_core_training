with stg_stripe__payments as (
    select * from {{ ref('stg_stripe__payments') }}
)
select * 
from stg_stripe__payments
where payment_status not in ('fail')
