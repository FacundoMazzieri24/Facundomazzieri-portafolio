# Data Jobs Market Analysis 2024 — LinkedIn Global Insights

![Python](https://img.shields.io/badge/Python-3.14-blue) ![PostgreSQL](https://img.shields.io/badge/SQL-PostgreSQL-336791) ![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811) ![ML](https://img.shields.io/badge/ML-Random%20Forest-brightgreen) ![SMOTE](https://img.shields.io/badge/SMOTE-Imbalanced--learn-orange)

End-to-end analysis of 12,211 real LinkedIn job postings from January 2024, combining SQL analysis from Python, skills co-occurrence mining, seniority classification with machine learning, and an executive Power BI dashboard.

---

## Dashboard Overview

![Dashboard Overview](images/overview.png)

---

## Stakeholder Objective

**Role:** Head of Talent — Global Data Consultancy

> *"I need to understand what technical tools are dominating the data job market in 2024. Our junior candidates don't know which technologies to invest their time in, and we as HR don't have clarity on what to ask candidates based on the role level. I want an analysis that tells me which tools are most in demand, whether they change based on seniority, and if there are differences between countries. With that I can build development guides for our analysts and improve our selection filters."*

---

## Business Questions

| # | Question |
|---|---|
| Q1 | What are the most in-demand skills globally? |
| Q2 | How do skills vary by seniority level? |
| Q3 | What roles are most in demand? |
| Q4 | How does work mode vary by country? |
| Q5 | What skills distinguish a Junior from a Senior? |
| Q6 | What skill combinations appear together most frequently? |
| Q7 | Which companies post the most data job listings? |

---

## Project Pipeline

```
Raw Data (CSV) — 3 tables | 12,211 job postings
        ↓
Python — Data cleaning, skill normalization, EDA, co-occurrence analysis, ML models
        ↓
PostgreSQL — Analytical queries, CTEs, window functions, self joins
        ↓
Power BI — Executive dashboard, DAX measures, Python visuals, 5 pages
```

---

## Tools & Technologies

| Phase | Tools |
|---|---|
| Data Analysis & ML | Python — Pandas, NumPy, Matplotlib, Seaborn, Scikit-learn, XGBoost, imbalanced-learn |
| Data Modeling & Queries | SQL — PostgreSQL, CTEs, Window Functions, Self Joins |
| Dashboard | Power BI — DAX, Python Visuals, 5-page interactive dashboard |

---

## Data Cleaning

- Merged 3 CSV files (`job_postings`, `job_skills`, `job_summary`) on `job_link`
- Dropped 7 internal scraping columns with no analytical value
- Normalized 6 null values across `job_location` and `job_skills`
- Renamed seniority levels: `Mid Senior` → `Senior`, `Associate` → `Junior`
- Lowercased and stripped all skill strings to eliminate case duplicates
- Applied alias mapping to unify 16 skill variants (e.g. `mysql`, `postgresql`, `tsql` → `sql`)
- Exploded skills from comma-separated strings into individual rows — 314,927 skill mentions total
- Created `job_title_clean` by removing seniority prefixes (Senior, Lead, Staff) for role-level analysis

---

## SQL Analysis

All queries written in PostgreSQL and executed from Python via SQLAlchemy.

**SQL techniques used:**
- CTEs for multi-step aggregations
- `DENSE_RANK() OVER` window functions for rankings
- `PARTITION BY` for per-group percentage calculations
- `CASE WHEN` for conditional aggregations
- `NULLIF` to prevent division by zero
- Self join for co-occurrence pair analysis
- `HAVING` clause for minimum frequency filtering

**7 analytical queries:**

```
Q1 — Top 20 most in-demand skills globally
Q2 — Top 10 skills by seniority level (% of postings)
Q3 — Top demanded roles by unique job postings
Q4 — Work mode distribution by country
Q5 — Skills that distinguish Junior from Senior (% concentration)
Q6 — Top 20 skill co-occurrence pairs (self join)
Q7 — Top 20 companies by job postings
```

---

## ML — Seniority Prediction

**Objective:** Predict whether a job posting is Junior or Senior based solely on required skills.

**Approach:** One-Hot Encoding of top 50 skills → Binary classification

**Challenge:** Extreme class imbalance — 89% Senior / 11% Junior

**Solution:** SMOTE (Synthetic Minority Oversampling Technique) — balanced dataset from 938 to 8,022 Junior samples

**Models compared:** Logistic Regression, Random Forest, XGBoost, SVM — with and without SMOTE

| Model | ROC-AUC | Recall Junior |
|---|---|---|
| LR without SMOTE | 0.646 | 0.60 |
| RF without SMOTE | 0.638 | 0.21 |
| XGBoost without SMOTE | 0.650 | 0.04 |
| LR with SMOTE | 0.608 | 0.48 |
| **RF with SMOTE** | **0.661** | **0.34** |
| XGBoost with SMOTE | 0.621 | 0.40 |
| SVM with SMOTE | 0.610 | 0.40 |
| RF Tuned with SMOTE | 0.660 | 0.34 |

**Winner: Random Forest + SMOTE — ROC-AUC: 0.661**

**Key insights:**
- Without SMOTE, all models ignored the Junior class almost completely
- SMOTE improved Junior recall from 0.21 to 0.34 in Random Forest
- GridSearchCV showed AUC 0.930 in cross-validation but 0.660 on test — evidence of overfitting caused by limited dataset size
- Skills alone do not fully determine seniority — experience, job title and company context are not captured in the data

---

## Key Business Insights

**Q1 — Global Demand**
SQL (5,571) and Python (4,809) are the most demanded technical skills. Communication (4,217) and Data Analysis (4,695) rank in the top 4, confirming the market values both technical and soft skills equally.

**Q2 — Seniority vs Skills**
Data Analysis is #1 in Junior (48.1%) but drops to #3 in Senior. AWS and Data Engineering appear exclusively in Senior top 10, while Power BI and Tableau are Junior-only tools in the top 10.

**Q3 — Role Demand**
The market is highly fragmented — the most demanded role (Data Engineer) represents only 5.3% of total postings. Data Analyst ranks #2, confirming stable demand for the profile.

**Q4 — Work Mode**
99.8% of postings are Onsite across all 4 countries. Remote work in data is practically nonexistent in this January 2024 snapshot — contradicting the popular narrative of remote-first data roles.

**Q5 — Junior vs Senior Skills**
Junior roles concentrate operational tools (Excel, Data Entry, MS SQL Server). Senior roles require infrastructure and engineering skills: PySpark, CI/CD, Data Lakes, MLflow — all above 95% Senior concentration.

**Q6 — Co-occurrence**
Python + SQL is the most demanded pair with 3,792 co-occurrences. Data Analysis acts as the central hub — it co-occurs with SQL (2,827), Python (2,143) and Data Visualization (2,071).

**Q7 — Companies**
The top 3 are recruiting intermediaries (Jobs for Humanity, Recruiting from Scratch, Dice). Among direct employers: Capital One (92), AWS (72), Deloitte (67) and Bank of America (49) lead.

---

## Business Recommendations

**For Junior candidates:**
- Prioritize SQL and Python — they appear in 42% and 31% of Junior postings respectively
- Power BI and Tableau are market-entry tools — mastering them increases immediate employability
- Soft skills (Communication, Collaboration) are as demanded as technical skills in Junior roles

**To advance to Senior:**
- Invest in AWS, Data Engineering and PySpark — the skills that most distinguish Senior profiles
- CI/CD and Data Lakes are almost exclusively Senior — learning them is the clearest path to leveling up
- A/B Testing (98.5% Senior) indicates that experiment design is a key Senior differentiator

**For recruiters:**
- The market is highly fragmented — no single role dominates
- Data Engineering outpaces Data Science in demand — factor this into team building
- 100% remote roles are extremely rare (0.2%) — set realistic expectations with candidates

---

## Project Structure

```
data-jobs-market-analysis/
├── README.md
├── .gitignore
├── data/
│   ├── raw/                        ← download the 3 CSVs from Kaggle (link below)
│   │   └── .gitkeep
│   └── clean/                      ← generated by the notebook
│       └── .gitkeep
├── python/
│   └── data_jobs_analysis.ipynb
├── powerbi/
│   └── data_jobs_dashboard.pbix
└── images/
    ├── overview.png                 ← Page 1: Global Overview
    ├── skills_analysis.png          ← Page 2: Skills Analysis & Co-occurrence
    ├── seniority.png                ← Page 3: Seniority Breakdown
    ├── market.png                   ← Page 4: Market Landscape
    └── ml_model.png                 ← Page 5: ML Model
```

---

## Data Source

**Dataset:** Data Science Job Postings & Skills (2024)  
**Source:** [Kaggle — asaniczka](https://www.kaggle.com/datasets/asaniczka/data-science-job-postings-and-skills)  
**Records:** 12,211 job postings | 3 tables | January 2024  
**Key tables:** job_postings, job_skills, job_summary  

> Download the 3 raw CSVs from Kaggle and place them in `data/raw/` before running the notebook:
> `job_postings.csv`, `job_skills.csv`, `job_summary.csv`

---

## Author

**Facundo Mazzieri**  
📧 facundodantemazz@gmail.com  
🔗 [LinkedIn](https://linkedin.com/in/facundo-mazzieri-achaval)  
🐙 [GitHub Portfolio](https://github.com/FacundoMazzieri24/Facundomazzieri-portafolio)

