WITH monthly AS(
	SELECT
		region,
		ROUND(SUM(profit) / SUM(sales) * 100, 2) || '%' AS avg_net_margin
	FROM
		original
	GROUP BY
		region)

SELECT 
	original.region AS "Region",
	ROUND((SUM(original.profit) / SUM(original.sales) * 100), 2) || '%' AS "Jan 2018 Net Margin",
	monthly.avg_net_margin AS "Average Net Margin"
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
	monthly.avg_net_margin
ORDER BY 
	original.region;