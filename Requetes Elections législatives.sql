#Partie IV: Evolution de la Base#

ALTER TABLE Candidat
MODIFY numdepot INT NOT NULL;

ALTER TABLE Election
MODIFY ID_Scrutin INT NOT NULL;

ALTER TABLE Bureau 
MODIFY numbureau INT NOT NULL;

#Partie V: Interrogation de la base#
#a# 

#L'ensemble des candidats regroupés par nom par ordre alphabetique#

SELECT Nom, Prenom
FROM Candidat
Group by Nom;

#Le nombre de votes que le candidat Axel DE BOER a eu lors de la premiere election#alter

SELECT nb_votes
FROM Votes INNER JOIN Candidat ON Votes.Ref_Candidat = Candidat.numdepot
WHERE Nom= 'DE BOER' AND Prenom= 'Axel' AND Ref_Election=1;

#L'ensemble des bureaux contenus dans la commune 75120 et 75103#

SELECT numbureau, code_commune_insee
FROM Bureau 
WHERE code_commune_insee IN (75120,75103);

#Nombre des inscrits pour les Européennes 2009#
SELECT Ref_election, nbinscrits 
FROM inscription 
WHERE Ref_election=1;

#Le nombre de votants pour la deuxieme election dans le bureau 3#

SELECT nbvotants
FROM Inscription INNER JOIN Election ON Inscription.Ref_Election = Election.ID_Scrutin
WHERE ID_Scrutin=2 AND Ref_Bureau=3;

#La date ou a eu lieu les Régionales 2eme tour#

SELECT date_du_scrutin
FROM Election 
WHERE libelle_du_scrutin="Régionales 2eme tour";

#Le nombre d'inscrits pour les 3 premieres elections#

SELECT nbinscrits, Ref_Election
FROM Inscription INNER JOIN Election ON Inscription.Ref_Election = Election.ID_Scrutin
WHERE ID_Scrutin BETWEEN 1 AND 3;

#Nombre des votes pour chaque candidat#
SELECT Nom,Prenom, Nb_votes 
FROM votes INNER JOIN candidat ON numdepot=Ref_candidat
GROUP BY Ref_candidat;

#Le nom et prenom du candidat 69#

SELECT Nom, Prenom
FROM Candidat
WHERE numdepot=69;

#Les identifiants des inscriptions qui ont eu un nombre de votants superieur à 1000#

SELECT Id_inscription, nbvotants
FROM inscription
WHERE nbvotants>1000;

#Nombre des votes pour chaque bureau de votes#
SELECT Ref_candidat, Nb_votes 
FROM votes INNER JOIN candidat on numdepot=Ref_candidat
ORDER BY Ref_bureau asc;

#Les numeros des bureaux dont le code postal est 75120#

SELECT *
FROM bureau
WHERE code_commune_insee=75120;

#b#

#Le plus grand nombre de votants de l'election 4#

SELECT MAX(nbvotants)
FROM Inscription INNER JOIN Election ON Inscription.Ref_Election= Election.Id_Scrutin
WHERE ID_Scrutin=4;

#La Moyenne du nombre d'inscrits lors du premier tour des legislatives 2012#

SELECT AVG(nbinscrits)
FROM Inscription INNER JOIN Election ON Inscription.Ref_Election=Election.Id_Scrutin
WHERE ID_Scrutin=3;

#Le nombre de votes que le candidat 9 a recu lors de la deuxieme election#

SELECT SUM(nb_votes)
FROM Votes INNER JOIN Candidat ON Votes.Ref_Candidat=Candidat.numdepot
WHERE numdepot=9 AND Ref_Election=2;

#Le plus petit nombre de votants lors de la premiere election#

SELECT MIN(nbvotants)
FROM Inscription INNER JOIN Election ON Inscription.Ref_Election=Election.ID_Scrutin
WHERE Ref_Election=1;

#Le nombre d'Elections qui ont eu lieu entre 2000 et 2010#

SELECT Count(*)
FROM Election
WHERE YEAR(date_du_scrutin) BETWEEN 2000 AND 2010;


#Somme des votes par chaque ID+creation table spécifique
SELECT Ref_Election,libelle_du_scrutin, sum(nb_votes) as somme_votes FROM votes join election on Ref_Election=ID_scrutin group by  Ref_Election ;
create table if not exists somme_votes ( 
Ref_Election varchar(300),
libelle_du_scrutin varchar(300),
somme_votes varchar(300)
);
insert into somme_votes SELECT Ref_Election,libelle_du_scrutin, sum(nb_votes) as somme_votes FROM votes join election on Ref_Election=ID_scrutin group by  Ref_Election ;

#Max des votes exprimes pour chaque ID+création table spécifique
create view max_votes as SELECT Ref_Election,libelle_du_scrutin, max(nb_votes) as max_votes FROM votes inner join election on Ref_Election=ID_scrutin
group by  Ref_Election ;

insert into max_votes SELECT Ref_Election,libelle_du_scrutin, max(nb_votes) as max_votes FROM votes join election on Ref_Election=ID_scrutin group by  Ref_Election ;

#Moyenne du nombre des votes pour chaque ID_scrutin
SELECT Ref_Election, libelle_du_scrutin, AVG(nbvotants) AS moyenne FROM inscription join election on Ref_Election=ID_scrutin
GROUP BY Ref_Election

#Le plus petit nombre de votes pour le candidat 8#

SELECT MIN(nb_votes)
FROM Votes INNER JOIN Candidat ON Votes.Ref_Candidat=Candidat.numdepot
WHERE Ref_Candidat=8;

#Le nombre total de votes du candidat 13

SELECT SUM(nb_votes)
FROM Votes INNER JOIN Candidat ON Votes.Ref_Candidat=Candidat.numdepot
WHERE Ref_Candidat=13;

#Partie VI: Mise a Jour de la base#
#a#

#Un Nouveau Candidat appele Martin TORRES est ajouté a ce modele#

INSERT INTO Candidat (numdepot, Nom, Prenom) VALUES (81,"TORRES","Martin");

SELECT *
FROM Candidat
WHERE numdepot=81;

#Ce candidat se presente a l'election 3 et recoit 500 votes dans le bureau 8#

INSERT INTO Votes (Ref_Election,Ref_Bureau,Ref_Candidat,nb_votes) VALUES (3,8,81,500);

SELECT *
FROM Votes
WHERE Ref_Candidat=81;

#b#
#On suppose que le candidat Francoise CASTANY s'est mariée avec Philippe PEJO et que maintenant son nom est CASTANY-PEJO#

UPDATE Candidat 
SET nom="CASTANY-PEJO"
WHERE numdepot=8;

SELECT *
FROM Candidat 
WHERE numdepot=8;

#Le 2eme tour des Regionales a été repporté de 1 jour et est mainetant le 22 mars 2020#

UPDATE Election
SET date_du_scrutin='2010-03-22'
WHERE ID_Scrutin=2;

SELECT *
FROM Election
WHERE libelle_du_scrutin="Régionales 2eme tour";

#L'inscription I1147 n'est pas prise en compte lors des elections #

DELETE FROM Inscription
WHERE Id_inscription="I1147";

SELECT *
FROM Inscription
WHERE Ref_Election=1;

#Le Nombre de votes du candidat 5 a été mal compté#
#3 votes n'ont pas été pris en compte initiellement#

UPDATE Votes
SET nb_votes=508
WHERE Ref_Candidat=5;

SELECT *
FROM Votes
WHERE Ref_Candidat=5;

#Lors d'un nouvelle analyse on se rend compte que le nombre de votants pour l'election 3 dans le bureau 5 ont ete mal comptes et sont 920#

UPDATE inscription
SET nbvotants=920
WHERE Id_inscription="I1019";

SELECT *
FROM inscription
WHERE Id_inscription="I1019";

#Le Candidat Maxime-Louis PERRUCA s'est trompé et a renseigné son 2eme prenom Louis, on soihaite que son prenom soit seulement Maxime#

UPDATE Candidat 
SET Prenom="Maxime"
WHERE numdepot=65;

SELECT *
FROM Candidat 
WHERE numdepot=65;


#On decide de ne pas prendre en compte les votes du candidat 18 pour toutes les elections dans tous les bureaux#

DELETE FROM Votes 
WHERE Ref_Candidat=18;

SELECT nb_votes
FROM Votes
WHERE Ref_Candidat=18;

#Le bureau 50 est situé hors de France et donc son code commune insee n'est pas renseigné#

UPDATE bureau
SET code_commune_insee=null
WHERE numbureau=50;

SELECT *
FROM Bureau
WHERE numbureau=50;



