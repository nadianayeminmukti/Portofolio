select
	payment_type,
	count(*) as jumlah_penggunaan
from order_payments_dataset 
group by 1
order by 2 desc

with satu as(
select
	extract(year from order_purchase_timestamp) as tahun,
	payment_type,
	count(*) as jumlah_penggunaan
from order_payments_dataset as opd
inner join orders_dataset as od
	on opd.order_id = od.order_id
group by 1,2
order by 1,3 desc
)
select
	tahun,
	sum(case when payment_type = 'boleto' then jumlah_penggunaan else 0 end) as jumlah_boleto,
	sum(case when payment_type = 'credit_card' then jumlah_penggunaan else 0 end) as jumlah_credit_card,
	sum(case when payment_type = 'debit_card' then jumlah_penggunaan else 0 end) as jumlah_debit_card,
	sum(case when payment_type = 'not_defined' then jumlah_penggunaan else 0 end) as jumlah_not_defined,
	sum(case when payment_type = 'voucher' then jumlah_penggunaan else 0 end) as jumlah_voucher
from satu
group by 1