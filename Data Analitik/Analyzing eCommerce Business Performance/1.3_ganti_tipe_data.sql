ALTER TABLE order_items_dataset ALTER COLUMN shipping_limit_date TYPE TIMESTAMP WITHOUT TIME ZONE 
USING shipping_limit_date::TIMESTAMP WITHOUT TIME ZONE;

ALTER TABLE order_reviews_dataset ALTER COLUMN review_creation_date TYPE TIMESTAMP WITHOUT TIME ZONE 
USING review_creation_date::TIMESTAMP WITHOUT TIME ZONE;
ALTER TABLE order_reviews_dataset ALTER COLUMN review_answer_timestamp TYPE TIMESTAMP WITHOUT TIME ZONE 
USING review_answer_timestamp::TIMESTAMP WITHOUT TIME ZONE;

ALTER TABLE orders_dataset ALTER COLUMN order_purchase_timestamp TYPE TIMESTAMP WITHOUT TIME ZONE 
USING order_purchase_timestamp::TIMESTAMP WITHOUT TIME ZONE;
ALTER TABLE orders_dataset ALTER COLUMN order_approved_at TYPE TIMESTAMP WITHOUT TIME ZONE 
USING order_approved_at::TIMESTAMP WITHOUT TIME ZONE;
ALTER TABLE orders_dataset ALTER COLUMN order_delivered_carrier_date TYPE TIMESTAMP WITHOUT TIME ZONE 
USING order_delivered_carrier_date::TIMESTAMP WITHOUT TIME ZONE;
ALTER TABLE orders_dataset ALTER COLUMN order_delivered_customer_date TYPE TIMESTAMP WITHOUT TIME ZONE 
USING order_delivered_customer_date::TIMESTAMP WITHOUT TIME ZONE;
ALTER TABLE orders_dataset ALTER COLUMN order_estimated_delivery_date TYPE TIMESTAMP WITHOUT TIME ZONE 
USING order_estimated_delivery_date::TIMESTAMP WITHOUT TIME ZONE;