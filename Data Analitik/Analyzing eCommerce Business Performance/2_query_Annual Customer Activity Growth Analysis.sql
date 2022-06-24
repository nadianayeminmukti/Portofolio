WITH MAU AS(
	SELECT 
		tahun,
		ROUND(AVG(jumlah_pelanggan),2) AS monthly_active_user
	FROM(
		SELECT
			EXTRACT(YEAR FROM od.order_purchase_timestamp) AS tahun,
			EXTRACT(MONTH FROM od.order_purchase_timestamp) AS bulan,
			COUNT(DISTINCT cd.customer_unique_id) AS jumlah_pelanggan
		FROM orders_dataset AS od
		LEFT JOIN customers_dataset AS cd
			ON cd.customer_id = od.customer_id
		GROUP BY 1,2
		ORDER BY 1
	) AS tmp
	GROUP BY 1
),

TRANSAKSI_PERTAMA AS(
	SELECT
		EXTRACT(YEAR FROM tmp.transaksi_pertama) AS tahun,
		COUNT(DISTINCT tmp.customer_unique_id) AS jumlah_customer_baru
	FROM(
		SELECT
			cd.customer_unique_id,
			MIN(od.order_purchase_timestamp) AS transaksi_pertama
		FROM orders_dataset AS od
		LEFT JOIN customers_dataset AS cd
		ON cd.customer_id = od.customer_id
		GROUP BY 1
	) AS tmp
	GROUP BY 1
	ORDER BY 1
),

JUMLAH_CUSTOMER AS(
	SELECT
		tahun,
		COUNT(customer_unique_id) AS jumlah_customer_repeat_order
	FROM(
		SELECT
			cd.customer_unique_id,
			EXTRACT(YEAR FROM order_purchase_timestamp) AS tahun,
			COUNT(order_id) AS jumlah_transaksi
		FROM orders_dataset AS od
		LEFT JOIN customers_dataset AS cd
			ON cd.customer_id = od.customer_id
		GROUP BY 1,2
		HAVING COUNT(od.order_id) > 1
	) AS tmp
	GROUP BY 1
	ORDER BY 1
),

AVG_TRANSAKSI AS(
	SELECT
		tahun,
		ROUND(AVG(jumlah_transaksi),2) AS avg_jumlah_transaksi
	FROM(
		SELECT
			cd.customer_unique_id,
			EXTRACT(YEAR FROM order_purchase_timestamp) AS tahun,
			COUNT(order_id) AS jumlah_transaksi
		FROM orders_dataset AS od
		LEFT JOIN customers_dataset AS cd
			ON cd.customer_id = od.customer_id
		GROUP BY 1,2
	) AS tmp
	GROUP BY 1
	ORDER BY 1
)

SELECT
	MAU.tahun,
	monthly_active_user,
	jumlah_customer_baru,
	jumlah_customer_repeat_order,
	avg_jumlah_transaksi
FROM 
	MAU
LEFT JOIN 
	TRANSAKSI_PERTAMA AS TP
		ON MAU.tahun = TP.tahun
LEFT JOIN 
	JUMLAH_CUSTOMER AS JC
		ON MAU.tahun = JC.tahun
LEFT JOIN
	AVG_TRANSAKSI AS AT
		ON MAU.tahun = AT.tahun
	
	
	