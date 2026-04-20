CREATE TABLE temps (
    id_temps INTEGER PRIMARY KEY,
    date_transaction DATE NOT NULL UNIQUE,
    annees INTEGER NOT NULL,
    mois INTEGER NOT NULL,
    trimestre INTEGER NOT NULL CHECK (trimestre BETWEEN 1 AND 4),
    jour_semaine TEXT NOT NULL
);

CREATE TABLE segments (
    id_segment INTEGER PRIMARY KEY,
    nom_segment TEXT NOT NULL UNIQUE
);

CREATE TABLE clients (
    id_client TEXT PRIMARY KEY,
    score_credit INTEGER NOT NULL,
    categorie_risque TEXT CHECK (categorie_risque IN ('Medium','Low','High')),
    taux_rejet REAL CHECK (taux_rejet BETWEEN 0 AND 1),
    id_segment INTEGER,
    FOREIGN KEY (id_segment) REFERENCES segments(id_segment)
);

CREATE TABLE comptes (
    id_compte TEXT PRIMARY KEY,
    id_client TEXT NOT NULL,
    solde REAL NOT NULL,
    FOREIGN KEY (id_client) REFERENCES clients(id_client)
);


CREATE TABLE produits (
    id_produit INTEGER PRIMARY KEY,
    nom_produit TEXT NOT NULL,
    categorie TEXT NOT NULL
);

CREATE TABLE agences (
    id_agence INTEGER PRIMARY KEY,
    nom_agence TEXT NOT NULL
);

CREATE TABLE transactions (
    id_transactions TEXT PRIMARY KEY,
    id_compte TEXT NOT NULL,
    id_produit INTEGER NOT NULL,
    id_agence INTEGER NOT NULL,
    id_temps INTEGER NOT NULL,
    
    montant REAL NOT NULL,
    devise TEXT NOT NULL,
    montant_eur REAL NOT NULL,
    
    type_operation TEXT CHECK (type_operation IN ('Credit','Debit')),
    statut TEXT CHECK (statut IN ('Complete','Rejete','En attente')),

    FOREIGN KEY (id_compte) REFERENCES comptes(id_compte),
    FOREIGN KEY (id_produit) REFERENCES produits(id_produit),
    FOREIGN KEY (id_agence) REFERENCES agences(id_agence),
    FOREIGN KEY (id_temps) REFERENCES temps(id_temps)
);