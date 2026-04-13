from sqlalchemy import text
from config.database import engine

def create_agences_table():
    query = """
    CREATE TABLE IF NOT EXISTS agences (
        agence_id SERIAL PRIMARY KEY,
        agence VARCHAR(100) NOT NULL UNIQUE,
        taux_rejet FLOAT NOT NULL CHECK (taux_rejet >= 0 AND taux_rejet <= 1)
    );
    """

    with engine.begin() as conn:
        conn.execute(text(query))

    print("✅ agences created")