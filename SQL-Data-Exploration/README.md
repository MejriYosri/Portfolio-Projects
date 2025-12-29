#  COVID-19 Data Exploration with SQL

##  Project Overview
This project focuses on exploring and analyzing global COVID-19 data using SQL.
The objective is to transform raw pandemic data into meaningful insights by applying data cleaning,
aggregation, and advanced SQL analytical techniques.

The analysis covers infection rates, mortality impact, population-level effects, and vaccination progress
across countries and continents.

---

##  Project Objectives
- Clean and prepare raw COVID-19 datasets
- Ensure data quality by correcting data types and handling missing values
- Analyze infection and death trends globally and by region
- Compare countries and continents using population-based metrics
- Study vaccination progress using cumulative calculations
- Create reusable SQL views for future visualization

---

##  Dataset Description
The project uses two datasets:
- **CovidDeaths**: daily COVID-19 cases, deaths, population, and geographic data
- **CovidVaccinations**: daily vaccination statistics by country

Data includes:
- Location, continent, date
- Total and new cases/deaths
- Population
- Vaccination metrics

---

##  Data Cleaning & Preparation
Key cleaning steps performed:
- Replaced empty values (`''`) with `NULL`
- Corrected data types (`DATE`, `FLOAT`, `INT`)
- Standardized date formats
- Removed aggregated rows (where continent is NULL)
- Ensured numeric consistency for analytical calculations

---

##  Exploratory Data Analysis (EDA)

###  Infection & Mortality Analysis
- Death percentage by country (`total_deaths / total_cases`)
- Percentage of population infected
- Countries with the highest infection rates
- Countries with the highest total death counts
- Comparison of COVID-19 impact by continent

---

###  Time-Based Analysis
- Monthly evolution of new COVID-19 cases
- Identification of peak infection periods using date-based aggregation

---

###  Country & Continent Ranking
- Ranking countries by infection rate using window functions
- Comparative analysis across regions and continents

---

###  Vaccination Analysis
- Analysis of vaccination progress by country
- Cumulative vaccinated population using `SUM() OVER (PARTITION BY ...)`
- Percentage of population vaccinated over time

---

##  SQL Techniques Used
- `JOIN`
- `CTE (Common Table Expressions)`
- `Window Functions`
- `RANK()`
- `DATEPART()`
- `TEMP TABLE`
- `VIEW`
- Aggregations (`SUM`, `MAX`, `GROUP BY`)
- Data type conversion and validation

---

##  Output & Reusability
- Created SQL **Views** to store cleaned and aggregated data
- Views are ready for visualization in tools such as **Power BI** or **Tableau**
- Queries are structured for scalability and reuse

---

##  Key Insights
- Significant differences in infection and death rates across countries
- Population-based metrics provide better comparison than absolute numbers
- Vaccination progress varies widely between regions
- Time-based analysis highlights major pandemic waves

---

##  Tools & Technologies
- SQL Server
- SQL (T-SQL)
- GitHub

---

##  Future Improvements
- Integrate the dataset into Power BI for interactive dashboards
- Add forecasting or trend analysis
- Automate data refresh
- Include demographic or economic indicators for deeper insights

---

##  Author
**Yosri Mejri**  
Data Analyst | Business Analyst 

