WITH REVENUE AS(
SELECT 
	tahun,
	SUM(rev) AS revenue
FROM(
	SELECT
		EXTRACT(YEAR FROM order_purchase_timestamp) AS tahun,
		CAST((price+freight_value) AS NUMERIC) AS rev
	FROM order_items_dataset AS oid
	INNER JOIN orders_dataset AS od
		ON oid.order_id = od.order_id
	WHERE order_status = 'delivered'
) AS tmp
GROUP BY 1
),

JUMLAH_CANCEL AS(
SELECT
	EXTRACT(YEAR FROM order_purchase_timestamp) AS tahun,
	COUNT(*) AS jumlah_cancel
FROM orders_dataset
WHERE order_status = 'canceled'
GROUP BY 1
),		

TOP_CATEGORY_REVENUE AS(
SELECT
	tahun,
	product_category_name AS top_category_revenue,
	jumlah_revenue
FROM(
	SELECT
		EXTRACT(YEAR FROM order_purchase_timestamp) AS tahun,
		product_category_name,
		CAST(SUM(price+freight_value) AS numeric) AS jumlah_revenue,
		RANK() OVER (PARTITION BY EXTRACT(YEAR FROM order_purchase_timestamp) 
					 ORDER BY CAST(SUM(price+freight_value) AS numeric) DESC)
	FROM order_items_dataset AS oid
	INNER JOIN product_dataset AS pd
		ON oid.product_id = pd.product_id
	INNER JOIN orders_dataset AS od
		ON oid.order_id = od.order_id
	WHERE order_status = 'delivered'
	GROUP BY 1,2
	ORDER BY 1,3 DESC
) AS tmp
WHERE RANK = 1
),

TOP_CATEGORY_CANCELED AS(
SELECT
	tahun,
	product_category_name AS top_category_canceled,
	jumlah_cancel
FROM(
	SELECT
		EXTRACT(YEAR FROM order_purchase_timestamp) AS tahun,
		product_category_name,
		COUNT(*) AS jumlah_cancel,
		RANK() OVER (PARTITION BY EXTRACT(YEAR FROM order_purchase_timestamp) ORDER BY COUNT(*) DESC)
	FROM order_items_dataset AS oid
	LEFT JOIN product_dataset AS pd
		ON oid.product_id = pd.product_id
	LEFT JOIN orders_dataset AS od
		ON oid.order_id = od.order_id
	WHERE order_status = 'canceled'
	GROUP BY 1,2
	ORDER BY 1,3 DESC
) AS tmp
WHERE RANK = 1
)

SELECT 
	R.tahun,
	revenue AS total_revenue,
	JC.jumlah_cancel AS total_cancel,
	top_category_revenue,
	TCR.jumlah_revenue AS jumlah_category_revenue,
	top_category_canceled,
	TCC.jumlah_cancel AS jumlah_category_canceled
FROM REVENUE AS R
LEFT JOIN JUMLAH_CANCEL AS JC
	ON R.tahun = JC.tahun
LEFT JOIN TOP_CATEGORY_REVENUE AS TCR
	ON R.tahun = TCR.tahun
LEFT JOIN TOP_CATEGORY_CANCELED AS TCC
	ON R.tahun = TCC.tahun
ORDER BY 1