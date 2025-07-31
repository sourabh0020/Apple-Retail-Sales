# 🍏 Apple Retail Sales SQL Project + Power BI Dashboard
This project combines advanced SQL querying with Power BI dashboarding to analyze over 1 million rows of Apple retail sales data. It spans end-to-end analytics — from raw database to actionable visual insights.

---

# 🧠 Project Objective
To derive business insights using SQL and visualize key metrics in Power BI — including sales trends, warranty claims, geographic distribution, product performance, and more.

---

## 🧹 Data Cleaning (Pre-Processing Stage)
Before loading the data into SQL Server and Power BI, I performed essential cleaning in Python using pandas:

✅ Removed duplicates across key identifiers

✅ Stripped leading/trailing whitespaces in categorical columns (e.g., product names, regions)

✅ Handled null values — especially in the price and sales columns

✅ Ensured data type consistency (dates, numerics)

✅ Verified yearly price data for consistency using external web references (e.g., Apple archived prices by year)

✅ Saved the cleaned dataset to Excel, then imported into SQL Server for querying

This preprocessing ensured reliable insights and accurate visualizations downstream.

---

## 🗃️ Database Overview
The dataset contains 5 interrelated tables simulating Apple’s retail operations:

### stores

### category

### products

### sales

### warranty

### Relationships were structured in a Star Schema, with sales as the fact table.

---

## 🧪 SQL Problem Sets
### Total Queries: 20 real-world business questions + bonus insights

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

# 🖼️ Dashboard Pages Overview:
### 🟦 Page 1: Sales & Warranty Summary
KPIs: Total Sales, Total Units Sold, Total Claims, Claim Rate (%)

Top 5 Products & Country Sales

Sales vs Claims YoY Trend Line

### 🟩 Page 2: Sales Analysis
Sales by price segmentation: High, Medium, Low

Bottom 10 Products & Countries by Sales

Store-wise Product Sales Breakdown

### 🟨 Page 3: Warranty Insights
Claim Breakdown by Status

Category-wise and Country-wise Claims

Top 10 Products by Claim Rate (%)

Claim count by Price Segments

### 🟥 Page 4: Advanced Analytics
Scatter Plot: Avg Price vs Warranty Rate

Matrix: Store-wise YoY Unit Growth

Interactive Slicers: Year, Price Segment

Multi-KPIs: Claim %, Void %, Avg Price

---

# 🔧 Tools & Skills Used
SQL: Joins, Aggregations, CTEs, Window Functions, Date Logic

Power BI: DAX Measures, Relationships, Conditional Formatting, What-If Parameters

Python (pandas): Data Cleaning & Transformation

Data Modeling: Star Schema, ERD

Analytical Thinking: Root-Cause Analysis, KPI Design, Trend Identification

---

## 🖥️ Visuals Preview

## 📊 Summery

![Dashboard](https://github.com/sourabh0020/Apple-Retail-Sales-/blob/main/Snapshot%20of%20Summary.png)

## 📊 Sales Analysis

![Dashboard](https://github.com/sourabh0020/Apple-Retail-Sales-/blob/main/Snapshot%20of%20Sales%20Analysis.png)

## 📊 Warranty Insights

![Dashboard](https://github.com/sourabh0020/Apple-Retail-Sales-/blob/main/Snapshot%20of%20warranty%20Insights.png)

## 📊 Advance Analysis

![Dashboard](https://github.com/sourabh0020/Apple-Retail-Sales-/blob/main/Snapshot%20of%20Advance%20Analysis.png)
---

## 🙌 Credits

Project curated and developed by **Sourabh Yadav**  
**Focus**: End-to-End SQL + BI Dashboards | Retail Analytics | KPI Tracking
