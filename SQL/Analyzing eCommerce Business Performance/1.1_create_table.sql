CREATE TABLE customers_dataset (
	customer_id VARCHAR(50),
	customer_unique_id VARCHAR(50),
	customer_zip_code_prefix INT,
	customer_city VARCHAR(50),
	customer_state VARCHAR(5)
);

CREATE TABLE geolocation_dataset (
	geolocation_zip_code_prefix INT,
	geolocation_lat REAL,
	geolocation_lng REAL,
	geolocation_city VARCHAR(50),
	geolocation_state VARCHAR(50)
);

CREATE TABLE order_items_dataset (
	order_id VARCHAR(50),
	order_item_id INT,
	product_id VARCHAR(50),
	seller_id VARCHAR(50),
	shipping_limit_date VARCHAR(50),
	price REAL,
	freight_value REAL
);

CREATE TABLE order_payments_dataset (
	order_id VARCHAR(50),
	payment_sequential INT,
	payment_type VARCHAR(50),
	payment_installments INT,
	payment_value REAL
);

CREATE TABLE order_reviews_dataset (
	review_id VARCHAR(50),
	order_id VARCHAR(50),
	review_score INT,
	review_comment_title VARCHAR(50),
	review_comment_message VARCHAR(500),
	review_creation_date VARCHAR(50),
	review_answer_timestamp VARCHAR(50)
);

CREATE TABLE orders_dataset (
	order_id VARCHAR(50),
	customer_id VARCHAR(50),
	order_status VARCHAR(50),
	order_purchase_timestamp VARCHAR(50),
	order_approved_at VARCHAR(50),
	order_delivered_carrier_date VARCHAR(50),
	order_delivered_customer_date VARCHAR(50),
	order_estimated_delivery_date VARCHAR(50)
);

CREATE TABLE product_dataset (
	Unnamed INT,
	product_id VARCHAR(50),
	product_category_name VARCHAR(50),
	product_name_lenght REAL,
	product_description_lenght REAL,
	product_photos_qty REAL,
	product_weight_g REAL,
	product_length_cm REAL,
	product_height_cm REAL,
	product_width_cm REAL
);

CREATE TABLE sellers_dataset (
	seller_id VARCHAR(50),
	seller_zip_code_prefix INT,
	seller_city VARCHAR(50),
	seller_state VARCHAR(50)
);