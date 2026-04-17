from sqlalchemy import text
from config.database import engine

def create_transactions_table():
    query = """
    CREATE TABLE IF NOT EXISTS transactions (
        id_transaction SERIAL PRIMARY KEY,
        transaction_id VARCHAR(50) UNIQUE NOT NULL,

        compte_id INT NOT NULL,
        produit_id INT NOT NULL,
        agence_id INT NOT NULL,
        temps_id INT NOT NULL,

        montant FLOAT NOT NULL,
        taux_change_eur FLOAT NOT NULL,

        devise VARCHAR(10) NOT NULL,
        type_operation VARCHAR(50) NOT NULL,
        statut VARCHAR(50) NOT NULL,

        solde_avant FLOAT NOT NULL CHECK (solde_avant >= 0),
        montant_eur FLOAT NOT NULL,

        is_anomaly BOOLEAN DEFAULT FALSE,

        FOREIGN KEY (compte_id) REFERENCES comptes(compte_id),
        FOREIGN KEY (produit_id) REFERENCES produits(produit_id),
        FOREIGN KEY (agence_id) REFERENCES agences(agence_id),
        FOREIGN KEY (temps_id) REFERENCES temps_transaction(temps_id)
    );
    """

    with engine.begin() as conn:
        conn.execute(text(query))

    print("✅ transactions created")