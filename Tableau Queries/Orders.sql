SELECT
	customer_name AS "Customer Name",
	product_id AS "Product ID",
	quantity || (CASE WHEN quantity > 1 THEN ' Units'
				 ELSE ' Unit' END) AS "Quantity",
	sales::money AS "Revenue",
	ROUND(profit / sales * 100) || '%' AS "Net Margin",
	ROUND(discount * 100) || '%' AS "Discount"
FROM
	original
/* WHERE 
	order_date BETWEEN '01-01-2018' AND '02-01-2018'
	AND
	region = 'West' 
	AND
	"state" = 'California'
	AND
	category = 'Furniture'
	AND 
	sub_category = 'Chairs'
	AND
	profit / sales <= 0
	AND 
	discount >= .2 */
ORDER BY 
	row_id;