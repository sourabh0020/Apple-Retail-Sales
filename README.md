# 🍎 Apple Retail Sales & Warranty Analytics

End-to-end analytics project on Apple's global retail operations — **1.04M sales transactions** across **73 stores in 35 countries** (2019–2023), plus **30,836 warranty claims**. Built to answer real business questions around revenue drivers, market expansion, and warranty risk.

**Tools:** SQL (SQL Server / T-SQL) · Power BI (Data Modeling, DAX)

---

## 📊 Dashboard Preview

| Executive Overview | Sales Analysis |
|---|---|
| ![Overview](https://github.com/sourabh0020/Apple-Retail-Sales/blob/main/Images/02-Executive.png) | ![Sales](https://github.com/sourabh0020/Apple-Retail-Sales/blob/main/Images/03-%20Sales%20.png) |

| Warranty Risk | Store Performance |
|---|---|
| ![Warranty](https://github.com/sourabh0020/Apple-Retail-Sales/blob/main/Images/04-Warranty.png) | ![Store](https://github.com/sourabh0020/Apple-Retail-Sales/blob/main/Images/05-%20stores.png) |

**Data Model:**
![Data Model](https://github.com/sourabh0020/Apple-Retail-Sales/blob/main/Images/01-%20Data%20model.png)

---

## 🎯 Problem Statement

Apple's retail leadership needed a single source of truth to answer:
- Which markets and product categories actually drive revenue?
- Is 2022's sales spike a trend or a one-off?
- Where is warranty risk concentrated, and is it product-related or region-related?
- Which stores/countries deserve more expansion investment?

## 🗂️ Dataset

| | |
|---|---|
| **Scale** | ~1,040,191 sales transactions, 30,836 warranty claims |
| **Coverage** | 73 stores · 35 countries · 2019–2023 |
| **Tables** | `category`, `products` (64 SKUs), `sales`, `stores`, `warranty` |
| **Key fields** | sale_date, quantity, price, store/product/category IDs, claim_date, repair_status |

The dataset arrived pre-cleaned, so the workflow focused on SQL-based validation and business-question analysis rather than heavy cleaning.

## 🛠️ Workflow

1. **Exploratory checks in SQL** — validated table cardinality and relationships (5 tables, star-schema ready).
2. **21 business questions solved in SQL** — window functions (`RANK`, `LAG`, running totals), CTEs, self-joins, conditional aggregation. See [`sql/apple_eda_analysis.sql`](sql/apple_eda_analysis.sql).
3. **Data modeling in Power BI** — star schema linking Sales → Products, Stores, Warranty, Category, and a Date table.
4. **DAX measures** — Total Revenue, Units Sold, Average Order Value, Claim Rate %, Year-over-Year %, calculated columns for Price Segment and Product Lifecycle Stage.
5. **4-page interactive dashboard** — Executive Overview, Sales Analysis, Warranty Risk, Store Performance — with Year/Country slicers.

## 💡 Key Insights

- **USA is the anchor market** — $305.7M revenue from just 10 stores ($30.6M/store), more than 1.5x the next-highest country.
- **2022 was a launch supercycle, not the new normal** — the +66% YoY spike was driven by M1 MacBook + iPhone 14 launches; the 2023 pullback is a natural post-launch correction.
- **47% of a product's lifetime revenue lands in its first 6 months** — marketing ROI drops sharply after month 18.
- **UAE is a critical warranty outlier** — a 70.8% claim rate, ~28x the global average, pointing to a localized quality or distribution issue rather than a global product defect.
- **Subscription products have the highest claim rate of any category** (9.35%) — over 2x the next-highest category.
- **India and Turkey are the highest-ROI expansion markets** — both average $23M+ revenue per store with only 2 stores each.

## 📈 Business Impact

These findings support concrete decisions: prioritizing expansion capital toward India and Turkey, protecting inventory/launch timing for flagship products like the MacBook Pro M1, and triggering a root-cause review of UAE's warranty process before the issue scales.

## 📁 Repo Structure

```
├── README.md
├── sql/
│   └── apple_eda_analysis.sql       # 21 business questions, documented
├── images/
│   ├── 00-data-model.png
│   ├── 01-executive-overview.png
│   ├── 02-sales-analysis.png
│   ├── 03-warranty-risk.png
│   └── 04-store-performance.png
└── docs/
    ├── data-dictionary.md
    └── business-questions.md
```

## 🚀 What I'd Improve Next

- Add drill-through from Store Performance into store-level warranty trends.
- Build a 2024 revenue forecast measure using Power BI time intelligence.
- Add RLS (row-level security) for a regional-manager view of the dashboard.

---

**Author:** Sourabh Yadav · [LinkedIn](https://www.linkedin.com/in/sourabhyadav96) · [GitHub](https://github.com/sourabh0020)
