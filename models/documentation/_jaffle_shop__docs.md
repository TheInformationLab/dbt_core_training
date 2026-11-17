{% docs jaffle_shop__order_id %}
Order ID, Primary Key of the orders table
{% enddocs %}

{% docs jaffle_shop__customer_id %}
Customer ID, Primary key of the **customers** table
{% enddocs %}

{% docs stripe__payment_method %}
The method used to pay for the sandwich, one of:

| method | Description |
|:---|:---|
| bank_transfer | Payment via BACS |
| coupon | Used one of our coupons
| credit_card | Payment via credit **or debit** card|
| gift_card | Used on of our gift cards |
{% enddocs %}