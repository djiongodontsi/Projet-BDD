SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ===================== Référentiels =====================

DROP TABLE IF EXISTS specialite;
CREATE TABLE specialite (
  id_specialite INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(250) NOT NULL
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO specialite (id_specialite, nom) VALUES
(1, 'Informatique'),
(2, 'Mathematiques'),
(3, 'Business');

DROP TABLE IF EXISTS matiere;
CREATE TABLE matiere (
  id_matiere INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(250) NOT NULL
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO matiere (id_matiere, nom) VALUES
(1, 'Programmation'),
(2, 'Reseaux'),
(3, 'Algorithmique'),
(4, 'Marketing');

DROP TABLE IF EXISTS promotion;
CREATE TABLE promotion (
  id_promotion INT AUTO_INCREMENT PRIMARY KEY,
  annee VARCHAR(9) NOT NULL,
  id_specialite INT,
  FOREIGN KEY (id_specialite) REFERENCES specialite(id_specialite) ON DELETE SET NULL
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO promotion (id_promotion, annee, id_specialite) VALUES
(1, '2024-2025', 1),
(2, '2025-2026', 2);

-- ===================== Personnes =====================

DROP TABLE IF EXISTS eleve;
CREATE TABLE eleve (
  id_eleve INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(250) NOT NULL,
  prenom VARCHAR(250) NOT NULL,
  email VARCHAR(250) NOT NULL UNIQUE,
  age INT NOT NULL,
  motDePasse VARCHAR(250) NOT NULL,
  id_promotion INT,
  FOREIGN KEY (id_promotion) REFERENCES promotion(id_promotion) ON DELETE SET NULL
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO eleve (id_eleve, nom, prenom, email, age, motDePasse, id_promotion) VALUES
(1, 'Djiongo Dontsi', 'Dany Brel', 'dany.brel@ecole.fr', 20, 'mdp123', 2),
(2, 'Adam', 'Lucas', 'lucas.adam@ecole.fr', 19, 'mdp456', 2),
(3, 'Bernard', 'Emma', 'emma.bernard@ecole.fr', 21, 'mdp789', 1),
(4, 'Durand', '', 'durand@ecole.fr', 20, '', NULL);

DROP TABLE IF EXISTS prof;
CREATE TABLE prof (
  id_prof INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(250) NOT NULL,
  prenom VARCHAR(250) NOT NULL,
  email VARCHAR(250) NOT NULL UNIQUE
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO prof (id_prof, nom, prenom, email) VALUES
(1, 'Merbah', 'Yanis', 'yanis.merbah@ecole.fr'),
(2, 'Malblanc', 'Joacquim', 'joacquim.malblanc@ecole.fr'),
(3, 'Martin', 'Sophie', 'sophie.martin@ecole.fr');

DROP TABLE IF EXISTS dossier;
CREATE TABLE dossier (
  id_dossier INT AUTO_INCREMENT PRIMARY KEY,
  infos VARCHAR(2550) NOT NULL,
  avertissementTravail TINYINT(1) NOT NULL,
  avertissementComportement TINYINT(1) NOT NULL,
  id_eleve INT UNIQUE,
  FOREIGN KEY (id_eleve) REFERENCES eleve(id_eleve) ON DELETE CASCADE
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO dossier (id_dossier, infos, avertissementTravail, avertissementComportement, id_eleve) VALUES
(1, 'Bon eleve, participe beaucoup', 0, 0, 1),
(2, 'Retards frequents en debut d annee', 1, 0, 2),
(3, 'Excellent dossier scolaire', 0, 0, 3);

-- ===================== Cours =====================

DROP TABLE IF EXISTS cours;
CREATE TABLE cours (
  id_cours INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(250) NOT NULL,
  niveau INT NOT NULL DEFAULT 1,
  id_specialite INT,
  FOREIGN KEY (id_specialite) REFERENCES specialite(id_specialite) ON DELETE SET NULL
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO cours (id_cours, nom, niveau, id_specialite) VALUES
(1, 'Python les bases', 1, 1),
(2, 'Reseaux TCP/IP', 2, 1),
(3, 'Structures de donnees', 1, 1),
(4, 'Marketing digital', 3, 3);

DROP TABLE IF EXISTS prof_cours;
CREATE TABLE prof_cours (
  id_prof INT NOT NULL,
  id_cours INT NOT NULL,
  PRIMARY KEY (id_prof, id_cours),
  FOREIGN KEY (id_prof) REFERENCES prof(id_prof) ON DELETE CASCADE,
  FOREIGN KEY (id_cours) REFERENCES cours(id_cours) ON DELETE CASCADE
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO prof_cours (id_prof, id_cours) VALUES
(1, 1),
(2, 2),
(1, 3),
(3, 4);

DROP TABLE IF EXISTS instance_cours;
CREATE TABLE instance_cours (
  id_instanceCours INT AUTO_INCREMENT PRIMARY KEY,
  dateCours DATE NOT NULL,
  id_cours INT,
  id_promotion INT,
  FOREIGN KEY (id_cours) REFERENCES cours(id_cours) ON DELETE CASCADE,
  FOREIGN KEY (id_promotion) REFERENCES promotion(id_promotion) ON DELETE CASCADE
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO instance_cours (id_instanceCours, dateCours, id_cours, id_promotion) VALUES
(1, '2026-11-16', 1, 2),
(2, '2026-11-18', 2, 2),
(3, '2026-11-20', 3, 1);

DROP TABLE IF EXISTS note;
CREATE TABLE note (
  id_note INT AUTO_INCREMENT PRIMARY KEY,
  valeur INT,
  id_eleve INT,
  id_cours INT,
  id_prof INT,
  FOREIGN KEY (id_eleve) REFERENCES eleve(id_eleve) ON DELETE CASCADE,
  FOREIGN KEY (id_cours) REFERENCES cours(id_cours) ON DELETE CASCADE,
  FOREIGN KEY (id_prof) REFERENCES prof(id_prof) ON DELETE SET NULL
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO note (id_note, valeur, id_eleve, id_cours, id_prof) VALUES
(1, 16, 1, 1, 1),
(2, 12, 2, 1, 1),
(3, 18, 3, 3, 1),
(4, 14, 1, 3, 1),
(5, 15, 2, 2, 2);

DROP TABLE IF EXISTS absence;
CREATE TABLE absence (
  id_absence INT AUTO_INCREMENT PRIMARY KEY,
  dureeHeures INT NOT NULL,
  justificatifAbsence VARCHAR(2550),
  absenceTotal INT NOT NULL,
  id_eleve INT,
  id_instanceCours INT,
  FOREIGN KEY (id_eleve) REFERENCES eleve(id_eleve) ON DELETE CASCADE,
  FOREIGN KEY (id_instanceCours) REFERENCES instance_cours(id_instanceCours) ON DELETE CASCADE
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO absence (id_absence, dureeHeures, justificatifAbsence, absenceTotal, id_eleve, id_instanceCours) VALUES
(1, 2, 'Certificat medical', 2, 1, 1),
(2, 3, NULL, 3, 2, 2),
(3, 1, 'Rendez-vous familial', 1, 3, 3);

DROP TABLE IF EXISTS retard;
CREATE TABLE retard (
  id_retard INT AUTO_INCREMENT PRIMARY KEY,
  justificatifRetard VARCHAR(2550) NOT NULL,
  dureeMinutes INT NOT NULL,
  retardTotal INT NOT NULL,
  id_eleve INT,
  id_instanceCours INT,
  FOREIGN KEY (id_eleve) REFERENCES eleve(id_eleve) ON DELETE CASCADE,
  FOREIGN KEY (id_instanceCours) REFERENCES instance_cours(id_instanceCours) ON DELETE CASCADE
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO retard (id_retard, justificatifRetard, dureeMinutes, retardTotal, id_eleve, id_instanceCours) VALUES
(1, 'Transport en commun en panne', 15, 15, 2, 1),
(2, 'Aucun justificatif', 30, 30, 2, 2);

-- ===================== Bibliothèque =====================

DROP TABLE IF EXISTS carte_bibliotheque;
CREATE TABLE carte_bibliotheque (
  id_carteBibliotheque INT AUTO_INCREMENT PRIMARY KEY,
  numero INT NOT NULL,
  dateEmission DATE NOT NULL,
  active TINYINT(1) NOT NULL,
  id_eleve INT,
  FOREIGN KEY (id_eleve) REFERENCES eleve(id_eleve) ON DELETE CASCADE
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO carte_bibliotheque (id_carteBibliotheque, numero, dateEmission, active, id_eleve) VALUES
(1, 1001, '2026-09-01', 1, 1),
(2, 1002, '2026-09-01', 1, 2),
(3, 1003, '2025-09-05', 0, 3);

DROP TABLE IF EXISTS livre;
CREATE TABLE livre (
  id_livre VARCHAR(250) PRIMARY KEY,
  titre VARCHAR(250) NOT NULL,
  auteur VARCHAR(250) NOT NULL,
  niveau INT,
  nbExemplaires INT NOT NULL,
  id_matiere INT,
  FOREIGN KEY (id_matiere) REFERENCES matiere(id_matiere) ON DELETE SET NULL
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO livre (id_livre, titre, auteur, niveau, nbExemplaires, id_matiere) VALUES
('LIV001', 'Le Langage C', 'Dennis Ritchie', 1, 5, 1),
('LIV002', 'Reseaux', 'Andrew Tanenbaum', 2, 3, 2),
('LIV003', 'Introduction a l algorithmique', 'Thomas Cormen', 1, 4, 3),
('LIV004', 'Marketing Management', 'Philip Kotler', 3, 2, 4);

DROP TABLE IF EXISTS pret;
CREATE TABLE pret (
  id_pret INT AUTO_INCREMENT PRIMARY KEY,
  datePret DATE NOT NULL,
  dateRetourPrevue DATE NOT NULL,
  dateRetourEffective DATE,
  id_carteBibliotheque INT,
  id_livre VARCHAR(250),
  FOREIGN KEY (id_carteBibliotheque) REFERENCES carte_bibliotheque(id_carteBibliotheque) ON DELETE SET NULL,
  FOREIGN KEY (id_livre) REFERENCES livre(id_livre) ON DELETE SET NULL
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO pret (id_pret, datePret, dateRetourPrevue, dateRetourEffective, id_carteBibliotheque, id_livre) VALUES
(1, '2026-11-02', '2026-11-16', '2026-11-14', 1, 'LIV001'),
(2, '2026-11-10', '2026-11-24', '2026-11-23', 2, 'LIV003'),
(3, '2026-10-05', '2026-10-19', '2026-10-25', 3, 'LIV004');

DROP TABLE IF EXISTS renouvellement;
CREATE TABLE renouvellement (
  id_renouvellement INT AUTO_INCREMENT PRIMARY KEY,
  dateRenouvellement DATE NOT NULL,
  nouvelleDateRetourPrevue DATE NOT NULL,
  id_pret INT,
  FOREIGN KEY (id_pret) REFERENCES pret(id_pret) ON DELETE CASCADE
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO renouvellement (id_renouvellement, dateRenouvellement, nouvelleDateRetourPrevue, id_pret) VALUES
(1, '2026-11-14', '2026-11-30', 2);

SET FOREIGN_KEY_CHECKS = 1;
