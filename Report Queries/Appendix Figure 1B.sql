SELECT
	TO_CHAR(TO_DATE(DATE_PART('month', order_date)::text, 'MM'), 'Month') AS "Month",
	(SUM(sales) / COUNT(DISTINCT DATE_PART('year', order_date)))::money AS "Revenue"
FROM
	original
GROUP BY
	"Month"
ORDER BY 
	"Revenue" DESC;