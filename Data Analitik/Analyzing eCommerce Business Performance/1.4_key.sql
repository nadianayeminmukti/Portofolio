ALTER TABLE customers_dataset ADD PRIMARY KEY (customer_id);
ALTER TABLE orders_dataset ADD PRIMARY KEY (order_id);
ALTER TABLE product_dataset ADD PRIMARY KEY (product_id);
ALTER TABLE sellers_dataset ADD PRIMARY KEY (seller_id);

ALTER TABLE order_items_dataset ADD FOREIGN KEY (order_id) 
REFERENCES orders_dataset(order_id);
ALTER TABLE order_items_dataset ADD FOREIGN KEY (product_id) 
REFERENCES product_dataset(product_id);
ALTER TABLE order_items_dataset ADD FOREIGN KEY (seller_id) 
REFERENCES sellers_dataset(seller_id);
ALTER TABLE order_payments_dataset ADD FOREIGN KEY (order_id) 
REFERENCES orders_dataset(order_id);
ALTER TABLE order_reviews_dataset ADD FOREIGN KEY (order_id) 
REFERENCES orders_dataset(order_id);
ALTER TABLE orders_dataset ADD FOREIGN KEY (customer_id) 
REFERENCES customers_dataset(customer_id);