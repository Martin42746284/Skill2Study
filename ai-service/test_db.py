import os
from dotenv import load_dotenv

load_dotenv()

from sqlalchemy import create_engine, text

db_url = os.getenv('DATABASE_URL')
print(f"Original DB URL: {db_url}")

if db_url.startswith('postgresql://'):
    db_url = db_url.replace('postgresql://', 'postgresql+psycopg2://', 1)

print(f"Converted DB URL: {db_url}")

engine = create_engine(
    db_url,
    connect_args={'connect_timeout': 10},
    pool_pre_ping=True
)

print("Testing connection...")
try:
    with engine.connect() as conn:
        result = conn.execute(text("SELECT 1"))
        print(f"Connection successful! Result: {result.scalar()}")
except Exception as e:
    print(f"Connection failed: {e}")
    import traceback
    traceback.print_exc()
