{% docs payment_method %}
The method by which the customer paid for their sandwich.
Multiple payments are allowed per order.
One of the following values:

| method        | meaning                         |
| :------------ | :------------------------------ |
| bank_transfer | Paid via BACS                   |
| coupon        | Paid with a partner coupon      |
| credit_card   | Paid via credit card            |
| gift_card     | Paid with one of our gift cards |

{% enddocs %}

{% docs payment_id %}

Primary key of stripe payments and associated tables. Incrementing ID per payment _attempt_.
{% enddocs %}
