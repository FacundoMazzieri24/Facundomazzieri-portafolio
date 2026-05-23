# Naruto Episodes Analysis

**Level:** Junior  
**Tools:** Power BI, SQL  

## Objective
Analyze Naruto episode ratings to identify patterns in audience reception, compare canon and filler episodes, and evaluate performance across sagas and over time.

## Dataset
Public dataset containing episode-level information, including:
- episode title
- rating
- number of votes
- saga
- episode type (canon, filler, mixed)
- release year

The dataset was cleaned and prepared for analysis prior to visualization.

## Analysis
The analysis was conducted using SQL views to answer key business-style questions, such as:
- identifying the top 10 highest-rated episodes
- exploring the relationship between ratings and number of votes
- comparing average ratings across sagas
- analyzing differences between canon and filler episodes
- observing rating trends over time

All SQL queries used in the analysis can be found in the `sql/analysis_queries.sql` file.

## Dashboards
The Power BI dashboard includes:
- key rating KPIs
- top-performing sagas by average rating
- canon vs filler comparison
- rating evolution over time

The final dashboard is available as:
- Power BI file (`.pbix`)
- exported PDF for quick review

## Project Structure
naruto-episodes-analysis/
├── README.md
├── powerbi/
│ └── naruto_dashboard.pbix
├── images/
│ └── naruto_dashboard.pdf
├── data/
│ └── naruto_episodes.csv
└── sql/
└── analysis_queries.sql

## Key Takeaways
- Canon and mixed canon/filler episodes tend to receive higher ratings than filler episodes.
- Certain sagas consistently outperform others in terms of average audience rating.
- Average ratings remain relatively stable over time, with some notable peaks.

## Notes
This project was created for portfolio purposes to demonstrate data analysis skills, SQL querying, and dashboard development using Power BI.
