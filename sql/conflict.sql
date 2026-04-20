-- =========================
-- INSERT DATA: SEGMENTS
-- =========================
INSERT INTO segments (id_segment, nom_segment) VALUES
(1, 'VIP'),
(2, 'Standard'),
(3, 'Risk')
ON CONFLICT (id_segment) DO NOTHING;
