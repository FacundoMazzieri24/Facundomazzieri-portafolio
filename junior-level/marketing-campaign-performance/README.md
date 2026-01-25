#  Marketing Campaign Performance Analysis  
**SQL (PostgreSQL) + Power BI**

---

##  Project Overview

This project analyzes marketing campaign performance using a structured dataset that includes impressions, clicks, ROI, acquisition cost, customer segments, languages, and geographic locations.

The analysis was conducted using **SQL (PostgreSQL)** for data exploration and metric calculation, and **Power BI** for interactive dashboard visualization.

The main goal is to evaluate campaign efficiency and support data-driven marketing investment decisions.

---

##  Stakeholder Objective

To understand which campaigns, companies, and marketing channels deliver the best performance in order to optimize marketing spend and maximize return on investment (ROI).

---

##  Business Questions

- Which companies generate the highest and lowest volume of impressions and clicks, and how do they compare in terms of CTR and ROI?
- Are there significant differences in ROI across campaign types?
- How does performance vary across marketing channels?
- How does campaign performance evolve over time?
- Which campaigns deliver the highest ROI?
- Which company has the highest customer acquisition cost (CAC)?
- Which customer segments respond best to marketing efforts?
- Is there a relationship between language, geographic location, and impressions volume?

---

##   Key Insights

###  Companies with the Highest Volume of Impressions and Clicks

**Findings**
- Tech Corp leads in impressions and clicks and also shows the highest CTR and ROI.
- Alpha Innovations ranks second in impressions and third in clicks, with high ROI but the lowest CTR.
- DataTech ranks second in clicks and fourth in impressions, with strong CTR and ROI.

**Insight**  
Tech Corp is the most efficient and consistent company, making it the top candidate for increased investment.

---

###  Companies with the Lowest Volume of Impressions and Clicks

**Findings**
- Innovate Industries shows the lowest volume of clicks and impressions, with low CTR and ROI.
- NexGen Systems has mid-level volume but the lowest ROI and very low CTR.

**Insight**  
NexGen Systems shows weak overall performance and should be considered for cost reduction or strategic reassessment.

---

###  ROI Differences Between Campaign Types

**Findings**
- Influencer campaigns deliver the highest ROI.
- Search and Display perform similarly.
- Email has lower ROI.
- Social Media shows the lowest ROI.

**Insight**  
Prioritize Influencer campaigns, maintain investment in Search and Display, and reduce budget for Social Media and Email.

---

###  Performance by Marketing Channel (CTR)

**Findings**
- Website has the highest CTR.
- Email and YouTube show similar CTR levels.
- Facebook and Instagram perform below average.
- Google Ads has the lowest CTR.

**Insight**  
Website is the most efficient channel.  
Google Ads requires optimization or budget reduction.

---

###  Performance Over Time

**Findings**
- Initial growth is observed in clicks, impressions, and ROI.
- Performance later stabilizes after a slight decline.

**Insight**  
Campaigns reach a maturity stage, highlighting the need for optimization to sustain growth.

---

###  Top 3 Campaigns by ROI

1. Influencer  
2. Search  
3. Display  

**Insight**  
Influencer campaigns should be prioritized, while Search and Display remain competitive and stable.

---

###  Customer Acquisition Cost (CAC)

**Findings**
- Alpha Innovations has the highest CAC.
- NexGen Systems has the lowest CAC.
- Other companies show similar CAC values, with Tech Corp slightly above average.

**Insight**  
Alpha Innovations should focus on cost optimization.  
Low CAC alone is not sufficient if ROI is weak (as in NexGen Systems).

---

###  Customer Segment Performance

**Findings**
- Foodies lead in clicks, impressions, and CTR.
- Tech Enthusiasts and Outdoor Adventurers show strong volume and solid CTR.
- Fashionistas have low volume but acceptable CTR.
- Health & Wellness shows low volume and the lowest CTR.

**Insight**  
Prioritize Foodies, Tech Enthusiasts, and Outdoor Adventurers.  
Reduce investment in Fashionistas and Health & Wellness.

---

###  Language and Geographic Location

**Findings**
- English campaigns concentrate impressions mainly in the United States.
- French performs strongly in Miami and New York.
- German stands out in Los Angeles and Chicago.
- Mandarin performs best in Houston and Los Angeles.
- Spanish shows higher impressions in Houston, Chicago, and New York.

**Insight**  
There is a clear relationship between language and geographic location, enabling more precise regional and language-based targeting.

---

##  Tools & Technologies

- **PostgreSQL** – Data exploration, analytical queries, and views  
- **SQL** – Aggregations, KPIs, and business logic  
- **Power BI** – Dashboard design and data visualization  

---

##  Project Structure
marketing-campaign-performance/
├── README.md
├── sql/
│   ├── marketing_queries.sql
│   └── marketing_views.sql
├── powerbi/
│   └── marketing_dashboard.pbix
└── images/
    └── marketing_dashboard.pdf

---

##  Author

**Facundo Mazzieri**  
 facundodantemazz@gmail.com  
 Córdoba, Argentina

