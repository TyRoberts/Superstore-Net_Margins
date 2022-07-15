WITH monthly AS(
	SELECT
		"state",
		(SUM(profit) /
	/*Since transactions can occur in a state every month, all months are used for monthly 
		average. Not just months in which transactions occured.*/
		(SELECT COUNT(DISTINCT DATE_TRUNC('month', order_date)) FROM original))::money AS profit
	FROM
		original
	GROUP BY
		"state")

SELECT 
	original.state AS "State",
	ROUND((SUM(original.profit) / SUM(original.sales) * 100),2 ) || '%' AS "Net Margin",
	SUM(original.profit)::money AS "Profit",
	monthly.profit AS "Average Monthly Profit"
FROM
	original
INNER JOIN
	monthly
	ON
	original.state = monthly.state
/* WHERE 
	original.order_date BETWEEN '01-01-2018' AND '02-01-2018'
	AND
	original.region = 'West' */
GROUP BY 
	original.state,
	monthly.profit
ORDER BY 
	original.state;