

-------Assignment-4

---------Discount Effects : 

--Generate a report including product IDs and discount effects on whether the increase in the discount rate positively impacts the number of orders for the products.
--In this assignment, you are expected to generate a solution using SQL with a logical approach. 




WITH table1 as (
SELECT  product_id, 
		SUM(quantity) over (PARTITION by product_id order by product_id)as sum_quantity,
		SUM(quantity * list_price) over (PARTITION by product_id order by product_id) as list_price_total,
		SUM((1-discount)*list_price*quantity) over (PARTITION by product_id order by product_id) as dis_list_price, 
		quantity as quantity , discount as discount,
		LEAD(quantity) over (order by product_id) as lead_quantity ,
		LEAD(discount) over (order by product_id) as lead_discount
FROM sale.order_item
),
TABLE2 AS (
SELECT product_id,quantity,discount,lead_discount,lead_quantity,
		CASE 
			WHEN lead_discount>discount and lead_quantity>quantity THEN 1
			WHEN lead_discount>discount and lead_quantity<quantity THEN -1
			WHEN lead_discount>discount and lead_quantity=quantity THEN 0
			WHEN lead_discount<discount and lead_quantity>quantity THEN -1
			WHEN lead_discount<discount and lead_quantity<quantity THEN 1
			WHEN lead_discount<discount and lead_quantity=quantity THEN 0
			ELSE 0 
		END AS RESULT

FROM table1
)
SELECT product_id,
		case 
			WHEN SUM(RESULT)>0 THEN 'Pozitive' 
			WHEN SUM(RESULT)>0 THEN 'Negative' 
			ELSE 'Neutral'
		END AS Discount_Effects
FROM TABLE2
GROUP BY product_id
ORDER BY product_id




