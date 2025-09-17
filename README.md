# Auto Insurance Monthly Premium Predictions with GLM Repo

Business Problem: Auto insurers are receiving pressure to set fair and accurate premiums that balance profitability with regulatory compliance. Traditional acturarial methods call for GLM's due to their:

-Interpretability: transparent breakdown of coefficients to regulatory oversight.
-Flexibility: can model both normal and non-normal distributions.
-Industry Adoption: Standard amonst insurance agencies.

Data & Methodology:

-Data Source: https://www.kaggle.com/datasets/merishnasuwal/auto-insurance-churn-analysis-dataset. I input five sample csv files into the Data --> Raw folder to show you a sample of what I processed (The original files were too big).
-SQL Workflow: Data ingestion, condensation, and cleaning done across 3 different python scripts implementing sqlite
-Model: Tweedie distribution with a var_power of 1.45 (tested for this value) with a default log link function in order to create a multiplicative effect for the model coefficients

Repo Structure
-Python/
-Data/
  -Raw/
-Database (db)
-ReadMe

Workflow:

Data Ingestion (SQLite) - 
1. Raw CSV's imported into SQL DB, via 5 distinct tables
2. Aggregations done with SQL queries

Data Condensation (SQLite) -
1. Go from 5 tables to 1 condensed table in the SQL DB
2. Read in from the backup tables if the primary one had null entries

Data Cleaning (SQLite) -
1. Fill in n/a values with various methods such as medians, categorical variables, and binary values.
2. Match a numerical value to every entry in preparation for statistical analysis

Statistical Analysis (Python,Statsmodels.api) -
1. Determine proper distribution via the Tweedie method, while also taking into account AIC, BIC, and RMSE
2. Enforce backwards propogation to omit columns with p-values > 0.05
3. Identify coefficients with the highest magnitude for each sign and double check that with business logic.
4. View residuals plot along with baseline RMSE and MAE.
5. Compare with an off the shelf ML model such as XGBoost to compare and contrast accuracy and interpretability.

Results:

Baseline -
MAE: 194.10
RMSE: 243.90
R2: 0.05

GLM Model Performance -
MAE: 188.89
RMSE: 237.41
R2: 0.05

XGBoost ML Model Performance -
MAE: 186.79
RMSE: 234.79
R2: 0.07

Key Findings - 
GLM identified statsically significant predictors of premium:
-Income (positive) --> Higher income linked to higher coverage levels and premiums
-College Education (positive) --> Correlated with higher income.
-Having Children (negative) --> Safer lifestyle and engaging in less risky behavior
-Marital Status (positive) --> more than 1 vehicle associated with the same policy 
-Tenure (negative) --> insurers reward loyalty and reduce premiums for those who stay longer

Takeaways -
-Interpretability vs. Accuracy Tradeoff: GLM's offer more control and understanding of model inputs even though ML offers marginal improvement in model accuracy
-Business Insights: Socio-demographic and behavioral features strongly influence premiums - but not always in intuitive ways
-Industry Allignment: Project simulates how insurers balance risk modeling with regulatory/customer facing fairness considerations

How to Reproduce:
1. Clone repo
2. Install requirements:
   pip install -r requirements.txt
4. Run scripts in /python

Author: Jack Decker, jackdecker2002@gmail.com, https://www.linkedin.com/in/jack-decker8/
