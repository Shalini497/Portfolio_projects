--- Select tables which is used here

---- Show all customer records

SELECT * FROM customers;

---- Show Total number of customers
SELECT COUNT(*) FROM customers;

---- Show transactions for Chennai market (market code for chennai is Mark001

SELECT * FROM transactions WHERE market_code = "Mark001";

---- Show distrinct product codes that were sold in chennai

SELECT DISTINCT product_code FROM transactions WHERE market_code = "Mark001";

---- Show transactions where currency is US dollars

SELECT * FROM transactions WHERE currency = "USD";

---- Show transactions in 2020 join by date table

SELECT transactions.*,date.* FROM transactions
JOIN date ON transactions.order_date = date.date
WHERE year = 2020;

---- Show total revenue and Sales_QTY Amount in year 2020
SELECT SUM(transactions.sales_amount) AS Revenue , SUM(transactions.sales_qty) AS Sales_Qty_Amount FROM transactions 
INNER JOIN date ON transactions.order_date=date.date where date.year=2020 and transactions.currency="INR" or transactions.currency="USD";


---- Show total revenue,Sales_Qty and year in year 2019 in Chennai
SELECT SUM(transactions.sales_amount) AS Total_Revenue , SUM(transactions.sales_qty) AS Sales_Qty_Amount,date.year,transactions.market_code FROM transactions
JOIN date ON transactions.order_date = date.date
WHERE year = 2019 and market_code = "Mark001";

---- Show total profit margin

SELECT
    t.customer_code,
    d.year,
    d.month_name,
    SUM(t.sales_amount) AS total_sales_amount,
    SUM(t.sales_qty) AS total_sales_qty,
    SUM(t.sales_amount) - SUM(p.cost_amount * t.sales_qty) AS total_profit,
    (SUM(t.sales_amount) - SUM(p.cost_amount * t.sales_qty)) / SUM(t.sales_amount) * 100 AS profit_margin
FROM
    transactions t
JOIN
    date d ON t.order_date = d.date
JOIN
    products p ON t.product_code = p.product_code
GROUP BY
    t.customer_code,
    d.year,
    d.month_name;

