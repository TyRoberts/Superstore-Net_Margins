WITH monthly AS(
	SELECT
		sub_category,
		(SUM(profit) / 
		/*Since it is possible for an item from each sub-category to be sold every month, all 
			 months are used for monthly average not just months in which transactions occured.*/	 
			 (SELECT COUNT(DISTINCT DATE_TRUNC('month', order_date)) FROM original))::money AS profit
	FROM
		original
	GROUP BY
		sub_category)

SELECT 
	original.sub_category AS "Category",
	ROUND((SUM(original.profit) / SUM(original.sales) * 100), 2) || '%' AS "Net Margin",
	SUM(original.profit)::money AS "Profit",
	monthly.profit AS "Average Monthly Profit"
FROM
	original
INNER JOIN
	monthly
	ON
	original.sub_category = monthly.sub_category
/* WHERE 
	original.order_date BETWEEN '01-01-2018' AND '02-01-2018'
	AND
	original.region = 'West'
	AND
	original.state = 'California'
	AND
	category = 'Furniture' */
GROUP BY 
	original.sub_category,
	monthly.profit
ORDER BY 
	original.sub_category;