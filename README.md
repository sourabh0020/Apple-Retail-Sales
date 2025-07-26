# 🍏 Apple Retail Sales SQL Project - Analyzing Millions of Sales Rows  
This project is designed to showcase advanced SQL querying techniques through the analysis of over 1 million rows of Apple retail sales data.

## 📌 Project Overview

This project is a deep dive into advanced SQL techniques using over **1 million rows** of Apple retail sales data. The dataset spans multiple years and includes detailed records across **stores, sales, products, categories**, and **warranty claims**. Through this project, we aim to explore business-critical insights by solving a series of tiered SQL problems — from beginner to expert level.

---

## 🗺️ Entity Relationship Diagram (ERD)

The database consists of five interrelated tables:
- `stores`
- `category`
- `products`
- `sales`
- `warranty`

These tables are structured to simulate a real-world retail environment, enabling a wide range of analytical queries and problem-solving scenarios.

---

## ✅ What’s Included

- **20 Real-World Business Queries** with step-by-step logic for critical problem-solving.
- **5 Well-Structured Tables** simulating a live business scenario.
- **1M+ Rows of Data**, perfect for query performance tuning and analysis.

---

- **Analytical Thinking**: Encourages solving problems similar to those faced by companies like Apple in operational analysis.

---

## 🧱 Database Schema Overview

### 1. `stores`
- `store_id`: Store identifier  
- `store_name`: Name of the store  
- `city`, `country`: Location details  

### 2. `category`
- `category_id`: Product category ID  
- `category_name`: Name of the category  

### 3. `products`
- `product_id`: Product ID  
- `product_name`: Name of the product  
- `category_id`: Foreign key  
- `launch_date`: Launch date  
- `price`: Retail price  

### 4. `sales`
- `sale_id`: Sale transaction ID  
- `sale_date`: Date of sale  
- `store_id`, `product_id`: Foreign keys  
- `quantity`: Quantity sold  

### 5. `warranty`
- `claim_id`: Claim ID  
- `claim_date`: Date of claim  
- `sale_id`: Foreign key  
- `repair_status`: Status (e.g., Paid Repaired, Warranty Void)

---

## 🎯 SQL Practice Levels

### Easy to Medium (10 Questions)
1. Number of stores per country  
2. Total units sold by each store  
3. Sales volume for December 2023  
4. Stores with no warranty claims  
5. % of claims marked as "Warranty Void"  
6. Top-selling store (last year)  
7. Unique products sold (last year)  
8. Average price per category  
9. Warranty claims in 2020  
10. Best-selling day per store  

### Medium to Hard (5 Questions)
11. Least selling product by country and year  
12. Claims within 180 days of sale  
13. Claims for products launched in last 2 years  
14. High-sales months (USA, last 3 years)  
15. Category with most claims (last 2 years)  

### Complex (5 Questions)
16. % chance of claim per country  
17. Store-wise YOY growth  
18. Price vs claims correlation by range  
19. Store with highest % of "Paid Repaired" claims  
20. Monthly running total of sales per store (4 years)

### Bonus
- Segment sales trends by product age:  
  `0–6 mo`, `6–12 mo`, `12–18 mo`, `18+ mo`

---

## 🧠 Project Focus Areas

- **Complex Joins & Aggregations**
- **Advanced Window Functions**
- **Time-Based Data Segmentation**
- **Trend and Correlation Analysis**
- **Real-World Business Problem Solving**

---

## 📊 Dataset Details

- **Volume**: Over 1 million rows  
- **Span**: Multiple years  
- **Regions**: Global Apple store coverage  
- **Tables**: Sales, Stores, Categories, Products, Warranties  

---

## 🚀 Conclusion

By completing this project, I develop expert-level SQL skills, master the ability to analyze large datasets, and gain hands-on experience with real-world business problems.

**Crafted by Sourabh Yadav**  
Advanced SQL Project | Apple Retail Simulation | End-to-End Analytics
