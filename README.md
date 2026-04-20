# 📊 FinanceCore Data Warehouse Project

## 📌 Contexte du projet

Ce projet consiste à concevoir un **modèle relationnel normalisé (3NF)** pour un système bancaire, charger des données propres depuis `financecore_clean.csv` et effectuer des analyses SQL avancées avec PostgreSQL.

Le projet est organisé avec une architecture ETL + SQL + Docker.

---

## 🎯 Objectifs

- Concevoir un schéma relationnel normalisé (3NF)
- Identifier les entités : Clients, Comptes, Transactions, Produits, Agences, Segments
- Créer une base PostgreSQL avec contraintes d’intégrité
- Charger les données via SQLAlchemy
- Exécuter des requêtes SQL analytiques avancées
- Conteneuriser le projet avec Docker
- Utiliser `.env` pour la sécurité des variables sensibles

---

## 📁 Structure du projet
venv/
data/
financecore_clean.csv

include/site/python3.14/greenlet
Lib/

load/
config.cpython-314.pyc
load_data.ipynb

Scripts/

sql/
conflict.sql
indexes.sql
tables.sql
vérification.sql
view.sql

src/
.env
.gitignore
dbdiagram.io.png
docker-compose.yml
document
pyvenv.cfg
README.md
requirements.txt
## 📁Configuration .env
DB_HOST=host
DB_PORT=5433
DB_NAME=fin_db
DB_USER=postgres
DB_PASSWORD=mot_pass
## 🐳 Docker Setup
Lancement du projet :
docker-compose up --build