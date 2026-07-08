# Data Dictionary

## `category`
| Column | Type | Description |
|---|---|---|
| category_id | varchar | Unique category ID (CAT-1 … CAT-10) |
| category_name | varchar | e.g. Smartphone, Laptop, Tablet, Wearable |

## `products`
| Column | Type | Description |
|---|---|---|
| product_id | varchar | Unique product ID (64 distinct products) |
| product_name | varchar | e.g. iPhone 14 Pro, MacBook Pro M1 Max 16" |
| category_id | varchar | FK → category |
| launch_date | date | Product launch date |
| price | decimal | Unit price (USD) |

## `sales`
| Column | Type | Description |
|---|---|---|
| sale_id | varchar | Unique transaction ID (~1.04M rows) |
| sale_date | date | Date of sale |
| store_id | varchar | FK → stores |
| product_id | varchar | FK → products |
| quantity | int | Units sold in the transaction |

## `stores`
| Column | Type | Description |
|---|---|---|
| store_id | varchar | Unique store ID (73 stores) |
| store_name | varchar | e.g. Apple South Coast Plaza |
| city | varchar | Store city |
| country | varchar | Store country (35 countries) |

## `warranty`
| Column | Type | Description |
|---|---|---|
| claim_id | varchar | Unique claim ID (30,836 claims) |
| claim_date | date | Date claim was filed |
| sale_id | varchar | FK → sales |
| repair_status | varchar | Free Replaced / Paid Repaired / Warranty Void |

## Relationships
`sales` is the fact table, joined to `products` (many-to-one), `stores` (many-to-one), and `warranty` (one-to-one/many via `sale_id`). `products` joins to `category`. A standalone `Datetable` supports Power BI time-intelligence measures.
