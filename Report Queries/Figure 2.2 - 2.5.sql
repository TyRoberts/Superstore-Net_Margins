-- Figure 2.2 - 2.5 can be generated by changing WHERE clause. Figure 2.2 
SELECT 
	"state" AS "State",
	ROUND((SUM(original.profit) / SUM(original.sales) * 100), 2) || '%' AS "Net Margin"
FROM
	original
WHERE 
	original.order_date BETWEEN '01-01-2018' AND '02-01-2018'
	AND
	original.region = 'Central' -- 2.3 'East', 2.4 'South', 2.5 'West'
GROUP BY 
	"state"
ORDER BY 
	"state";