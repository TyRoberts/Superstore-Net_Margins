-- All views in Appendix Figure 2 can be achieved by changing the region in WHERE clause.
WITH monthly AS(
	SELECT
		"state",
		(SUM(sales)/
	/*Since transactions can occur in a state every month, all months are used for monthly 
		average. Not just months in which transactions occured.*/
		(SELECT COUNT(DISTINCT DATE_TRUNC('month', order_date)) FROM original))::money AS revenue
	FROM
		original
	GROUP BY
		"state")

SELECT 
	original.state AS "State",
	SUM(original.sales)::money AS "Jan 2018 Revenue",
	monthly.revenue AS "Average Monthly Revenue"
FROM
	original
INNER JOIN
	monthly
	ON
	original.state = monthly.state
WHERE 
	original.order_date BETWEEN '01-01-2018' AND '02-01-2018'
	AND
	original.region = 'Central' -- 'East', 'South', 'West'
GROUP BY 
	original.state,
	monthly.revenue
ORDER BY 
	original.state;