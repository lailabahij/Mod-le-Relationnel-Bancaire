-- Vue globale (transactions enrichies)
CREATE OR REPLACE VIEW vw_transactions_global AS
SELECT 
    t.id_transactions,
    t.montant,
    t.devise,
    t.montant_eur,
    t.type_operation,
    t.statut,

    c.id_client,
    c.score_credit,
    c.categorie_risque,
    c.taux_rejet,

    s.nom_segment,

    cp.id_compte,
    cp.solde,

    p.nom_produit,
    p.categorie AS categorie_produit,

    a.nom_agence,

    tm.date_transaction,
    tm.annees,
    tm.mois,
    tm.trimestre,
    tm.jour_semaine

FROM transactions t
JOIN comptes cp ON t.id_compte = cp.id_compte
JOIN clients c ON cp.id_client = c.id_client
LEFT JOIN segments s ON c.id_segment = s.id_segment
JOIN produits p ON t.id_produit = p.id_produit
JOIN agences a ON t.id_agence = a.id_agence
JOIN public.temps tm ON t.id_temps = tm.id_temps;


-- Vue chiffre d'affaires par agence
CREATE OR REPLACE VIEW vw_ca_agence AS
SELECT 
    a.nom_agence,
    SUM(t.montant_eur) AS total_ca,
    COUNT(*) AS nb_transactions
FROM transactions t
JOIN agences a ON t.id_agence = a.id_agence
GROUP BY a.nom_agence;


-- Vue anomalies (✔️ تصحيح)
CREATE OR REPLACE VIEW vw_anomalies AS
SELECT 
    t.id_transactions,
    c.id_client,
    t.montant_eur,
    c.score_credit,
    c.categorie_risque,
    t.statut
FROM transactions t
JOIN comptes cp ON t.id_compte = cp.id_compte
JOIN clients c ON cp.id_client = c.id_client
WHERE 
    t.montant_eur > 10000
    OR c.categorie_risque = 'High'
    OR t.statut = 'Rejete';


-- Vue analyse temporelle
CREATE OR REPLACE VIEW vw_transactions_temps AS
SELECT 
    tm.annees,
    tm.mois,
    tm.trimestre,
    COUNT(t.id_transactions) AS nb_transactions,
    SUM(t.montant_eur) AS total_montant
FROM transactions t
JOIN public.temps tm ON t.id_temps = tm.id_temps
GROUP BY tm.annees, tm.mois, tm.trimestre;


-- Vue produits
CREATE OR REPLACE VIEW vw_produits_performance AS
SELECT 
    p.nom_produit,
    p.categorie,
    COUNT(t.id_transactions) AS nb_utilisation,
    SUM(t.montant_eur) AS total_volume
FROM produits p
JOIN transactions t ON p.id_produit = t.id_produit
GROUP BY p.nom_produit, p.categorie;