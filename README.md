# Auto Insurance Claim Severity Prediction with GLM Repo

Business Problem:

What the project does:

Why it matters:

Repo Structure
-SQL/
-Python/
-Data/
  -Raw/
  -Processed/
-Reports/
-Database (db)
-ReadMe

Workflow:

Data Ingestion (SQL) - 
1. Raw CSV's imported into SQLite DB
2. Aggregations done with SQL queries
Feature Engineering (Python) -
1. Pull from SQL into Pandas
2. Handle categorical/numeric features
Modeling (GLM) -
1. Fit Gamma GLM with log link for claim severity
2. Evaluate with MAE, RMSE, psuedo R^2
Interpretation - 
1. Which features increase claim severity?
2. How this helps actuarial decision-making?

Results:

Model Performance - 

Key Insights - 

How to Reproduce:
1. Clone repo
2. Install requirements:
   pip install -r requirements.txt
3. Create database from raw data
   sqlite3 claims.db < SQL/create_tables.sql
4. Run scripts in /python

Data Source: https://www.kaggle.com/datasets/merishnasuwal/auto-insurance-churn-analysis-dataset. I input five sample csv files into the Data --> Raw folder to show you a sample of what I processed (The original files were too big).

Business Context:

Author: Jack Decker, jackdecker2002@gmail.com, https://www.linkedin.com/in/jack-decker8/
