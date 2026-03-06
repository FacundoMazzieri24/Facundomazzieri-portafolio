# E-Commerce Financial Performance Analysis (2022–2024)

SQL • Power BI • Data Modeling • DAX • Business Analysis

This project analyzes the financial performance of an ecommerce business between **2022 and 2024**.  
The objective is to understand revenue growth, profitability trends, and product performance in order to support **data-driven strategic decisions**.

The analysis combines **SQL for data exploration and transformation** and **Power BI for data visualization**.

---

# Project Overview

The goal of this project is to analyze how the business evolved over the last three years and identify the key drivers of **sales, profit, and profitability margins**.

The dashboard focuses on:

- Sales and profit performance
- Regional profitability
- Product-level contribution
- Category performance
- Correlation between sales and profit
- Year-over-year trends

This project simulates a real **business request from a Commercial Director** who needs an executive dashboard to support strategic decisions.

---

# Stakeholder Objective

**Role:** Commercial Director

> “We need to understand how the business has evolved over the past three years.

> We want to identify which products and regions are driving growth, which ones are affecting profitability, and where we should focus strategic decisions for 2025.

> We are interested in analyzing revenue, profit, and margins, identifying temporal trends, and understanding the product mix and regional performance.

> The goal is to build an executive dashboard that allows us to monitor the business and support data-driven decisions.”

---

# Analytical Questions

1. What products generated the highest cumulative profit between **2022 and 2024**?

2. Which regions contributed the **most and least** to total profit during the period?

3. Which category concentrates the **highest sales volume**, and which one presents the **highest average profit margin**?

4. How do **sales and profit evolve month-to-month** across regions between 2022 and 2024?

5. What are the **Top 3 products by region based on profit**, and what share do they represent of the region's total profit?

6. Is there a **correlation between Sales and Profit**?

7. Which products generate **high sales volume but low profit margins**?

8. What is the **year-over-year (YoY) growth rate** for Sales and Profit?

---

# Data Model

The original dataset (`raw_sales1`) was normalized using SQL to create a **star schema model**, improving query performance and enabling analytical reporting.

The model separates **transactional data (fact table)** from **descriptive attributes (dimension tables)**.

### Raw Table

**raw_sales1**

- Order Date
- Product Name
- category
- region
- quantity
- sales
- profit

This table represents the **original transactional dataset before normalization**.

---

### Fact Table

**fact_sales**

- order_id
- date
- product_id
- region_id
- quantity
- sales
- profit

This table stores the **transaction-level metrics** used for analysis.

---

### Dimension Tables

**dim_product**

- product_id
- Product Name
- category

**dim_region**

- region_id
- region

**dim_date**

- date
- year
- month
- quarter

---

### Power BI Calendar Table

Inside Power BI, an additional **calendar table (TB_Calendario)** was created using DAX to support **time intelligence calculations** such as Year-over-Year growth.

This table enables:

- YoY calculations
- monthly trend analysis
- proper time filtering across visuals

The final model therefore combines:

- **SQL star schema (data layer)**
- **Power BI semantic model with DAX measures (analytics layer)**

---

# SQL Analysis

SQL was used to perform exploratory analysis and answer key business questions.

Key techniques used:

- **Common Table Expressions (CTE)**
- **Window Functions**
- Aggregations for sales and profit metrics
- Product ranking by profit
- Profit share calculations
- Regional performance analysis

Examples of analysis performed:

- Ranking products by cumulative profit
- Calculating profit contribution by region
- Identifying products with high sales but low margin
- Computing top products within each region

All queries are documented in the SQL file.

---

# Power BI Dashboard

The dashboard was built to provide an **executive-level overview of financial performance**.

It includes **four analytical pages**:

### 1. Financial Overview
- Total Revenue
- Total Profit
- Sales Growth (YoY)
- Profit Growth (YoY)
- Profit Margin %
- Monthly Sales and Profit Performance
- Profit distribution by region

### 2. Product Performance
- Top 3 products by region based on profit
- Profit share contribution
- Products generate the highest cumulative profit between 2022 and 2024

### 3. Profitability Analysis
- Sales vs Profit Relationship
- Identification of high-sales low-margin products
- Sales Performance by Category

### 4. Trends Analysis
- Year-over-year evolution of Sales and Profit
- Monthly trends across multiple years

The dashboard allows filtering by **year and region** to explore performance across different business segments.

---

# Key Business Insights

**Regional Performance**
- The **West region generates the highest total profit**, making it the most important contributor to overall business performance.

**Product Performance**
- **Camera and Monitor generate the highest cumulative profit**, positioning them as the main drivers of profitability.
- **Keyboards, Headphones, and Tablets generate the lowest total profit**, suggesting potential issues related to pricing, demand, or cost structure.

**Category Performance**
- The **Electronics category leads both in total sales volume and profit margin**, making it the most profitable category overall.
- The **Office category records the lowest sales volume and the lowest profit margin**, indicating a limited contribution to overall profitability.

**Business Trend (2022–2024)**
- **Sales and profit increased in 2023 compared to 2022**, showing a period of business expansion.
- **In 2024, both metrics decline significantly**, indicating a slowdown in overall performance.
- **Profit margins decreased from 18.69% in 2022 to 16.49% in 2024**, suggesting increasing costs or pricing pressure over time.

---

# Project Structure

E-Commerce-Financial-Performance Analysis/
│
├── data/
│   └── dataset.csv
│
├── sql/
│   └── ecommerce_analysis.sql
│
├── powerbi/
│   └── ecommerce_dashboard.pbix
│
├── dashboard/
│   └── ecommerce_dashboard.pdf
│
├── images/
│   ├── overview.png
│   ├── products.png
│   ├── profitability.png
│   └── trends.png
│
└── README.md

---

# Tools Used

- **SQL**
- **Power BI**
- **DAX**
- **Excel / CSV data source**

---

# Skills Demonstrated

- Data cleaning and transformation
- SQL analytical queries
- Window functions and ranking
- Business KPI development
- Data modeling for BI
- Dashboard design for executive decision-making
- Business insight generation

---

# Author

**Facundo**  
Aspiring Data Analyst focused on **SQL, Power BI, and Python for data analysis**.

