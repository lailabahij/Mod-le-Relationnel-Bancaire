from sqlalchemy import text
from config.database import engine

def create_produits_table():
    query = """
    CREATE TABLE IF NOT EXISTS produits (
        produit_id SERIAL PRIMARY KEY,
        produit VARCHAR(100) NOT NULL UNIQUE,
        categorie VARCHAR(100) NOT NULL
    );
    """

    with engine.begin() as conn:
        conn.execute(text(query))

    print("✅ produits created")