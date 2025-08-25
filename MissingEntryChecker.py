import sqlite3
import pandas as pd

conn = sqlite3.connect("Insurance_Claims.db")

# load the whole table
#df = pd.read_sql_query("SELECT * FROM mytable;", conn)

# drop a column
#df = df.drop(columns=["_c39"])

#df.to_sql("mytable", conn, if_exists="replace", index=False)

print(conn)

cursor = conn.cursor()

# get all column names
cursor.execute("PRAGMA table_info(mytable);")
cols = [row[1] for row in cursor.fetchall()]


# build query that checks for NULL in any column
where_clause = " OR ".join([f'"{c}" IS NULL' for c in cols])
query = f"SELECT * FROM mytable WHERE {where_clause};"

print(query)  # see the query
rows = cursor.execute(query).fetchall()
print(f"Rows with missing data: {len(rows)}")

# load the whole table
df = pd.read_sql_query("SELECT * FROM mytable;", conn)
rows_with_nulls = df[df.isnull().any(axis=1)]

print(f"Rows with missing data: {len(rows_with_nulls)}")
print(rows_with_nulls)  # prints the rows that have at least one null

# Find rows with any nulls
rows_with_nulls = df[df.isnull().any(axis=1)]

# Create a DataFrame showing True/False for nulls
null_columns = rows_with_nulls.isnull()

print(f"Rows with missing data: {len(rows_with_nulls)}")
print("Null columns per row:")
print(null_columns)

#null_columns.to_csv("Checker.csv", index=False)

# Total missing values per column
df.isnull().sum()

# Percentage missing per column
df.isnull().mean() * 100

# Rows with at least one missing value
rows_with_nulls = df[df.isnull().any(axis=1)]
rows_with_nulls

# Shows True/False per column for missing
df[df.isnull().any(axis=1)].isnull()

import seaborn as sns
import matplotlib.pyplot as plt

sns.heatmap(df.isnull(), cbar=False)
plt.show()

