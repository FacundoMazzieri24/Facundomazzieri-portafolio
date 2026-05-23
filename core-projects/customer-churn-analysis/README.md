# Customer Churn Analysis & Prediction
**Python · SQL (PostgreSQL) · Power BI · Machine Learning**

End-to-end churn analysis for a telecommunications company, combining exploratory data analysis, SQL data modeling, predictive machine learning, and executive dashboard development.

---

##  Stakeholder Objective

**Role:** Director of Customer Retention — Telecommunications Company

> *"We are losing customers and need to understand why. We have data on 7,000+ customers — their contracts, services, billing, and whether they churned or not. I need to identify which customer profiles have the highest probability of leaving, what factors are most associated with churn, and what concrete actions we can take to retain them before they leave. Every customer we lose represents revenue that doesn't come back."*

---

##  Business Questions

1. What customers have the highest probability of churning?
2. What combination of factors maximizes churn risk?
3. Does payment method have a relationship with churn?
4. Does churn relate to gender or senior citizens?
5. Do customers who pay more have a higher churn probability?
6. Does paperless billing relate to churn?
7. Do contracted services impact churn?
8. Do customers with more tenure have lower churn rates?
9. What is the estimated cost of churn in lost revenue?
10. What is the risk segmentation per customer to prioritize retention?

---

##  Dataset

- **Source:** Kaggle — Telco Customer Churn (IBM)
- **Records:** 7,043 customers
- **Columns:** 21
- **Key fields:** tenure, contract type, payment method, internet service, monthly charges, total charges, churn

---

##  Tools & Technologies

| Phase | Tools |
|---|---|
| Data Analysis & ML | Python — Pandas, NumPy, Matplotlib, Seaborn, Scikit-learn |
| Data Modeling & Queries | SQL — PostgreSQL, Star Schema, CTEs, Window Functions |
| Dashboard | Power BI — DAX, Power Query, Decomposition Tree |

---

##  Project Pipeline

```
Raw Data (CSV)
      ↓
Python — Data cleaning, EDA, visualizations, ML model
      ↓
PostgreSQL — Star schema modeling, analytical queries, views
      ↓
Power BI — Executive dashboard, KPIs, interactive visuals
```

---

##  Data Cleaning

- Converted `TotalCharges` from string to numeric (spaces replaced with nulls)
- Imputed 11 null values with 0 — customers with `tenure = 0` had no accumulated charges (business logic, not deletion)
- Encoded `Churn` column: Yes → 1, No → 0
- Removed duplicate records

---

##  SQL Data Model — Star Schema

```
fact_churn (customerid, tenure, monthlycharges, totalcharges, churn, risklevel)
    ├── dim_customer (customerid, gender, seniorcitizen, partner, dependents)
    ├── dim_contract (customerid, contract, paperlessbilling, paymentmethod)
    └── dim_services (customerid, phoneservice, multiplelines, internetservice,
                      onlinesecurity, onlinebackup, deviceprotection,
                      techsupport, streamingtv, streamingmovies)
```

**SQL techniques used:**
- Star schema normalization from flat CSV
- CTEs and aggregations for KPI calculation
- UNION ALL for multi-service analysis
- Window functions — ROW_NUMBER() OVER (PARTITION BY risklevel)
- FILTER clause for conditional aggregations
- SQL Views for Power BI integration

---

##  Machine Learning — Logistic Regression

**Model:** Logistic Regression (Scikit-learn)
**Train/Test split:** 80% / 20%

| Metric | Score |
|---|---|
| Accuracy | 81% |
| ROC-AUC | 0.86 |
| Churn Recall | 55% |
| Precision (Churn) | 68% |

**Top predictive features:** tenure, TotalCharges, Contract type, InternetService Fiber optic, OnlineSecurity, TechSupport, PaperlessBilling, PaymentMethod Electronic check

---

##  Key Business Insights

**1. Overall Churn Rate**
26.54% of customers churned — 1,869 out of 7,043 customers lost.

**2. Contract Type**
Month-to-month contracts drive 43% churn vs 3% for two-year contracts — a 14x difference.

**3. Payment Method**
Electronic check customers churn at 45% — more than double other payment methods. Root cause investigation recommended around UX friction points.

**4. Senior Citizens**
Senior customers churn at 41.68% vs 23.60% for non-seniors — nearly double the rate.

**5. Services**
Customers without OnlineSecurity and TechSupport churn ~41% vs ~15% for those who have them. StreamingTV (30.1%), StreamingMovies (29.9%) and MultipleLines (28.6%) show the highest churn among contracted services.

**6. Internet Service**
Fiber optic customers churn at 42% — more than double DSL users (19%).

**7. Tenure**
Churn drops from 61.9% in month 1 to 1.65% by month 72. The first 12 months are the critical retention window.

**8. Revenue Lost**
- Monthly revenue lost: **$139,131**
- Annual revenue lost: **$1,669,570**

**9. Risk Segmentation**

| Segment | Customers | Churn Rate | Annual Revenue Lost |
|---|---|---|---|
| High Risk | 1,908 | 51.94% | $991K |
| Medium Risk | 823 | 37.79% | $311K |
| Low Risk | 4,312 | 13.15% | $586K |

**10. Highest Risk Combination**
High Risk + Month-to-month + Electronic check = **63.90% churn probability**

---

##  Project Structure

```
customer-churn-analysis/
├── README.md
├── data/
│   └── WA_Fn-UseC_-Telco-Customer-Churn.csv
├── notebook/
│   └── churn_analysis.ipynb
├── sql/
│   └── churn_queries.sql
├── powerbi/
│   └── churn_dashboard.pbix
└── images/
    ├── overview.png
    ├── service_analysis.png
    ├── customer_analysis.png
    └── risk_segmentation.png
```

---

##  Business Recommendations

**1. Focus retention on the first 12 months**
Churn drops from 61.9% in month 1 to under 20% after month 24. Design an onboarding program with incentives, proactive support, and check-ins during the first year.

**2. Incentivize long-term contracts**
Month-to-month customers churn at 43% vs 3% for two-year contracts. Offer discounts or exclusive benefits to customers who switch to annual or two-year plans.

**3. Investigate Electronic Check experience**
Electronic check customers churn at 45% — more than double other methods. Conduct UX research to identify friction points in the payment experience before making changes.

**4. Promote OnlineSecurity and TechSupport**
Customers with these services churn at ~15% vs ~41% without them. Bundle or promote these services during onboarding to increase customer stickiness.

**5. Design a Senior Citizens retention program**
Senior customers churn at 41.68% — nearly double the average. Develop targeted plans with simplified pricing, dedicated support, or senior-specific benefits.

**6. Monitor Low Risk segment**
Despite a 13% churn rate, Low Risk customers generate $586K in annual revenue loss due to their large base. Monitor this segment to prevent silent churn.

---

## Author

Facundo Mazzieri
📧 facundodantemazz@gmail.com
🔗 [LinkedIn](https://www.linkedin.com/in/facundo-mazzieri-achaval/)
📁 [Portfolio](https://github.com/FacundoMazzieri24/Facundomazzieri-portafolio)

*Junior Data Analyst focused on SQL, Power BI, Python, and Machine Learning for data-driven business decisions.*
