WITH monthly AS(
        SELECT
            DATE_TRUNC('month', order_date)::date AS month_year,
            ROUND((SUM(profit) / SUM(sales) * 100), 2) ||'%' AS net_margin
        FROM 
            original
        GROUP BY 
            month_year)
            
SELECT
    TO_CHAR(month_year,'Month YYYY') AS "Month",
    net_margin AS "Net Margin"
FROM 
    monthly
ORDER BY 
    month_year;