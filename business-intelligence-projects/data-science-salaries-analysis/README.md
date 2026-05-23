# Data Science Salaries Analysis
**Python · Pandas · NumPy · Matplotlib · Seaborn**

Analysis of salary trends in data-related careers using a dataset of 9,355 records spanning from 2020 to 2023.

The objective is to support data-driven hiring decisions by understanding salary distributions across job titles, experience levels, company sizes, work settings, and geographic regions.

---

## Stakeholder Objective

**Role:** Head of People & Talent — Technology Company

*"Before opening new positions, we need to understand the current salary landscape in the data industry. We want to know how compensation varies by experience level, role, company size, and work setting — and whether there is a significant salary gap between Latin America and North America. The goal is to define competitive salary ranges that allow us to attract talent without overpaying or losing candidates to better offers."*

---

## Business Questions

1. What job titles have the highest average salary?
2. Which job category pays the most and the least?
3. Do large companies pay more than small ones?
4. Which experience level earns the most?
5. Is there a salary gap between Latin America and North America?
6. Which country offers the best salaries?
7. How have salaries evolved over time (2020–2023)?
8. Does remote work pay more than in-person or hybrid?

---

## Dataset

- **Source:** Kaggle — Jobs and Salaries in Data Science
- **Records:** 9,355
- **Period:** 2020–2023
- **Key columns:** job_title, job_category, experience_level, salary_in_usd, work_setting, company_location, company_size, employee_residence

---

## Tools & Technologies

- **Python** — Pandas, NumPy, Matplotlib, Seaborn
- **Jupyter Notebook** — analysis and documentation
- **GitHub** — version control and portfolio

---

## Analysis Process

1. Loaded and explored the dataset — shape, data types, null values, statistical summary
2. Cleaned the data — removed duplicates, standardized column values
3. Created a region column to classify countries into Latin America, North America, and Other
4. Performed 8 analytical queries using groupby, aggregations, and filters
5. Built visualizations for each business question
6. Generated a key insights summary

---

## Key Business Insights

**1. Top Job Titles**
Director of Data Science leads with an average salary of $215,448/year, followed by Data Science Manager and Machine Learning Manager.

**2. Job Categories**
Machine Learning & AI is the highest paying category ($170,453 avg) while Data Quality & Operations is the lowest ($104,586 avg).

**3. Company Size**
Large companies pay $125,767 on average vs $90,849 at small companies — a 38% difference.

**4. Experience Level**
- Entry-level: $84,712
- Mid-level: $116,284
- Senior: $161,823
- Executive: $187,519

Salary grows 91% from Entry-level to Senior.

**5. Latin America vs North America**
North America pays 117% more than Latin America on average ($157,733 vs $72,474).
Note: LATAM sample is small (54 records) — interpret with caution.

**6. Top Country**
The United States leads with $157,722 average salary, followed by Australia ($121,808) and the United Kingdom ($107,913).

**7. Salary Evolution**
Overall average salaries grew 44.1% between 2020 and 2023, reflecting strong demand for data professionals across all experience levels.

**8. Work Setting**
Contrary to common assumptions, in-person roles have the highest average salary ($153,629) compared to remote ($141,493) and hybrid ($89,108). This is likely explained by the concentration of high-paying US-based companies requiring on-site presence.

---

## Project Structure

```
data-science-salaries-analysis/
├── README.md
├── data/
│   └── jobs_in_data.csv
├── src/
│   └── salary_analysis.py
└── images/
    ├── 01_top_job_titles.png
    ├── 02_salary_by_category.png
    ├── 03_salary_by_company_size.png
    ├── 04_salary_by_experience.png
    ├── 05_latam_vs_northamerica.png
    ├── 06_top_countries_salary.png
    ├── 07_salary_evolution.png
    └── 08_salary_by_work_setting.png
```

---

## Author

Facundo Mazzieri
📧 facundodantemazz@gmail.com
🔗 [LinkedIn](https://www.linkedin.com/in/facundo-mazzieri-achaval/)
📁 [Portfolio](https://github.com/FacundoMazzieri24/Facundomazzieri-portafolio)

*Aspiring Data Analyst focused on SQL, Power BI, and Python for data analysis.*

