#  Movie Correlation Analysis with Python

##  Project Overview
This project analyzes a movie dataset to identify relationships between different movie attributes
and box office revenue. Using Python, the goal is to understand which factors most strongly influence
a movie’s financial success.

##  Objectives
- Clean and prepare raw movie data for analysis
- Handle missing values and correct data types
- Explore correlations between numeric features
- Visualize relationships using plots and heatmaps
- Extract business-relevant insights from the analysis

##  Tools & Technologies
- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- Jupyter Notebook

##  Dataset
- **Source**: Public movie dataset (used for learning and analysis)
- **File**: `movies.csv`
- **Data Type**: Movie metadata including budget, gross revenue, ratings, votes, runtime, and company

##  Data Preparation & Cleaning
- Checked for missing values across all columns
- Replaced missing numeric values using median imputation
- Converted relevant columns to appropriate numeric data types
- Removed duplicate records
- Sorted data based on gross revenue

##  Exploratory Data Analysis
- Scatter plots to analyze relationships between:
  - Budget and gross revenue
  - Movie score and gross revenue
- Correlation analysis using Pearson correlation
- Heatmap visualization to highlight strong relationships between features

##  Key Insights
- Movie budget shows a strong positive correlation with gross revenue.
- Audience engagement (votes) is more strongly correlated with revenue than movie ratings.
- High-grossing production companies tend to consistently generate higher revenues.

##  Limitations
- Correlation does not imply causation.
- Categorical variables were numerically encoded, which may limit interpretability.
- External factors such as marketing or release timing are not included in the dataset.

##  Future Improvements
- Build a regression model to predict movie revenue
- Perform genre-based or time-based analysis
- Apply Spearman correlation to reduce the impact of outliers


