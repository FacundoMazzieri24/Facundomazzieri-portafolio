import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as mticker
import seaborn as sns
import warnings
warnings.filterwarnings('ignore')

# =====================================================
# DATA SCIENCE SALARIES ANALYSIS
# =====================================================
# Author: Facundo Mazzieri
# Tools: Python · Pandas · NumPy · Matplotlib · Seaborn
#
# Stakeholder: Head of People & Talent
# Objective: Understand salary trends in data-related
# careers to define competitive salary ranges and
# support data-driven hiring decisions.
#
# Business Questions:
# 1. What job titles have the highest average salary?
# 2. Which job category pays the most / least?
# 3. Do large companies pay more than small ones?
# 4. Which experience level earns the most?
# 5. Is there a salary gap between LATAM and North America?
# 6. Which country offers the best salaries?
# 7. How have salaries evolved over time?
# 8. Does remote work pay more than in-person or hybrid?
# =====================================================


# =====================================================
# SECTION 1: LOAD & EXPLORE DATASET
# =====================================================

df = pd.read_csv("jobs_in_data.csv")

print("=== DATASET INFO ===")
print(f"Rows: {df.shape[0]} | Columns: {df.shape[1]}")
print("\nColumn types:")
print(df.dtypes)
print("\nNull values:")
print(df.isnull().sum())
print("\nStatistical summary:")
print(df['salary_in_usd'].describe())


# =====================================================
# SECTION 2: DATA CLEANING & PREPARATION
# =====================================================

# No null values found - dataset is clean
# Remove duplicates
df = df.drop_duplicates()
print(f"\nRows after removing duplicates: {df.shape[0]}")

# Standardize experience level order for visualizations
experience_order = ['Entry-level', 'Mid-level', 'Senior', 'Executive']

# Define LATAM and North America country groups
latam_countries = ['Brazil', 'Colombia', 'Mexico', 'Argentina', 'Chile',
                   'Peru', 'Ecuador', 'Uruguay', 'Venezuela', 'Bolivia']
north_america_countries = ['United States', 'Canada']

# Create region column
def assign_region(country):
    if country in latam_countries:
        return 'Latin America'
    elif country in north_america_countries:
        return 'North America'
    else:
        return 'Other'

df['region'] = df['employee_residence'].apply(assign_region)

print("\nRegion distribution:")
print(df['region'].value_counts())


# =====================================================
# SECTION 3: ANALYSIS 1 - TOP JOB TITLES BY SALARY
# =====================================================
# Business Question: What job titles have the highest average salary?

top_titles = (
    df.groupby('job_title')['salary_in_usd']
    .agg(['mean', 'count'])
    .reset_index()
    .rename(columns={'mean': 'avg_salary', 'count': 'count'})
)

# Filter titles with at least 10 records for statistical significance
top_titles = top_titles[top_titles['count'] >= 10]
top_titles = top_titles.sort_values('avg_salary', ascending=False).head(15)

print("\n=== TOP 15 JOB TITLES BY AVERAGE SALARY ===")
print(top_titles[['job_title', 'avg_salary', 'count']].to_string(index=False))

# Visualization
fig, ax = plt.subplots(figsize=(12, 7))
colors = ['#1A3C5E' if i == 0 else '#2E7FBF' if i < 5 else '#7FB3D3' for i in range(len(top_titles))]
bars = ax.barh(top_titles['job_title'], top_titles['avg_salary'], color=colors)
ax.set_xlabel('Average Annual Salary (USD)', fontsize=11)
ax.set_title('Top 15 Job Titles by Average Salary\n(minimum 10 records)', fontsize=13, fontweight='bold', pad=15)
ax.xaxis.set_major_formatter(mticker.FuncFormatter(lambda x, _: f'${x:,.0f}'))
ax.invert_yaxis()
for bar, val in zip(bars, top_titles['avg_salary']):
    ax.text(bar.get_width() + 500, bar.get_y() + bar.get_height()/2,
            f'${val:,.0f}', va='center', fontsize=9)
plt.tight_layout()
plt.savefig('01_top_job_titles.png', dpi=150, bbox_inches='tight')
plt.show()
print("Chart saved: 01_top_job_titles.png")


# =====================================================
# SECTION 4: ANALYSIS 2 - SALARY BY JOB CATEGORY
# =====================================================
# Business Question: Which job category pays the most / least?

category_salary = (
    df.groupby('job_category')['salary_in_usd']
    .agg(['mean', 'median', 'count'])
    .reset_index()
    .rename(columns={'mean': 'avg_salary', 'median': 'median_salary', 'count': 'count'})
    .sort_values('avg_salary', ascending=False)
)

print("\n=== SALARY BY JOB CATEGORY ===")
print(category_salary.to_string(index=False))

top_category = category_salary.iloc[0]['job_category']
bottom_category = category_salary.iloc[-1]['job_category']
print(f"\nHighest paying category: {top_category} (${category_salary.iloc[0]['avg_salary']:,.0f})")
print(f"Lowest paying category: {bottom_category} (${category_salary.iloc[-1]['avg_salary']:,.0f})")

# Visualization
fig, ax = plt.subplots(figsize=(12, 6))
palette = ['#1A3C5E' if i == 0 else '#C0392B' if i == len(category_salary)-1 else '#2E7FBF'
           for i in range(len(category_salary))]
bars = ax.barh(category_salary['job_category'], category_salary['avg_salary'], color=palette)
ax.set_xlabel('Average Annual Salary (USD)', fontsize=11)
ax.set_title('Average Salary by Job Category', fontsize=13, fontweight='bold', pad=15)
ax.xaxis.set_major_formatter(mticker.FuncFormatter(lambda x, _: f'${x:,.0f}'))
ax.invert_yaxis()
for bar, val in zip(bars, category_salary['avg_salary']):
    ax.text(bar.get_width() + 300, bar.get_y() + bar.get_height()/2,
            f'${val:,.0f}', va='center', fontsize=9)
plt.tight_layout()
plt.savefig('02_salary_by_category.png', dpi=150, bbox_inches='tight')
plt.show()
print("Chart saved: 02_salary_by_category.png")


# =====================================================
# SECTION 5: ANALYSIS 3 - COMPANY SIZE VS SALARY
# =====================================================
# Business Question: Do large companies pay more than small ones?

size_labels = {'S': 'Small', 'M': 'Medium', 'L': 'Large'}
df['company_size_label'] = df['company_size'].map(size_labels)

size_salary = (
    df.groupby('company_size_label')['salary_in_usd']
    .agg(['mean', 'median', 'count'])
    .reset_index()
    .rename(columns={'mean': 'avg_salary', 'median': 'median_salary', 'count': 'count'})
)
size_order = ['Small', 'Medium', 'Large']
size_salary['company_size_label'] = pd.Categorical(size_salary['company_size_label'], categories=size_order, ordered=True)
size_salary = size_salary.sort_values('company_size_label')

print("\n=== SALARY BY COMPANY SIZE ===")
print(size_salary.to_string(index=False))

# Visualization
fig, ax = plt.subplots(figsize=(8, 5))
colors = ['#7FB3D3', '#2E7FBF', '#1A3C5E']
bars = ax.bar(size_salary['company_size_label'], size_salary['avg_salary'], color=colors, width=0.5)
ax.set_xlabel('Company Size', fontsize=11)
ax.set_ylabel('Average Annual Salary (USD)', fontsize=11)
ax.set_title('Average Salary by Company Size', fontsize=13, fontweight='bold', pad=15)
ax.yaxis.set_major_formatter(mticker.FuncFormatter(lambda x, _: f'${x:,.0f}'))
for bar, val in zip(bars, size_salary['avg_salary']):
    ax.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 500,
            f'${val:,.0f}', ha='center', fontsize=10, fontweight='bold')
plt.tight_layout()
plt.savefig('03_salary_by_company_size.png', dpi=150, bbox_inches='tight')
plt.show()
print("Chart saved: 03_salary_by_company_size.png")


# =====================================================
# SECTION 6: ANALYSIS 4 - EXPERIENCE LEVEL VS SALARY
# =====================================================
# Business Question: Which experience level earns the most?

exp_salary = (
    df.groupby('experience_level')['salary_in_usd']
    .agg(['mean', 'median', 'count'])
    .reset_index()
    .rename(columns={'mean': 'avg_salary', 'median': 'median_salary', 'count': 'count'})
)
exp_salary['experience_level'] = pd.Categorical(exp_salary['experience_level'],
                                                  categories=experience_order, ordered=True)
exp_salary = exp_salary.sort_values('experience_level')

print("\n=== SALARY BY EXPERIENCE LEVEL ===")
print(exp_salary.to_string(index=False))

# Calculate salary growth between levels
entry_avg = exp_salary[exp_salary['experience_level'] == 'Entry-level']['avg_salary'].values[0]
senior_avg = exp_salary[exp_salary['experience_level'] == 'Senior']['avg_salary'].values[0]
growth = ((senior_avg - entry_avg) / entry_avg) * 100
print(f"\nSalary growth Entry-level → Senior: +{growth:.1f}%")

# Visualization
fig, ax = plt.subplots(figsize=(9, 5))
colors = ['#7FB3D3', '#2E7FBF', '#1A3C5E', '#0D2137']
bars = ax.bar(exp_salary['experience_level'], exp_salary['avg_salary'], color=colors, width=0.5)
ax.set_xlabel('Experience Level', fontsize=11)
ax.set_ylabel('Average Annual Salary (USD)', fontsize=11)
ax.set_title('Average Salary by Experience Level', fontsize=13, fontweight='bold', pad=15)
ax.yaxis.set_major_formatter(mticker.FuncFormatter(lambda x, _: f'${x:,.0f}'))
for bar, val in zip(bars, exp_salary['avg_salary']):
    ax.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 500,
            f'${val:,.0f}', ha='center', fontsize=10, fontweight='bold', color='white' if val > 100000 else 'black')
plt.tight_layout()
plt.savefig('04_salary_by_experience.png', dpi=150, bbox_inches='tight')
plt.show()
print("Chart saved: 04_salary_by_experience.png")


# =====================================================
# SECTION 7: ANALYSIS 5 - LATAM VS NORTH AMERICA
# =====================================================
# Business Question: Is there a salary gap between LATAM and North America?

region_df = df[df['region'].isin(['Latin America', 'North America'])]

region_salary = (
    region_df.groupby(['region', 'experience_level'])['salary_in_usd']
    .mean()
    .reset_index()
    .rename(columns={'salary_in_usd': 'avg_salary'})
)
region_salary['experience_level'] = pd.Categorical(region_salary['experience_level'],
                                                     categories=experience_order, ordered=True)
region_salary = region_salary.sort_values('experience_level')

print("\n=== LATAM VS NORTH AMERICA SALARY BY EXPERIENCE LEVEL ===")
print(region_salary.to_string(index=False))

latam_avg = region_df[region_df['region'] == 'Latin America']['salary_in_usd'].mean()
na_avg = region_df[region_df['region'] == 'North America']['salary_in_usd'].mean()
gap = ((na_avg - latam_avg) / latam_avg) * 100
print(f"\nOverall LATAM average: ${latam_avg:,.0f}")
print(f"Overall North America average: ${na_avg:,.0f}")
print(f"Salary gap: North America pays {gap:.1f}% more than LATAM")
print(f"\nNote: LATAM sample is small ({len(region_df[region_df['region']=='Latin America'])} records) — interpret with caution")

# Visualization
fig, ax = plt.subplots(figsize=(10, 5))
x = np.arange(len(experience_order))
width = 0.35
latam_vals = [region_salary[(region_salary['region']=='Latin America') &
              (region_salary['experience_level']==e)]['avg_salary'].values
              for e in experience_order]
na_vals = [region_salary[(region_salary['region']=='North America') &
           (region_salary['experience_level']==e)]['avg_salary'].values
           for e in experience_order]
latam_vals = [v[0] if len(v) > 0 else 0 for v in latam_vals]
na_vals = [v[0] if len(v) > 0 else 0 for v in na_vals]

bars1 = ax.bar(x - width/2, latam_vals, width, label='Latin America', color='#2E7FBF')
bars2 = ax.bar(x + width/2, na_vals, width, label='North America', color='#1A3C5E')
ax.set_xlabel('Experience Level', fontsize=11)
ax.set_ylabel('Average Annual Salary (USD)', fontsize=11)
ax.set_title('Salary Comparison: Latin America vs North America\nby Experience Level', fontsize=13, fontweight='bold', pad=15)
ax.set_xticks(x)
ax.set_xticklabels(experience_order)
ax.yaxis.set_major_formatter(mticker.FuncFormatter(lambda x, _: f'${x:,.0f}'))
ax.legend()
plt.tight_layout()
plt.savefig('05_latam_vs_northamerica.png', dpi=150, bbox_inches='tight')
plt.show()
print("Chart saved: 05_latam_vs_northamerica.png")


# =====================================================
# SECTION 8: ANALYSIS 6 - TOP COUNTRIES BY SALARY
# =====================================================
# Business Question: Which country offers the best salaries?

top_countries = (
    df.groupby('company_location')['salary_in_usd']
    .agg(['mean', 'count'])
    .reset_index()
    .rename(columns={'mean': 'avg_salary', 'count': 'count'})
)
top_countries = top_countries[top_countries['count'] >= 20]
top_countries = top_countries.sort_values('avg_salary', ascending=False).head(15)

print("\n=== TOP 15 COUNTRIES BY AVERAGE SALARY ===")
print(top_countries[['company_location', 'avg_salary', 'count']].to_string(index=False))

# Visualization
fig, ax = plt.subplots(figsize=(11, 7))
colors = ['#1A3C5E' if i == 0 else '#2E7FBF' if i < 5 else '#7FB3D3' for i in range(len(top_countries))]
bars = ax.barh(top_countries['company_location'], top_countries['avg_salary'], color=colors)
ax.set_xlabel('Average Annual Salary (USD)', fontsize=11)
ax.set_title('Top 15 Countries by Average Salary\n(minimum 20 records)', fontsize=13, fontweight='bold', pad=15)
ax.xaxis.set_major_formatter(mticker.FuncFormatter(lambda x, _: f'${x:,.0f}'))
ax.invert_yaxis()
for bar, val in zip(bars, top_countries['avg_salary']):
    ax.text(bar.get_width() + 300, bar.get_y() + bar.get_height()/2,
            f'${val:,.0f}', va='center', fontsize=9)
plt.tight_layout()
plt.savefig('06_top_countries_salary.png', dpi=150, bbox_inches='tight')
plt.show()
print("Chart saved: 06_top_countries_salary.png")


# =====================================================
# SECTION 9: ANALYSIS 7 - SALARY EVOLUTION OVER TIME
# =====================================================
# Business Question: How have salaries evolved over time?

yearly_salary = (
    df.groupby(['work_year', 'experience_level'])['salary_in_usd']
    .mean()
    .reset_index()
    .rename(columns={'salary_in_usd': 'avg_salary'})
)
yearly_salary['experience_level'] = pd.Categorical(yearly_salary['experience_level'],
                                                     categories=experience_order, ordered=True)

print("\n=== SALARY EVOLUTION BY YEAR ===")
print(yearly_salary.pivot(index='work_year', columns='experience_level', values='avg_salary').to_string())

# Visualization
fig, ax = plt.subplots(figsize=(10, 6))
colors_exp = {'Entry-level': '#7FB3D3', 'Mid-level': '#2E7FBF', 'Senior': '#1A3C5E', 'Executive': '#0D2137'}
for level in experience_order:
    data = yearly_salary[yearly_salary['experience_level'] == level]
    ax.plot(data['work_year'], data['avg_salary'], marker='o', linewidth=2.5,
            label=level, color=colors_exp[level])
ax.set_xlabel('Year', fontsize=11)
ax.set_ylabel('Average Annual Salary (USD)', fontsize=11)
ax.set_title('Salary Evolution Over Time by Experience Level\n(2020–2023)', fontsize=13, fontweight='bold', pad=15)
ax.yaxis.set_major_formatter(mticker.FuncFormatter(lambda x, _: f'${x:,.0f}'))
ax.legend(title='Experience Level')
ax.set_xticks([2020, 2021, 2022, 2023])
plt.tight_layout()
plt.savefig('07_salary_evolution.png', dpi=150, bbox_inches='tight')
plt.show()
print("Chart saved: 07_salary_evolution.png")


# =====================================================
# SECTION 10: ANALYSIS 8 - REMOTE VS IN-PERSON VS HYBRID
# =====================================================
# Business Question: Does remote work pay more than in-person or hybrid?

remote_salary = (
    df.groupby('work_setting')['salary_in_usd']
    .agg(['mean', 'median', 'count'])
    .reset_index()
    .rename(columns={'mean': 'avg_salary', 'median': 'median_salary', 'count': 'count'})
    .sort_values('avg_salary', ascending=False)
)

print("\n=== SALARY BY WORK SETTING ===")
print(remote_salary.to_string(index=False))

# Visualization
fig, ax = plt.subplots(figsize=(8, 5))
colors = ['#1A3C5E', '#2E7FBF', '#7FB3D3']
bars = ax.bar(remote_salary['work_setting'], remote_salary['avg_salary'], color=colors, width=0.5)
ax.set_xlabel('Work Setting', fontsize=11)
ax.set_ylabel('Average Annual Salary (USD)', fontsize=11)
ax.set_title('Average Salary by Work Setting\n(Remote vs In-person vs Hybrid)', fontsize=13, fontweight='bold', pad=15)
ax.yaxis.set_major_formatter(mticker.FuncFormatter(lambda x, _: f'${x:,.0f}'))
for bar, val in zip(bars, remote_salary['avg_salary']):
    ax.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 300,
            f'${val:,.0f}', ha='center', fontsize=11, fontweight='bold')
plt.tight_layout()
plt.savefig('08_salary_by_work_setting.png', dpi=150, bbox_inches='tight')
plt.show()
print("Chart saved: 08_salary_by_work_setting.png")


# =====================================================
# SECTION 11: KEY BUSINESS INSIGHTS
# =====================================================

print("\n" + "="*55)
print("KEY BUSINESS INSIGHTS")
print("="*55)

print("\n1. TOP JOB TITLES")
top1 = top_titles.iloc[0]
print(f"   → {top1['job_title']} leads with an avg salary of ${top1['avg_salary']:,.0f}/year")

print("\n2. JOB CATEGORIES")
print(f"   → Highest: {category_salary.iloc[0]['job_category']} (${category_salary.iloc[0]['avg_salary']:,.0f})")
print(f"   → Lowest:  {category_salary.iloc[-1]['job_category']} (${category_salary.iloc[-1]['avg_salary']:,.0f})")

print("\n3. COMPANY SIZE")
large = size_salary[size_salary['company_size_label']=='Large']['avg_salary'].values[0]
small = size_salary[size_salary['company_size_label']=='Small']['avg_salary'].values[0]
print(f"   → Large companies pay ${large:,.0f} vs Small companies ${small:,.0f}")

print("\n4. EXPERIENCE LEVEL")
for _, row in exp_salary.iterrows():
    print(f"   → {row['experience_level']}: ${row['avg_salary']:,.0f}")

print("\n5. LATAM VS NORTH AMERICA")
print(f"   → LATAM avg: ${latam_avg:,.0f} | North America avg: ${na_avg:,.0f}")
print(f"   → Gap: North America pays {gap:.1f}% more")
print(f"   → Note: LATAM sample is small — interpret with caution")

print("\n6. TOP COUNTRY")
print(f"   → {top_countries.iloc[0]['company_location']} leads with ${top_countries.iloc[0]['avg_salary']:,.0f} avg salary")

print("\n7. SALARY EVOLUTION")
y2020 = df[df['work_year']==2020]['salary_in_usd'].mean()
y2023 = df[df['work_year']==2023]['salary_in_usd'].mean()
growth_yoy = ((y2023 - y2020) / y2020) * 100
print(f"   → Overall avg salary grew {growth_yoy:.1f}% from 2020 to 2023")

print("\n8. WORK SETTING")
top_setting = remote_salary.iloc[0]
print(f"   → {top_setting['work_setting']} has the highest avg salary: ${top_setting['avg_salary']:,.0f}")

print("\n" + "="*55)
