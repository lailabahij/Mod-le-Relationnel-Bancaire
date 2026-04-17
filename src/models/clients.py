from sqlalchemy import text
from config.database import engine

def create_clients_table():
    query = """
    CREATE TABLE IF NOT EXISTS clients (
        id_client SERIAL PRIMARY KEY,

        client_id VARCHAR(50) UNIQUE NOT NULL,

        score_credit_client FLOAT NOT NULL CHECK (score_credit_client >= 0),

        segment_id INT NOT NULL,

        FOREIGN KEY (segment_id) REFERENCES segments(segment_id)
            ON DELETE CASCADE
    );
    """

    with engine.begin() as conn:
        conn.execute(text(query))

    print("✅ clients created")