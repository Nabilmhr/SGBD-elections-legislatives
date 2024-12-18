# SGBD-elections-legislatives
Projet : Analyse d'une Base de Données d'Élections Législatives

Ce projet consiste en une série de requêtes SQL et de modifications structurelles sur une base de données liée aux élections législatives. L'objectif est d'assurer l'évolution de la structure de la base et d'extraire des informations pertinentes pour l'analyse des résultats électoraux.

Objectifs

Amélioration de la structure de la base :

Modifications des colonnes pour renforcer les contraintes d'intégrité.

Optimisation de la base pour les futures interrogations.

Extraction de données électorales :

Analyse des candidats, des bureaux de vote, et des résultats électoraux.

Réponse à des questions spécifiques telles que le nombre de votes ou d'inscrits.

Structure des Requêtes

Partie 1 : Modifications de la Base

Tables modifiées :

Candidat : Modification de la colonne numdepot pour être non nulle.

Election : Modification de la colonne ID_Scrutin pour être non nulle.

Bureau : Modification de la colonne numbureau pour être non nulle.

Partie 2 : Interrogations de la Base

Extraction des informations telles que :

Liste des candidats triés par ordre alphabétique.

Nombre de votes obtenus par un candidat spécifique.

Détails sur les bureaux situés dans certaines communes.

Nombre d'inscrits et de votants pour des élections spécifiques.

Prérequis

Base de données : Une base structurée avec les tables suivantes :

Candidat

Election

Bureau

Votes

Inscription

Logiciel :

Serveur SQL (MySQL, PostgreSQL, etc.) ou outil de gestion de base de données compatible.
