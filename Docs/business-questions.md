# Business Questions Answered (SQL)

Full queries in [`sql/apple_eda_analysis.sql`](../sql/apple_eda_analysis.sql).

| # | Question | Key SQL Technique |
|---|---|---|
| 1 | Stores per country | GROUP BY |
| 2 | Total units sold per store | JOIN + GROUP BY |
| 3 | Sales count in Dec 2023 | Date filtering |
| 4 | Stores with zero warranty claims | Subquery + RIGHT JOIN |
| 5 | % of claims marked "Warranty Void" | Conditional aggregation |
| 6 | Store with highest units sold (last year) | TOP + date filter |
| 7 | Unique products sold last year | COUNT DISTINCT |
| 8 | Average price per category | JOIN + AVG |
| 9 | Warranty claims filed in 2020 | YEAR() filter |
| 10 | Best-selling day per store | RANK() OVER (PARTITION BY) |
| 11 | Least-selling product per country | CTE + RANK() |
| 12 | Claims filed within 180 days of sale | DATEDIFF + CTE |
| 13 | Claims for products launched in last 2 years | Multi-table JOIN |
| 14 | Months where USA sales exceeded 5,000 units | GROUP BY + HAVING |
| 15 | Category with most claims (last 2 years) | TOP + JOIN chain |
| 16 | % chance of a claim per purchase, by country | CTE + ratio calculation |
| 17 | Store-level year-over-year growth ratio | CTE + LAG() window function |
| 18 | Price vs. warranty claim correlation | CASE-based segmentation |
| 19 | Store with highest "Paid Repaired" % | Two CTEs joined |
| 20 | Monthly running total of sales per store | SUM() OVER (ORDER BY) |
| 21 | Sales trend by product lifecycle stage | CASE-based time buckets |

**Techniques demonstrated:** window functions (RANK, LAG, running SUM), CTEs (including chained/multi-CTE queries), self-joins across 3–4 tables, conditional aggregation, date arithmetic, and percentage/ratio calculations.
