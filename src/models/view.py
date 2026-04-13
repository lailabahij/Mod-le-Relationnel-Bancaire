from sqlalchemy import text
from config.database import engine

def create_views():
    with engine.begin() as conn:

        # ======================
        # v_transactions_full
        # ======================
        conn.execute(text("""
            CREATE OR REPLACE VIEW v_transactions_full AS
            SELECT
                t.transaction_id,
                t.client_id,
                c.score_credit_client,
                c.segment_id,
                s.segment_client,

                t.montant,
                t.montant_eur,
                t.devise,
                t.type_operation,
                t.statut,
                t.is_anomaly,

                a.agence,
                p.produit,
                p.categorie,

                tm.date_transaction,
                tm.annee,
                tm.mois,
                tm.trimestre,
                tm.jour_semaine

            FROM transactions t

            LEFT JOIN clients c
                ON t.client_id = c.client_id

            LEFT JOIN segments s
                ON c.segment_id = s.segment_id

            LEFT JOIN agences a
                ON t.agence_id = a.agence_id

            LEFT JOIN produits p
                ON t.produit_id = p.produit_id

            LEFT JOIN temps_transaction tm
                ON t.temps_id = tm.temps_id;
        """))

        print("✔ v_transactions_full created")

        # ======================
        # v_clients_analysis
        # ======================
        conn.execute(text("""
            CREATE OR REPLACE VIEW v_clients_analysis AS
            SELECT
                c.client_id,
                c.score_credit_client,
                s.segment_client,

                COUNT(t.transaction_id) AS total_transactions,
                SUM(t.montant_eur) AS total_spent,
                AVG(t.montant_eur) AS avg_transaction

            FROM clients c

            LEFT JOIN segments s
                ON c.segment_id = s.segment_id

            LEFT JOIN transactions t
                ON c.client_id = t.client_id

            GROUP BY c.client_id, c.score_credit_client, s.segment_client;
        """))

        print("✔ v_clients_analysis created")

        # ======================
        # v_agences_performance
        # ======================
        conn.execute(text("""
            CREATE OR REPLACE VIEW v_agences_performance AS
            SELECT
                a.agence,
                COUNT(t.transaction_id) AS total_transactions,
                SUM(t.montant_eur) AS total_volume,
                AVG(t.montant_eur) AS avg_ticket

            FROM agences a

            LEFT JOIN transactions t
                ON t.agence_id = a.agence_id

            GROUP BY a.agence;
        """))

        print("✔ v_agences_performance created")

        # ======================
        # v_anomalies
        # ======================
        conn.execute(text("""
            CREATE OR REPLACE VIEW v_anomalies AS
            SELECT
                t.transaction_id,
                t.client_id,
                t.montant,
                t.montant_eur,
                t.type_operation,
                t.statut,
                a.agence

            FROM transactions t

            LEFT JOIN agences a
                ON t.agence_id = a.agence_id

            WHERE t.is_anomaly = TRUE;
        """))

        print("✔ v_anomalies created")

    print("🚀 ALL VIEWS CREATED SUCCESSFULLY")