#  Data Cleaning Project – Nashville Housing

##  Project Overview
This project focuses on cleaning and preparing the Nashville Housing dataset using SQL.
The goal is to transform raw housing data into a clean, structured format ready for analysis.
---

##  Objectives
- Remove duplicate records
- Standardize date formats
- Handle missing values
- Split address fields into separate columns
- Improve data consistency and quality
---

##  Tools & Technologies
- SQL Server
- Microsoft Excel
- SQL (CTE, Window Functions, Joins)
---

##  Dataset
- **Source**: Kaggle (https://www.kaggle.com/datasets/bvanntruong/housing-sql-project)
- **File**: Nashville Housing Data for Data Cleaning.csv
---

##  Data Cleaning Steps
1. Identified and removed duplicate records using "ROW_NUMBER()"
2. Standardized date formats
3. Split property address into:
   - Address
   - City
   - State
4. Replaced inconsistent values (Y/N → Yes/No)
5. Handled NULL and missing values
---

##  Key SQL Techniques Used
- "ROW_NUMBER() OVER(PARTITION BY ...)"
- "SUBSTRING()" and "CHARINDEX()"
- "CASE WHEN"
- "CTE (Common Table Expressions)"

