from sqlalchemy import text
from config.database import engine

def create_segments_table():
    query = """
    CREATE TABLE IF NOT EXISTS segments (
        segment_id SERIAL PRIMARY KEY,
        segment_client VARCHAR(100) NOT NULL UNIQUE
    );
    """

    with engine.begin() as conn:
        conn.execute(text(query))

    print("✅ segments created")