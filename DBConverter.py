import sqlite3
import pandas as pd

df = pd.read_csv("Insurance_Claims.csv")

conn = sqlite3.connect("Insurance_Claims.db")

# Save DataFrame to SQLite (table name = "mytable")
df.to_sql("mytable", conn, if_exists="replace", index=False)

conn.close()