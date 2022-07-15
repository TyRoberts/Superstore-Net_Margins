WITH monthly AS(
	SELECT
		region,
		(SUM(sales)/
	/*Since transactions can occur in a region every month, all months are used for monthly 
		average. Not just months in which transactions occured.*/
		(SELECT COUNT(DISTINCT DATE_TRUNC('month',order_date)) FROM original))::money AS revenue
	FROM
		original
	GROUP BY
		region)

SELECT 
	original.region AS "Region",
	SUM(original.sales)::money AS "Jan 2018 Revenue",
	monthly.revenue AS "Average Monthly Revenue"
FROM
	original
INNER JOIN
	monthly
	ON
	original.region = monthly.region
WHERE 
	original.order_date BETWEEN '01-01-2018' AND '02-01-2018'
GROUP BY 
	original.region,
	monthly.revenue
ORDER BY 
	original.region;