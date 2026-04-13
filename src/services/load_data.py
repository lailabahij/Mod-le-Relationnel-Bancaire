from models.segments import create_segments_table
from models.clients import create_clients_table
from models.produits import create_produits_table
from models.agences import create_agences_table
from models.temps_transaction import create_temps_transaction_table

from models.transactions import create_transactions_table


def init_db():
    try:
        print("🚀 Starting database initialization...\n")

        create_segments_table()
        print("✔ segments created")

        create_clients_table()
        print("✔ clients created")

        create_produits_table()
        print("✔ produits created")

        create_agences_table()
        print("✔ agences created")

        create_temps_transaction_table()
        print("✔ temps_transaction created")

     

        create_transactions_table()
        print("✔ transactions created")

        print("\n🎉 ALL TABLES CREATED SUCCESSFULLY!")

    except Exception as e:
        print("❌ ERROR while creating tables:")
        print(e)