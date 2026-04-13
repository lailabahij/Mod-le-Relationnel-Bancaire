from sqlalchemy import text
from config.database import engine

def create_indexes():
    with engine.begin() as conn:

        # 🔹 index client_id
        conn.execute(text("""
            CREATE INDEX IF NOT EXISTS idx_clients_client_id
            ON clients(client_id);
        """))

        # 🔹 index date_transaction
        conn.execute(text("""
            CREATE INDEX IF NOT EXISTS idx_temps_date
            ON temps_transaction(date_transaction);
        """))

        # 🔹 index agence_id
        conn.execute(text("""
            CREATE INDEX IF NOT EXISTS idx_transactions_agence
            ON transactions(agence_id);
        """))

    print("🚀 All indexes created successfully")