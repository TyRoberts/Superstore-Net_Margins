SELECT
	TO_CHAR(TO_DATE(DATE_PART('month', order_date)::text, 'MM'), 'Month') AS "Month",
	ROUND(SUM(profit) / SUM(sales) * 100, 2) || '%' AS "Net Margin"
FROM
	original
GROUP BY
	"Month"
ORDER BY 
	(SUM(profit) / SUM(sales)) DESC;