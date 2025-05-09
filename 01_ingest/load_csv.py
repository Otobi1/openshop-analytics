import pandas as pd
from sqlalchemy import create_engine, text
import os

# you can package the host, username, password and db name into a .env and load them here
DATABASE_URL = os.getenv("DATABASE_URL",
                          "postgresql://analytics:analytics@localhost:5432/analytics")

# sometimes, you need to set and confirm the working directory to ensure the script runs in the correct context

print("current working directory:", os.getcwd())
print("contents of the current directory:", os.listdir())
print("data/ contains:", os.listdir("data"))

df = pd.read_csv("data/sample_transactions.csv")

engine = create_engine(DATABASE_URL)

# postgres expects one query at a time, so we need to separate the queries rather than trying to run them in a single string
with engine.begin() as conn:
    conn.execute(text("CREATE SCHEMA IF NOT EXISTS raw;"))
                 
    conn.execute(text("""
        CREATE TABLE IF NOT EXISTS raw.transactions (
            transaction_id TEXT PRIMARY KEY,
            customer_id TEXT,
            amount DOUBLE PRECISION,
            currency TEXT,
            timestamp TIMESTAMP
        );
    """))

    conn.execute(text("TRUNCATE TABLE raw.transactions;"))

    # df to sql needs to be within the same connection context
    df.to_sql('transactions', conn, schema='raw', if_exists='append', index=False)

print(f"Loaded {len(df)} rows into the raw.transactions table.")