WITH monthly AS(
	SELECT
		region,
		(SUM(profit) /
	/*Since transactions can occur in a region every month, all months are used for monthly 
		average. Not just months in which transactions occured.*/
		(SELECT COUNT(DISTINCT DATE_TRUNC('month', order_date)) FROM original))::money AS profit
	FROM
		original
	GROUP BY
		region)

SELECT 
	original.region AS "Region",
	ROUND((SUM(original.profit) / SUM(original.sales) * 100), 2) || '%' AS "Net Margin",
	SUM(original.profit)::money AS "Profit",
	monthly.profit AS "Average Monthly Profit"
FROM
	original
INNER JOIN
	monthly
	ON
	original.region = monthly.region
--WHERE 
--	original.order_date BETWEEN '01-01-2018' AND '02-01-2018'
GROUP BY 
	original.region,
	monthly.profit
ORDER BY 
	original.region;