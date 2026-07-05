# Data Analytics Portfolio — Facundo Mazzieri
Welcome! This repository contains my data analytics portfolio, showcasing projects developed using SQL, Power BI, Python, Machine Learning, Data Modeling, and Business Analysis.

The goal of this portfolio is to demonstrate my technical skills, analytical thinking, and business-oriented approach through real-world datasets and end-to-end analyses.

## About Me
I'm Facundo Mazzieri, a Marketing student with a strong focus on Data Analytics and Business Intelligence.

I specialize in transforming raw datasets into actionable business insights through structured analysis, data modeling, and interactive dashboards.

**Technical skills:**

- SQL (PostgreSQL, MySQL, BigQuery) — CTEs, Window Functions, Star Schema
- Power BI — DAX measures, Power Query, Time Intelligence, Dashboard Design
- Data Modeling — Star Schema, Fact & Dimension Tables, ETL concepts
- Python — Pandas, NumPy, Matplotlib, Seaborn, Scikit-learn
- Machine Learning — Logistic Regression, Random Forest, XGBoost, SVM, SMOTE, Classification, ROC-AUC
- Business Analytics — KPI definition (CTR, ROI, CAC), EDA, Data Storytelling
- Excel / Google Sheets
- Automation & AI Agents — n8n, LLM APIs (Google Gemini), Prompt Engineering, Web Scraping, API Integrations (Gmail, Google Sheets)

📍 Córdoba, Argentina &nbsp; 📧 facundodantemazz@gmail.com &nbsp; 🔗 [LinkedIn](https://linkedin.com/in/facundo-mazzieri-achaval)

---

## 🚀 Advanced Projects
*High-complexity projects integrating multiple technologies, advanced data modeling, and predictive insights.*

---
### 🤖 AI Sales Prospecting Automation — n8n · Python · LLM (Gemini) · Web Scraping · Gmail API
Tools: n8n · Python · Google Sheets API · Google Gemini (LLM) · Gmail API · Web Scraping

End-to-end automation agent that identifies target companies, scrapes and analyzes their websites, and generates personalized B2B sales emails using generative AI — dynamically adapting language based on the target market.

- Built a full pipeline: data validation → web scraping → text extraction → AI copywriting → automated email delivery → logging
- Designed a single LLM prompt that autonomously decides output language (Spanish/English) based on company location, with no additional branching logic
- Implemented idempotency control to prevent duplicate outreach, tracking sent status directly in the source spreadsheet
- Solved real-world scraping challenges: anti-bot protection, oversized HTML causing memory failures, and JavaScript-rendered pages returning empty content
- Tested against real companies across 3 countries (Argentina, Spain, United States) and multiple industries (retail, industrial engineering, technology)

📁 [View Project](https://github.com/FacundoMazzieri24/Facundomazzieri-portafolio/tree/main/advanced-projects/ai-sales-prospecting-automation)


### 📊 Data Jobs Market Analysis 2024 — Python · SQL · Power BI · Machine Learning
**Tools:** Python · SQL (PostgreSQL) · Power BI · Scikit-learn · XGBoost · SMOTE · 3 tables · 12,211 job postings

End-to-end analysis of real LinkedIn job postings from January 2024. Combines SQL executed from Python via SQLAlchemy, skills co-occurrence mining, seniority classification with 4 ML models, and a 5-page executive Power BI dashboard.

- Analyzed 314,927 skill mentions across 12,211 job postings to identify the most in-demand tools globally
- Built a self-join SQL query to mine skill co-occurrence pairs — Python + SQL leads with **3,792 co-occurrences**
- Compared **4 ML models** (Logistic Regression, Random Forest, XGBoost, SVM) with and without SMOTE to predict job seniority
- Applied SMOTE to address extreme class imbalance (89% Senior / 11% Junior), improving Junior recall from **0.21 to 0.34**
- Discovered that **99.8% of data job postings are Onsite** — contradicting the narrative of remote-first data roles

📁 [View Project](https://github.com/FacundoMazzieri24/Facundomazzieri-portafolio/tree/main/advanced-projects/data-jobs-market-analysis)

---

### 🛒 Olist Brazilian E-Commerce Analysis — Python · SQL · Power BI · Machine Learning
**Tools:** Python · SQL (PostgreSQL) · Power BI · Scikit-learn · 9 tables · 99,441 orders

End-to-end analysis of real Brazilian e-commerce orders for a CRO stakeholder. Combines exploratory data analysis, 8 PostgreSQL analytical views, predictive machine learning, and a 5-page executive dashboard.

- Built an end-to-end analytical pipeline across 9 business questions using Python, PostgreSQL, and Power BI
- Designed 8 PostgreSQL analytical views using CTEs and window functions, integrated directly into Power BI
- Developed a Random Forest multiclass model achieving **89% accuracy** to predict customer review scores
- Identified that **97% of customers buy only once**, while repeat buyers generate **2x more revenue per customer**
- Discovered revenue grew **146x between 2016 and 2018**, from $60K to $8.8M

📁 [View Project](https://github.com/FacundoMazzieri24/Facundomazzieri-portafolio/tree/main/advanced-projects/olist-ecommerce-analysis)

---

## 💡 Core Projects
*Projects focused on deep relational database queries, business metrics (KPIs), and customer behavior analysis.*

---

### 📉 Customer Churn Analysis & Prediction — Python · SQL · Power BI · Machine Learning
**Tools:** Python · SQL (PostgreSQL) · Power BI · Scikit-learn · Star Schema

End-to-end churn analysis for a telecommunications company. Combines exploratory data analysis, SQL data modeling, predictive machine learning, and executive dashboard development across 7,043 customer records.

- Built a star schema in PostgreSQL with fact and dimension tables from a flat CSV dataset
- Developed a Logistic Regression model achieving **81% accuracy** and **0.86 ROC-AUC** score
- Identified that High Risk + Month-to-month + Electronic check = **63.9% churn probability**
- Estimated **$1.67M in annual revenue lost** to churn across 1,869 customers

📁 [View Project](https://github.com/FacundoMazzieri24/Facundomazzieri-portafolio/tree/main/core-projects/customer-churn-analysis)

---

### 🛒 E-Commerce Financial Performance Analysis — SQL + Power BI
**Tools:** SQL (PostgreSQL) · Power BI · DAX · Data Modeling (Star Schema)

Analysis of ecommerce financial performance between 2022 and 2024. Includes revenue and profit trends, regional profitability, product performance, and YoY growth analysis.

- Designed a star schema data model from a raw dataset using SQL normalization
- Built analytical queries using CTEs and window functions
- Developed an executive Power BI dashboard with Sales, Profit, Margin %, and YoY KPIs
- Identified declining profit margins (18.69% → 16.49%) and top-performing product categories

📁 [View Project](https://github.com/FacundoMazzieri24/Facundomazzieri-portafolio/tree/main/core-projects/E-Commerce%20Financial%20Performance%20Analysis)

---

## 📈 Business Intelligence & Applied Analytics
*Interactive dashboards and targeted queries designed for fast-paced corporate decision making and department-specific KPIs.*

---

### 💼 Data Science Salaries Analysis — Python
**Tools:** Python · Pandas · NumPy · Matplotlib · Seaborn

Analysis of salary trends in data-related careers using 9,355 records from 2020 to 2023.

- Analyzed salary distribution across 15+ job titles and 10+ job categories
- Identified a **117% salary gap** between Latin America and North America
- Found that salaries grew **44.1%** overall between 2020 and 2023
- Discovered that in-person roles pay more than remote on average — contrary to common assumptions

📁 [View Project](https://github.com/FacundoMazzieri24/Facundomazzieri-portafolio/tree/main/business-intelligence-projects/data-science-salaries-analysis)

---

### 📣 Marketing Campaign Performance Analysis — SQL + Power BI
**Tools:** SQL (PostgreSQL) · Power BI · DAX

Analysis of marketing campaign performance across companies, channels, and customer segments.

- Calculated key KPIs: CTR, ROI, and Customer Acquisition Cost (CAC)
- Identified high-performing campaigns and inefficient marketing spend
- Analyzed performance by channel, customer segment, language, and geography

📁 [View Project](https://github.com/FacundoMazzieri24/Facundomazzieri-portafolio/tree/main/business-intelligence-projects/marketing-campaign-performance)

---

### 📊 Sales Performance Analysis — SQL + Power BI
**Tools:** SQL · Power BI · Kaggle Dataset

Business-oriented sales analysis focused on time-based trends, city performance ranking, and seasonality detection.

- Analyzed sales evolution over time and identified seasonal patterns
- Ranked cities by sales volume and detected regional performance gaps
- Developed data-driven recommendations for marketing and inventory planning

📁 [View Project](https://github.com/FacundoMazzieri24/Facundomazzieri-portafolio/tree/main/business-intelligence-projects/sales-performance-analysis)

---

### 🍜 Naruto Episodes Analysis — SQL + Power BI
**Tools:** SQL · Power BI · Personal interest project

Exploratory analysis of Naruto episode ratings to compare canon vs filler episodes, evaluate saga performance, and analyze rating trends over time.

📁 [View Project](https://github.com/FacundoMazzieri24/Facundomazzieri-portafolio/tree/main/business-intelligence-projects/naruto-episodes-analysis)

---

## 🛠️ Foundations Projects
*Foundational projects documented in Spanish, focused on learning core concepts: data cleaning, KPI definition, exploratory analysis, and basic dashboard development. Included to show learning progression.*

| Project | Tools | Focus |
|---|---|---|
| Proyecto1_Videojuegos | Excel + Power BI | Platform & genre sales analysis |
| proyecto_2_appol | Excel + Power BI | Product profitability & regional comparison |
| Proyecto 3_finanzas | Excel + Power BI | Personal finance KPIs & monthly trends |
| Proyecto 4 SQL ventas | SQL + Power BI | Foundational SQL sales analysis |
| Proyecto 5_lechuga | Excel + Power BI | Google Certificate methodology (SMART, SOW, EDA) |

---

## Skills Demonstrated

- Data cleaning and transformation (ETL)
- SQL querying — aggregations, CTEs, window functions, views, self joins
- Data modeling — Star Schema, fact & dimension tables
- DAX measures and time intelligence (YoY, MoM)
- Dashboard design and data storytelling
- KPI definition, segmentation, and business insight generation
- Python — Pandas, NumPy, Matplotlib, Seaborn
- Machine Learning — Logistic Regression, Random Forest, XGBoost, SVM, SMOTE, classification metrics, ROC-AUC
- Workflow automation & AI agent orchestration (n8n)
- LLM prompt engineering for automated content generation and dynamic language localization
- Web scraping and HTML/text extraction from real-world, unstructured sources
- API integrations (Google Sheets, Gmail, Google Gemini)
- Idempotent pipeline design and production-style error handling (rate limits, memory constraints, anti-bot protections)
---

*Portfolio actively updated. New projects added as skills develop.*
---

*Portfolio actively updated. New projects added as skills develop.*
