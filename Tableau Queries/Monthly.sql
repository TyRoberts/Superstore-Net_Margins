/*CTE only necessary for properly ordering dates with month name displayed,
if displaying month name will be handled elsewhere CTE becomes query.*/
WITH monthly AS(
        SELECT
            DATE_TRUNC('month', order_date)::date AS month_year,
            ROUND((SUM(profit) / SUM(sales) * 100), 2) || '%' AS net_margin,
            SUM(profit)::money AS profit
        FROM 
            original
        GROUP BY 
            month_year)
            
SELECT
    TO_CHAR(month_year, 'Month YYYY') AS "Month",
    net_margin AS "Net Margin",
    profit AS "Profit"
FROM 
    monthly
ORDER BY 
    month_year;