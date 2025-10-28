# Inception
# Inception

Ce projet a été réalisé dans le cadre du cursus 42.  
Il consiste à déployer une mini-infrastructure web sécurisée et automatisée à l’aide de Docker et Docker Compose, dans une machine virtuelle Debian.

## Objectif

- Déployer trois services principaux dans des conteneurs Docker distincts :
  - **NGINX** (avec SSL/TLS)
  - **WordPress** (avec PHP-FPM)
  - **MariaDB** (base de données)
- Orchestrer l’ensemble avec `docker-compose`.
- Respecter les bonnes pratiques de sécurité (variables d’environnement, Docker secrets, pas de mots de passe en clair).
- Utiliser des volumes persistants pour les données WordPress et MariaDB.
- Rendre l’application accessible via le nom de domaine local `login.42.fr`.

## Structure du projet

```
Inception/
├── Makefile
├── secrets/
├── srcs/
│   ├── .env
│   ├── docker-compose.yml
│   └── requirements/
│       ├── nginx/
│       ├── wordpress/
│       └── mariadb/
```

## Installation & utilisation

1. Cloner le dépôt dans votre VM Debian.
2. Adapter les variables d’environnement dans `srcs/.env`.
3. Lancer la stack avec :
   ```
   make
   ```
4. Accéder au site WordPress sécurisé via `https://login.42.fr`.

## Remarques

- Tous les fichiers sensibles sont stockés dans le dossier `secrets/` et ne doivent **jamais** être ajoutés au dépôt Git.
- Un fichier `.gitignore` est recommandé pour ignorer les secrets et les fichiers temporaires.

## Auteur

Tambinin
