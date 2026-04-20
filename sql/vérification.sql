-- Vérifier l'intégrité 
-- Transactions sans compte valide
SELECT COUNT(*) AS orphelins_comptes
FROM transactions t
LEFT JOIN comptes c ON t.id_compte = c.id_compte
WHERE c.id_compte IS NULL;

-- Transactions sans produit valide
SELECT COUNT(*) AS orphelins_produits
FROM transactions t
LEFT JOIN produits p ON t.id_produit = p.id_produit
WHERE p.id_produit IS NULL;

-- Transactions sans agence valide
SELECT COUNT(*) AS orphelins_agences
FROM transactions t
LEFT JOIN agences a ON t.id_agence = a.id_agence
WHERE a.id_agence IS NULL;

-- Transactions sans temps valide
SELECT COUNT(*) AS orphelins_temps
FROM transactions t
LEFT JOIN temps tm ON t.id_temps = tm.id_temps
WHERE tm.id_temps IS NULL;
-- Vérifier cohérence clients → comptes
SELECT COUNT(*) AS comptes_sans_client
FROM comptes c
LEFT JOIN clients cl ON c.id_client = cl.id_client
WHERE cl.id_client IS NULL;
-- Requêtes SQL analytiques avancées
-- Total + moyenne des transactions
SELECT 
    a.nom_agence,
    COUNT(t.id_transactions) AS nb_transactions,
    SUM(t.montant_eur) AS total_montant,
    AVG(t.montant_eur) AS moyenne_montant
FROM transactions t
JOIN agences a ON t.id_agence = a.id_agence
GROUP BY a.nom_agence;
-- Par produit
SELECT 
    p.nom_produit,
    COUNT(*) AS nb_transactions,
    SUM(t.montant_eur) AS total_montant,
    AVG(t.montant_eur) AS moyenne_montant
FROM transactions t
JOIN produits p ON t.id_produit = p.id_produit
GROUP BY p.nom_produit;
-- Par mois
SELECT 
    tm.annees,
    tm.mois,
    COUNT(*) AS nb_transactions,
    SUM(t.montant_eur) AS total_montant,
    AVG(t.montant_eur) AS moyenne_montant
FROM transactions t
JOIN temps tm ON t.id_temps = tm.id_temps
GROUP BY tm.annees, tm.mois
ORDER BY tm.annees, tm.mois;
-- Sous-requête : clients sous la moyenne nationale
SELECT *
FROM clients
WHERE id_client IN (
    SELECT c.id_client
    FROM comptes c
    GROUP BY c.id_client
    HAVING AVG(c.solde) < (
        SELECT AVG(solde) FROM comptes
    )
);
-- CASE WHEN : taux de défaut par segment de risque
SELECT 
    s.nom_segment,
    COUNT(c.id_client) AS total_clients,
    
    SUM(
        CASE 
            WHEN c.categorie_risque = 'High' THEN 1
            ELSE 0
        END
    ) * 1.0 / COUNT(c.id_client) AS taux_defaut

FROM clients c
JOIN segments s ON c.id_segment = s.id_segment
GROUP BY s.nom_segment;
-- Jointure multi-tables complète
SELECT 
    t.id_transactions,
    cl.id_client,
    cl.score_credit,
    c.solde,
    p.nom_produit,
    a.nom_agence,
    tm.date_transaction,
    t.montant_eur,
    t.type_operation,
    t.statut
FROM transactions t
JOIN comptes c ON t.id_compte = c.id_compte
JOIN clients cl ON c.id_client = cl.id_client
JOIN produits p ON t.id_produit = p.id_produit
JOIN agences a ON t.id_agence = a.id_agence
JOIN temps tm ON t.id_temps = tm.id_temps;