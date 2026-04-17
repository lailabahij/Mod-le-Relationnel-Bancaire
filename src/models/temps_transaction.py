from sqlalchemy import text
from config.database import engine

def create_temps_transaction_table():
    query = """
    CREATE TABLE IF NOT EXISTS temps_transaction (
        temps_id SERIAL PRIMARY KEY,
        date_transaction DATE NOT NULL,
        annee INT NOT NULL CHECK (annee >= 2000),
        mois INT NOT NULL CHECK (mois BETWEEN 1 AND 12),
        trimestre INT NOT NULL CHECK (trimestre BETWEEN 1 AND 4),
        jour_semaine VARCHAR(50) NOT NULL
    );
    """

    with engine.begin() as conn:
        conn.execute(text(query))

    print("✅ temps_transaction created")