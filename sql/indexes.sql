-- =========================
-- INDEX (performance)
-- =========================
CREATE INDEX IF NOT EXISTS idx_transactions_date 
ON transactions(id_temps);

CREATE INDEX IF NOT EXISTS idx_transactions_agence 
ON transactions(id_agence);

CREATE INDEX IF NOT EXISTS idx_transactions_compte 
ON transactions(id_compte);