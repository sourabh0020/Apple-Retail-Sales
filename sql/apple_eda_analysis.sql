/* ============================================================================
   APPLE RETAIL SALES & WARRANTY ANALYTICS — SQL ANALYSIS
   Database: SQL Server (T-SQL)
   Tables  : category, products, sales, stores, warranty
   Author  : Sourabh Yadav
   ============================================================================ */

USE apple;

/* ----------------------------------------------------------------------------
   0. TABLE PREVIEW
---------------------------------------------------------------------------- */
SELECT * FROM category;
SELECT * FROM products;
SELECT TOP 10 * FROM sales;
SELECT * FROM stores;
SELECT * FROM warranty;

/* ----------------------------------------------------------------------------
   1. EXPLORATORY DATA ANALYSIS (EDA)
   Sanity-checking cardinality of each table before writing business queries.
---------------------------------------------------------------------------- */
SELECT DISTINCT category_id FROM category;   -- 10 categories (CAT-1 to CAT-10)
SELECT DISTINCT product_id  FROM products;   -- 64 products
SELECT DISTINCT sale_id     FROM sales;      -- 1,040,191 transactions
SELECT DISTINCT store_id    FROM stores;     -- 73 stores
SELECT DISTINCT claim_id    FROM warranty;   -- 30,836 warranty claims


/* ============================================================================
   BUSINESS QUESTIONS
   ============================================================================ */

/* ----------------------------------------------------------------------------
   Q1. Find each country and number of stores
---------------------------------------------------------------------------- */
SELECT country, COUNT(store_id) AS num_of_stores
FROM stores
GROUP BY country
ORDER BY num_of_stores DESC;

/* ----------------------------------------------------------------------------
   Q2. Total number of units sold by each store
---------------------------------------------------------------------------- */
SELECT s.store_id, st.store_name, SUM(s.quantity) AS num_of_units
FROM sales s
JOIN stores st ON s.store_id = st.store_id
GROUP BY s.store_id, st.store_name
ORDER BY store_id DESC;

/* ----------------------------------------------------------------------------
   Q3. How many sales occurred in December 2023?
---------------------------------------------------------------------------- */
SELECT COUNT(quantity) AS total_sales
FROM sales
WHERE sale_date >= '2023-12-01' AND sale_date < '2024-01-01';

/* ----------------------------------------------------------------------------
   Q4. How many stores have never had a warranty claim filed
       against any of their products?
---------------------------------------------------------------------------- */
SELECT COUNT(*)
FROM stores
WHERE store_id NOT IN (
    SELECT DISTINCT s.store_id
    FROM sales s
    RIGHT JOIN warranty w ON s.sale_id = w.sale_id
);

/* ----------------------------------------------------------------------------
   Q5. What percentage of warranty claims are marked as "Warranty Void"?
---------------------------------------------------------------------------- */
SELECT
    ROUND(
        CAST(SUM(CASE WHEN repair_status = 'warranty void' THEN 1 ELSE 0 END) AS FLOAT)
        * 100.0 / COUNT(*), 2
    ) AS warranty_void_percentage
FROM warranty;

/* ----------------------------------------------------------------------------
   Q6. Which store had the highest total units sold in the last year?
---------------------------------------------------------------------------- */
SELECT TOP 1 s.store_id, ss.store_name, SUM(s.quantity) AS highest_unit_sold
FROM sales s
JOIN stores ss ON s.store_id = ss.store_id
WHERE s.sale_date >= DATEADD(YEAR, -1, '2024')
GROUP BY s.store_id, ss.store_name
ORDER BY highest_unit_sold DESC;

/* ----------------------------------------------------------------------------
   Q7. Count the number of unique products sold in the last year
---------------------------------------------------------------------------- */
SELECT COUNT(DISTINCT product_id) AS unique_product_sale
FROM sales
WHERE sale_date >= DATEADD(YEAR, -1, '2024');

/* ----------------------------------------------------------------------------
   Q8. What is the average price of products in each category?
---------------------------------------------------------------------------- */
SELECT p.category_id, c.category_name, AVG(price) AS average_price
FROM products p
JOIN category c ON p.category_id = c.category_id
GROUP BY p.category_id, c.category_name
ORDER BY average_price DESC;

/* ----------------------------------------------------------------------------
   Q9. How many warranty claims were filed in 2020?
---------------------------------------------------------------------------- */
SELECT COUNT(claim_id) AS num_of_warranty_claims
FROM warranty
WHERE YEAR(claim_date) = 2020;

/* ----------------------------------------------------------------------------
   Q10. Identify each store's best-selling day based on highest qty sold
   Technique: RANK() OVER (PARTITION BY ...)
---------------------------------------------------------------------------- */
SELECT store_id, Day, highest_sale
FROM (
    SELECT
        store_id,
        FORMAT(sale_date, 'dddd') AS "Day",
        SUM(quantity) AS highest_sale,
        RANK() OVER (PARTITION BY store_id ORDER BY SUM(quantity) DESC) AS rnk
    FROM sales
    GROUP BY store_id, sale_date
) AS sub_query
WHERE rnk = 1
ORDER BY highest_sale DESC;

/* ----------------------------------------------------------------------------
   Q11. Identify the least-selling product of each country
        based on total units sold
   Technique: CTE + RANK()
---------------------------------------------------------------------------- */
WITH least_sold_date AS (
    SELECT
        st.country AS country,
        p.product_name AS product_name,
        SUM(s.quantity) AS num_sold,
        RANK() OVER (PARTITION BY st.country ORDER BY SUM(s.quantity)) AS rnk
    FROM products p
    JOIN sales s  ON p.product_id = s.product_id
    JOIN stores st ON s.store_id = st.store_id
    GROUP BY st.country, p.product_name
)
SELECT country, product_name, num_sold
FROM least_sold_date
WHERE rnk = 1
ORDER BY num_sold;

/* ----------------------------------------------------------------------------
   Q12. How many warranty claims were filed within 180 days of a product sale?
---------------------------------------------------------------------------- */
WITH day_diff AS (
    SELECT s.sale_date, w.*
    FROM warranty w
    LEFT JOIN sales s ON s.sale_id = w.sale_id
    WHERE DATEDIFF(DAY, s.sale_date, w.claim_date) <= 180
)
SELECT COUNT(*) AS num_of_claims
FROM day_diff;

/* ----------------------------------------------------------------------------
   Q13. How many warranty claims have been filed for products
        launched in the last two years?
---------------------------------------------------------------------------- */
SELECT
    p.product_name,
    COUNT(w.claim_id) AS num_claims,
    COUNT(s.sale_id)  AS total_sale
FROM warranty AS w
RIGHT JOIN sales AS s ON w.sale_id = s.sale_id
JOIN products AS p    ON s.product_id = p.product_id
WHERE p.launch_date >= DATEADD(YEAR, -2, GETDATE())
GROUP BY p.product_name;

/* ----------------------------------------------------------------------------
   Q14. List the months (last 3 years) where sales exceeded 5,000 units in the USA
---------------------------------------------------------------------------- */
SELECT
    FORMAT(s.sale_date, 'yyyy-MM') AS months,
    SUM(quantity) AS total_quantity
FROM sales s
JOIN stores st ON s.store_id = st.store_id
WHERE st.country = 'USA'
  AND sale_date > DATEADD(YEAR, -3, GETDATE())
GROUP BY FORMAT(s.sale_date, 'yyyy-MM')
HAVING SUM(quantity) > 5000
ORDER BY months;

/* ----------------------------------------------------------------------------
   Q15. Which product category had the most warranty claims
        filed in the last 2 years?
---------------------------------------------------------------------------- */
SELECT TOP 1 p.category_id, c.category_name, COUNT(claim_id) AS total_claims
FROM warranty w
LEFT JOIN sales s ON w.sale_id = s.sale_id
JOIN products p   ON s.product_id = p.product_id
JOIN category c   ON p.category_id = c.category_id
WHERE claim_date > DATEADD(YEAR, -2, GETDATE())
GROUP BY p.category_id, c.category_name
ORDER BY total_claims DESC;

/* ----------------------------------------------------------------------------
   Q16. Determine the percentage chance of receiving a claim
        after each purchase, for each country
---------------------------------------------------------------------------- */
WITH main AS (
    SELECT
        st.country AS Country,
        COUNT(w.claim_id) AS count_of_claims,
        COUNT(s.sale_id)  AS Total_of_sales
    FROM sales s
    JOIN stores st ON s.store_id = st.store_id
    LEFT JOIN warranty w ON s.sale_id = w.sale_id
    GROUP BY st.country
    HAVING COUNT(w.claim_id) > 0
)
SELECT
    country,
    count_of_claims,
    Total_of_sales,
    ROUND(CAST(count_of_claims * 100.0 / Total_of_sales AS FLOAT), 2) AS percentage_of_claims
FROM main
ORDER BY percentage_of_claims DESC;

/* ----------------------------------------------------------------------------
   Q17. Analyze each store's year-over-year growth ratio
   Technique: CTE + LAG() window function
---------------------------------------------------------------------------- */
WITH yearly_sales AS (
    SELECT
        s.store_id, st.store_name,
        YEAR(s.sale_date) AS years,
        SUM(s.quantity * p.price) AS total_sales
    FROM sales s
    JOIN products p ON s.product_id = p.product_id
    JOIN stores st  ON s.store_id = st.store_id
    GROUP BY s.store_id, st.store_name, YEAR(s.sale_date)
),
pre_year_sales AS (
    SELECT
        store_id, store_name, years,
        LAG(total_sales) OVER (PARTITION BY store_name ORDER BY years) AS Last_year_sale,
        total_sales AS current_year_sale
    FROM yearly_sales
)
SELECT
    store_id, store_name, years, Last_year_sale, current_year_sale,
    CAST(ROUND((current_year_sale - Last_year_sale) * 100.0 / Last_year_sale, 2) AS DECIMAL(10,2)) AS yearly_growth_ratio
FROM pre_year_sales
WHERE Last_year_sale IS NOT NULL
  AND years <> YEAR(GETDATE());

/* ----------------------------------------------------------------------------
   Q18. Correlation between product price and warranty claims
        for products sold in the last 5 years (segmented by price tier)
---------------------------------------------------------------------------- */
WITH details AS (
    SELECT
        claim_date, product_name, price,
        CASE
            WHEN price < 500 THEN 'Low_price_products'
            WHEN price >= 500 AND price <= 1000 THEN 'Average_price_products'
            ELSE 'high_cost_products'
        END AS prices_segmentation
    FROM warranty w
    LEFT JOIN sales s ON w.sale_id = s.sale_id
    JOIN products p    ON s.product_id = p.product_id
    WHERE claim_date >= DATEADD(YEAR, -5, GETDATE())
)
SELECT prices_segmentation, COUNT(prices_segmentation) AS Total_claims
FROM details
GROUP BY prices_segmentation
ORDER BY Total_claims DESC;

/* ----------------------------------------------------------------------------
   Q19. Identify the store with the highest percentage of "Paid Repaired"
        claims relative to its total claims filed
---------------------------------------------------------------------------- */
WITH count_of_paid AS (
    SELECT store_id, COUNT(claim_id) AS paid
    FROM warranty w
    LEFT JOIN sales s ON w.sale_id = s.sale_id
    WHERE repair_status = 'paid repaired'
    GROUP BY store_id
),
total_claims AS (
    SELECT store_id, COUNT(claim_id) AS total
    FROM warranty w
    LEFT JOIN sales s ON w.sale_id = s.sale_id
    GROUP BY store_id
)
SELECT
    c.store_id, paid, total,
    CAST(ROUND((paid * 100.0) / total, 2) AS DECIMAL(10,2)) AS percentage_of_paid_repaired
FROM count_of_paid c
JOIN total_claims t ON c.store_id = t.store_id;

/* ----------------------------------------------------------------------------
   Q20. Monthly running total of sales for each store over the past 4 years
   Technique: Window function SUM() OVER (PARTITION BY ... ORDER BY ...)
---------------------------------------------------------------------------- */
WITH total_sale AS (
    SELECT
        s.store_id AS Store_id,
        DATEPART(YEAR, sale_date)  AS "Year",
        DATEPART(MONTH, sale_date) AS "Month",
        SUM(p.price * s.quantity) AS Total_Sales
    FROM sales s
    JOIN products p ON s.product_id = p.product_id
    GROUP BY s.store_id, DATEPART(YEAR, sale_date), DATEPART(MONTH, sale_date)
)
SELECT
    Store_id, Year, Month, Total_Sales,
    SUM(Total_Sales) OVER (PARTITION BY Store_id ORDER BY Year, Month) AS running_total
FROM total_sale
ORDER BY Store_id, Year, Month;

/* ----------------------------------------------------------------------------
   Q21. Sales trend of each product across lifecycle stages:
        0-6, 6-12, 12-18, and 18+ months post-launch
---------------------------------------------------------------------------- */
WITH sales_trend AS (
    SELECT
        p.product_name, p.launch_date, s.sale_date, s.quantity,
        CASE
            WHEN s.sale_date BETWEEN p.launch_date AND DATEADD(MONTH, 6, p.launch_date) THEN '0-6month_sale'
            WHEN s.sale_date BETWEEN DATEADD(MONTH, 6, p.launch_date) AND DATEADD(MONTH, 12, p.launch_date) THEN '6-12month_sale'
            WHEN s.sale_date BETWEEN DATEADD(MONTH, 12, p.launch_date) AND DATEADD(MONTH, 18, p.launch_date) THEN '12-18month_sale'
            ELSE '18+_month_sale'
        END AS time_period
    FROM sales s
    JOIN products p ON s.product_id = p.product_id
)
SELECT product_name, time_period, SUM(quantity) AS total_quantity_sold
FROM sales_trend
GROUP BY product_name, time_period
ORDER BY product_name;
