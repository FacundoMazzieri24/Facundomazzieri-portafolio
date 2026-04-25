# Olist Brazilian E-Commerce Analysis

![Python](https://img.shields.io/badge/Python-3.14-blue) ![PostgreSQL](https://img.shields.io/badge/SQL-PostgreSQL-336791) ![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811) ![ML](https://img.shields.io/badge/ML-Random%20Forest-brightgreen)

End-to-end analysis of 100,000 real Brazilian e-commerce orders, combining exploratory data analysis, SQL data modeling, predictive machine learning, and executive dashboard development.

---

## Dashboard Overview

![Dashboard Overview](images/overview.png)

---

## Stakeholder Objective

**Role:** Chief Revenue Officer — Olist

> *"We have 100,000 real orders between 2016 and 2018 and I need to understand why our business grows in some areas and stalls in others. Customers buy once and don't return. Sellers are highly uneven — some destroy the platform's reputation with late deliveries and bad reviews. Logistics is costing us money and customers. Every lost order, every unsatisfied customer, and every bad seller has a cost. Give me the numbers."*

---

## Business Questions

| # | Question |
|---|---|
| Q1 | What are the characteristics of repeat customers and what value do they generate vs one-time buyers? |
| Q2 | Does seller performance relate to late deliveries? |
| Q3 | Does seller performance relate to bad reviews? |
| Q4 | Do high-price products generate more total revenue despite selling fewer units? |
| Q5 | Does geolocation relate to review scores and revenue? |
| Q6 | Which categories have the lowest revenue and worst reviews? |
| Q7 | Which payment methods are associated with higher order values and better reviews? |
| Q8 | How did customers and total revenue evolve from 2016 to 2018? |
| Q9 | Do late deliveries affect one-time buyers? |

---

## Project Pipeline

```
Raw Data (CSV) — 9 tables | 99,441 orders
        ↓
Python — Data cleaning, EDA, feature engineering, Random Forest ML model
        ↓
PostgreSQL — Analytical queries, CTEs, window functions, 8 views
        ↓
Power BI — Executive dashboard, DAX measures, Python visual, 5 pages
```

---

## Tools & Technologies

| Phase | Tools |
|---|---|
| Data Analysis & ML | Python — Pandas, NumPy, Matplotlib, Seaborn, Scikit-learn |
| Data Modeling & Queries | SQL — PostgreSQL, CTEs, Window Functions, Views |
| Dashboard | Power BI — DAX, Python Visual, Azure Maps, Decomposition Tree |

---

## Data Cleaning

- Parsed timestamps across 6 date columns from raw text
- Created `delivery_delay_days` — difference between actual and estimated delivery date
- Created `is_late` boolean flag — orders where actual delivery exceeded estimated date
- Aggregated payments by `order_id` before joining with items to avoid revenue inflation
- Translated product category names from Portuguese to English via `category_translation` table
- Filtered sellers with fewer than 10 orders to ensure statistically reliable performance metrics

---

## SQL Data Model

No traditional star schema — business logic lives in SQL views, Power BI handles visualization only.

**8 analytical views created:**

```
vw_monthly_evolution       — Q8: Revenue, orders and customers by month
vw_late_delivery_impact    — Q9: Late deliveries impact by customer segment
vw_customer_segments       — Q1: One-time vs repeat customer analysis
vw_seller_performance      — Q2/Q3: Late delivery rate and review score by seller
vw_product_performance     — Q4: Avg price, revenue and units sold by category
vw_geo_analysis            — Q5: Review score and revenue by customer state
vw_category_performance    — Q6: Revenue and review score by category
vw_payment_analysis        — Q7: Order value and reviews by payment method
```

**SQL techniques used:**
- CTEs for multi-step aggregations
- Window functions — `DENSE_RANK() OVER`
- `LEFT JOIN` for nullable review data
- Pre-aggregation pattern to avoid revenue inflation in multi-item orders
- Boolean casting for late delivery flag

---

## ML — Review Score Prediction (Random Forest)

**Model:** Random Forest Classifier — multiclass (Positive / Regular / Negative)  
**Train/Test Split:** 80% / 20%  
**Features:** 7 — `payment_value`, `price`, `freight_value`, `delivery_delay_days`, `product_category`, `payment_installments`, `is_late`

| Class | Precision | Recall | F1-Score |
|---|---|---|---|
| Positive (4-5) | 89% | 98% | 93% |
| Regular (3) | 88% | 46% | 60% |
| Negative (1-2) | 91% | 78% | 84% |
| **Overall Accuracy** | | | **89%** |

**Key insights:**
- `payment_value` is the strongest predictor — customers who pay more expect a better experience
- Negative reviews detected with 91% precision and 78% recall — model catches 8 in 10 bad experiences
- Regular (score 3) is the hardest class to predict — genuinely ambiguous customer sentiment
- Model can be used to flag high-risk orders for proactive customer support intervention

---

## Key Business Insights

**Q1 — Customer Retention**  
97% of customers buy only once, generating $15M in total revenue. Repeat buyers (3.12%) generate 2x more revenue per customer — retention is the highest-leverage opportunity on the platform.

**Q2 & Q3 — Seller Performance**  
The average seller maintains a 4.07 review score with a 6% late delivery rate — platform performance is healthy overall. However, 0.71% of sellers exceed the 30% late delivery threshold and their impact on satisfaction is disproportionate.

**Q4 — Price vs Revenue**  
High-price categories do not always generate higher total revenue. Volume drives more value — mid-price, high-volume categories outperform premium low-volume ones.

**Q5 — Geographic Risk**  
States in the North and Northeast show the lowest review scores — Roraima leads with 3.61 avg review score despite moderate revenue. High-risk states concentrate customers most likely to churn after a single purchase.

**Q6 — Category Performance**  
Office furniture (3.49), fashion male clothing (3.64) and fixed telephony (3.68) are the worst-reviewed categories. Tablets & printing image and cine photo generate the lowest revenue.

**Q7 — Payment Methods**  
Credit card dominates with 73% of total revenue ($12.4M). Boleto accounts for 17.92% ($2.85M). Credit card users correlate with higher avg order values.

**Q8 — Business Growth**  
Revenue grew from $60K in 2016 to $8.8M in 2018 — a 146x increase in two years, driven by a rapid expansion in monthly orders and unique customers.

**Q9 — Late Deliveries & Churn**  
Repeat customers experience 0.12 avg late deliveries vs 0.07 for one-time buyers — suggesting that late deliveries are a factor in preventing second purchases.

---

## Business Recommendations

1. **Implement a loyalty program targeting one-time buyers** — they represent 97% of customers but generate less revenue per head. A re-engagement campaign within 30 days of first purchase could significantly increase repeat rate.

2. **Create a seller certification program** rewarding top performers (low late rate + high review score) and flagging sellers whose late delivery rate exceeds 15% for intervention.

3. **Prioritize logistics investment in high-risk states** — North and Northeast Brazil show the lowest satisfaction scores. Faster shipping agreements or regional warehousing could improve retention in these markets.

4. **Partner with better suppliers in underperforming categories** — office furniture and fixed telephony consistently underperform on reviews. Evaluate supplier quality before removing categories entirely.

5. **Promote installment payment options** to increase avg order value — credit card installments correlate with higher-value purchases and better reviews.

6. **Create an early warning system** flagging sellers whose late delivery rate exceeds 15% — intervene before they reach the 30% High Risk threshold.

---

## Project Structure

```
olist-ecommerce-analysis/
├── README.md
├── .gitignore
├── data/
│   ├── raw/          ← download from Kaggle (link below)
│   └── clean/        ← generated by the notebook
├── sql/
│   ├── setup/
│   │   ├── orders.sql
│   │   ├── customers.sql
│   │   ├── items.sql
│   │   ├── payments.sql
│   │   ├── reviews.sql
│   │   ├── products.sql
│   │   ├── sellers.sql
│   │   ├── geolocation.sql
│   │   └── category_translation.sql
│   ├── 01_analytical_queries.sql
│   └── 02_views.sql
├── python/
│   └── olist_analysis.ipynb
├── powerbi/
│   └── olist_dashboard.pbix
└── images/
    └── overview.png
```

---

## Data Source

**Dataset:** Olist Brazilian E-Commerce Public Dataset  
**Source:** [Kaggle — Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)  
**Records:** 99,441 orders | 9 tables | 2016–2018  
**Key tables:** orders, customers, order_items, payments, reviews, products, sellers, geolocation, category_translation

> Download the raw CSVs from Kaggle and place them in `data/raw/` before running the notebook.

---

## Author

**Facundo Mazzieri**  
📧 facundodantemazz@gmail.com  
🔗 [LinkedIn](https://linkedin.com/in/facundo-mazzieri-achaval)  
📁 [Portfolio](https://github.com/FacundoMazzieri24/Facundomazzieri-portafolio)

*Junior Data Analyst focused on SQL, Power BI, Python, and Machine Learning for data-driven business decisions.*
