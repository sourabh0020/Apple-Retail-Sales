#  Apple Retail Sales SQL Project + Power BI Dashboard
This project combines advanced SQL querying with Power BI dashboarding to analyze over 1 million rows of Apple retail sales data. It spans end-to-end analytics — from raw database to actionable visual insights.

---

#  Project Objective
To derive business insights using SQL and visualize key metrics in Power BI — including sales trends, warranty claims, geographic distribution, product performance, and more.

---

##  Data Cleaning (Pre-Processing Stage)
Before loading the data into SQL Server and Power BI, I performed essential cleaning in Python using pandas:

 Removed duplicates across key identifiers

 Stripped leading/trailing whitespaces in categorical columns (e.g., product names, regions)

 Handled null values — especially in the price and sales columns

 Ensured data type consistency (dates, numerics)

 Verified yearly price data for consistency using external web references (e.g., Apple archived prices by year)

 Saved the cleaned dataset to Excel, then imported into SQL Server for querying

This preprocessing ensured reliable insights and accurate visualizations downstream.

---

##  Database Overview
The dataset contains 5 interrelated tables simulating Apple’s retail operations:

### stores

### category

### products

### sales

### warranty

### Relationships were structured in a Star Schema, with sales as the fact table.

---
## Query Extraction:

**Total Queries: 20 real-world business questions** 

**Example:**

![Dashboard](https://github.com/sourabh0020/Apple-Retail-Sales/blob/main/Data%20modelling.png)

Difficulty: Beginner → Expert

Skills Practiced:

Store distribution, sales by category

Product claim ratios, launch timing

Time-based trends, YoY growth

Price vs claim rate correlation

Running totals, advanced joins, window functions

---

# 📊 Power BI Dashboard: Apple Sales & Warranty
An interactive, insight-rich dashboard created in Power BI to visually communicate findings from SQL analysis.

---

#  Dashboard Pages Overview:
### Page 1: Sales & Warranty Summary
KPIs: Total Sales, Total Units Sold, Total Claims, Claim Rate (%)

Top 5 Products & Country Sales

Sales vs Claims YoY Trend Line

### Page 2: Sales Analysis
Sales by price segmentation: High, Medium, Low

Bottom 10 Products & Countries by Sales

Store-wise Product Sales Breakdown

### Page 3: Warranty Insights
Claim Breakdown by Status

Category-wise and Country-wise Claims

Top 10 Products by Claim Rate (%)

Claim count by Price Segments

### Page 4: Advanced Analytics
Scatter Plot: Avg Price vs Warranty Rate

Matrix: Store-wise YoY Unit Growth

Interactive Slicers: Year, Price Segment

Multi-KPIs: Claim %, Void %, Avg Price

---

# Tools & Skills Used
SQL: Joins, Aggregations, CTEs, Window Functions, Date Logic

Power BI: DAX Measures, Relationships, Conditional Formatting, What-If Parameters

Python (pandas): Data Cleaning & Transformation

Data Modeling: Star Schema, ERD

Analytical Thinking: Root-Cause Analysis, KPI Design, Trend Identification

---

## Visuals Preview

## Summery

![Dashboard](https://github.com/sourabh0020/Apple-Retail-Sales-/blob/main/Snapshot%20of%20Summary.png)

## Sales Analysis

![Dashboard](https://github.com/sourabh0020/Apple-Retail-Sales-/blob/main/Snapshot%20of%20Sales%20Analysis.png)

## Warranty Insights

![Dashboard](https://github.com/sourabh0020/Apple-Retail-Sales-/blob/main/Snapshot%20of%20warranty%20Insights.png)

## Advance Analysis

![Dashboard](https://github.com/sourabh0020/Apple-Retail-Sales-/blob/main/Snapshot%20of%20Advance%20Analysis.png)
---
# Overall Summary

### Key Insights:
Total Sales: $977M with 1M units sold and 31K claims — overall Claim Rate: 3.01%
### Top Revenue Generating Products:
MacBook Pro (M1 Max, 16") and MacBook Pro account for 59% of total sales.
### Top Claim Rate Products:
iPad Air (4th Gen), Apple Watch Series 5, iPhone 11 Pro show claim rates over 20%, indicating potential quality or usage issues.
### High Claim Rate Countries:
UAE (70.84%) and Spain (29.88%) have alarmingly high warranty claims compared to other regions.
### Price Segment Sales:
Medium-priced products contribute to 57.63% of total sales and also hold the highest number of claims.
### Repair Status Breakdown:
65.4% of claims resulted in free replacements, while 23.16% were void, suggesting policy misalignment or misuse.
### Low-Performing Products & Regions:
Products like HomePod, AirPods (2nd & 3rd Gen) and countries like Dominican Republic, Saudi Arabia show very low sales volume.

---

### Deep Observations:
Year-over-Year Sales Trends:
2021 saw a peak in sales ($297M) but a drop in 2022 and 2023.

Warranty & Claim Rate vs. Price Segment:
High-priced products show lower claim rates compared to medium- and low-priced ones.

Store-Level Sales Volatility:
Many stores like Apple Istanbul and Ankara had inconsistent YoY performance (e.g., +12% in 2022, then +2% in 2023).

---

### Recommendations to the Company
1. Improve Product Quality Control :
Investigate products with >20% claim rates (iPad Air 4th Gen, Apple Watch Series 5) for recurring manufacturing or design issues.
Conduct post-claim interviews or surveys in UAE and Spain to understand why claims are so high.

2. Reevaluate Warranty Policy Enforcement :
High void claim percentage (23.16%) suggests confusion or misuse — improve customer education or streamline claim criteria.

3. Divest or Reposition Low-Selling Products :
Products like Apple Fitness, AirPods 2nd Gen, Apple One are not performing well.
Consider bundling, discounting, or repositioning them for niche use cases.

4. Optimize Inventory & Store Sales Performance:
Stores like Apple Bangkok and Buenos Aires show consistent sales decline.
Perform market analysis or retail staff performance audits to decide whether to revamp, relocate, or close underperforming stores.

5. Focus on High-Potential Mid-Priced Segments :
Mid-range products dominate in sales but also in claims.
Explore slight quality upgrades or extended warranty upsells to protect margins.

---

### Next Possible Steps:
Conduct deep dive reports into high-claim regions and products.

Set up Power BI alerts on sudden spikes in claim rates.

 
**Focus**: End-to-End SQL + BI Dashboards | Retail Analytics | KPI Tracking
