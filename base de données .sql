// creation de la base de données
CREATE DATABASE `adam_frere_djiongo_dany_merbah_yanis_malblanc_joacquim` 
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE `adam_frere_djiongo_dany_merbah_yanis_malblanc_joacquim`;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE TABLE `specialite` (
  `id_specialite` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_specialite`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table promotion
CREATE TABLE `promotion` (
  `id_promotion` int NOT NULL AUTO_INCREMENT,
  `annee` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_promotion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table matiere
CREATE TABLE `matiere` (
  `id_matiere` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_matiere`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table prof
CREATE TABLE `prof` (
  `id_prof` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_prof`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table eleve
CREATE TABLE `eleve` (
  `id_eleve` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `age` int NOT NULL,
  `motDePasse` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_promotion` int DEFAULT NULL,
  `id_specialite` int DEFAULT NULL,
  PRIMARY KEY (`id_eleve`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `fk_eleve_promotion` FOREIGN KEY (`id_promotion`) REFERENCES `promotion` (`id_promotion`) ON DELETE SET NULL,
  CONSTRAINT `fk_eleve_specialite` FOREIGN KEY (`id_specialite`) REFERENCES `specialite` (`id_specialite`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table cours
CREATE TABLE `cours` (
  `id_cours` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `niveau` int NOT NULL DEFAULT '1',
  `id_matiere` int DEFAULT NULL,
  PRIMARY KEY (`id_cours`),
  CONSTRAINT `fk_cours_matiere` FOREIGN KEY (`id_matiere`) REFERENCES `matiere` (`id_matiere`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table instance_cours
CREATE TABLE `instance_cours` (
  `id_instanceCours` int NOT NULL AUTO_INCREMENT,
  `dateCours` date NOT NULL,
  `id_cours` int DEFAULT NULL,
  `id_prof` int DEFAULT NULL,
  `id_promotion` int DEFAULT NULL,
  PRIMARY KEY (`id_instanceCours`),
  CONSTRAINT `fk_ic_cours` FOREIGN KEY (`id_cours`) REFERENCES `cours` (`id_cours`) ON DELETE CASCADE,
  CONSTRAINT `fk_ic_prof` FOREIGN KEY (`id_prof`) REFERENCES `prof` (`id_prof`) ON DELETE CASCADE,
  CONSTRAINT `fk_ic_promotion` FOREIGN KEY (`id_promotion`) REFERENCES `promotion` (`id_promotion`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table dossier
CREATE TABLE `dossier` (
  `id_dossier` int NOT NULL AUTO_INCREMENT,
  `infos` varchar(2550) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avertissementTravail` tinyint(1) NOT NULL,
  `avertissementComportement` tinyint(1) NOT NULL,
  `id_eleve` int DEFAULT NULL,
  PRIMARY KEY (`id_dossier`),
  UNIQUE KEY `id_eleve` (`id_eleve`),
  CONSTRAINT `fk_dossier_eleve` FOREIGN KEY (`id_eleve`) REFERENCES `eleve` (`id_eleve`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table note
CREATE TABLE `note` (
  `id_note` int NOT NULL AUTO_INCREMENT,
  `valeur` int DEFAULT NULL,
  `id_eleve` int DEFAULT NULL,
  `id_cours` int DEFAULT NULL,
  PRIMARY KEY (`id_note`),
  CONSTRAINT `fk_note_eleve` FOREIGN KEY (`id_eleve`) REFERENCES `eleve` (`id_eleve`) ON DELETE CASCADE,
  CONSTRAINT `fk_note_cours` FOREIGN KEY (`id_cours`) REFERENCES `cours` (`id_cours`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table absence
CREATE TABLE `absence` (
  `id_absence` int NOT NULL AUTO_INCREMENT,
  `dureeHeures` int NOT NULL,
  `justificatifAbsence` varchar(2550) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `absenceTotal` int NOT NULL,
  `id_eleve` int DEFAULT NULL,
  `id_instanceCours` int DEFAULT NULL,
  PRIMARY KEY (`id_absence`),
  CONSTRAINT `fk_absence_eleve` FOREIGN KEY (`id_eleve`) REFERENCES `eleve` (`id_eleve`) ON DELETE CASCADE,
  CONSTRAINT `fk_absence_ic` FOREIGN KEY (`id_instanceCours`) REFERENCES `instance_cours` (`id_instanceCours`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table retard
CREATE TABLE `retard` (
  `id_retard` int NOT NULL AUTO_INCREMENT,
  `justificatifRetard` varchar(2550) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dureeMinutes` int NOT NULL,
  `retardTotal` int NOT NULL,
  `id_eleve` int DEFAULT NULL,
  `id_instanceCours` int DEFAULT NULL,
  PRIMARY KEY (`id_retard`),
  CONSTRAINT `fk_retard_eleve` FOREIGN KEY (`id_eleve`) REFERENCES `eleve` (`id_eleve`) ON DELETE CASCADE,
  CONSTRAINT `fk_retard_ic` FOREIGN KEY (`id_instanceCours`) REFERENCES `instance_cours` (`id_instanceCours`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table carte_bibliotheque
CREATE TABLE `carte_bibliotheque` (
  `id_carteBibliotheque` int NOT NULL AUTO_INCREMENT,
  `numero` int NOT NULL,
  `dateEmission` date NOT NULL,
  `active` tinyint(1) NOT NULL,
  `id_eleve` int DEFAULT NULL,
  PRIMARY KEY (`id_carteBibliotheque`),
  CONSTRAINT `fk_carte_eleve` FOREIGN KEY (`id_eleve`) REFERENCES `eleve` (`id_eleve`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table livre
CREATE TABLE `livre` (
  `id_livre` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `titre` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `auteur` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `niveau` int DEFAULT NULL,
  `nbExemplaires` int NOT NULL,
  `id_matiere` int DEFAULT NULL,
  PRIMARY KEY (`id_livre`),
  CONSTRAINT `fk_livre_matiere` FOREIGN KEY (`id_matiere`) REFERENCES `matiere` (`id_matiere`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table pret
CREATE TABLE `pret` (
  `id_pret` int NOT NULL AUTO_INCREMENT,
  `datePret` date NOT NULL,
  `dateRetourPrevue` date NOT NULL,
  `dateRetourEffective` date DEFAULT NULL,
  `id_carteBibliotheque` int DEFAULT NULL,
  `id_livre` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_pret`),
  CONSTRAINT `fk_pret_carte` FOREIGN KEY (`id_carteBibliotheque`) REFERENCES `carte_bibliotheque` (`id_carteBibliotheque`) ON DELETE SET NULL,
  CONSTRAINT `fk_pret_livre` FOREIGN KEY (`id_livre`) REFERENCES `livre` (`id_livre`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table renouvellement
CREATE TABLE `renouvellement` (
  `id_renouvellement` int NOT NULL AUTO_INCREMENT,
  `dateRenouvellement` date NOT NULL,
  `nouvelleDateRetourPrevue` date NOT NULL,
  `id_pret` int DEFAULT NULL,
  PRIMARY KEY (`id_renouvellement`),
  CONSTRAINT `fk_renouv_pret` FOREIGN KEY (`id_pret`) REFERENCES `pret` (`id_pret`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


// données 
INSERT INTO `specialite` (`id_specialite`, `nom`) VALUES
(1, 'Informatique'), (2, 'Mathematiques'), (3, 'Business');

INSERT INTO `promotion` (`id_promotion`, `annee`) VALUES
(1, '2024-2025'), (2, '2025-2026');

INSERT INTO `matiere` (`id_matiere`, `nom`) VALUES
(1, 'Programmation'), (2, 'Reseaux'), (3, 'Algorithmique'), (4, 'Marketing'),
(5, 'Base de donnees'), (6, 'Gestion de projet');

INSERT INTO `prof` (`id_prof`, `nom`, `prenom`, `email`) VALUES
(1, 'Merbah', 'Yanis', 'yanis.merbah@ecole.fr'),
(2, 'Malblanc', 'Joacquim', 'joacquim.malblanc@ecole.fr'),
(3, 'Martin', 'Sophie', 'sophie.martin@ecole.fr');

-- Données des élèves
INSERT INTO `eleve` (`id_eleve`, `nom`, `prenom`, `email`, `age`, `motDePasse`, `id_promotion`, `id_specialite`) VALUES
(1, 'Djiongo Dontsi', 'Dany Brel', 'dany.brel@ecole.fr', 20, 'mdp123', 2, 1),
(2, 'Adam', 'Lucas', 'lucas.adam@ecole.fr', 19, 'mdp456', 2, 1),
(3, 'Bernard', 'Emma', 'emma.bernard@ecole.fr', 21, 'mdp789', 1, 2),
(4, 'Dupont', 'Marie', 'marie.dupont@ecole.fr', 20, 'mdp101', 1, 1),
(5, 'Lefevre', 'Thomas', 'thomas.lefevre@ecole.fr', 22, 'mdp102', 2, 2),
(6, 'Moreau', 'Chloe', 'chloe.moreau@ecole.fr', 19, 'mdp103', 2, 3),
(7, 'Garcia', 'Lucas', 'lucas.garcia@ecole.fr', 21, 'mdp104', 1, 1),
(8, 'Roux', 'Ines', 'ines.roux@ecole.fr', 20, 'mdp105', 2, 2),
(9, 'Faure', 'Hugo', 'hugo.faure@ecole.fr', 23, 'mdp106', 1, 3),
(10, 'Girard', 'Lea', 'lea.girard@ecole.fr', 18, 'mdp107', 2, 1);

-- Données de cours
INSERT INTO `cours` (`id_cours`, `nom`, `niveau`, `id_matiere`) VALUES
(1, 'Python les bases', 1, 1), (2, 'Reseaux TCP/IP', 2, 2),
(3, 'Structures de donnees', 1, 3), (4, 'Marketing digital', 3, 4),
(5, 'SQL avance', 2, 5), (6, 'Gestion de projet agile', 3, 6),
(7, 'Python avance', 2, 1), (8, 'Algorithmique avancee', 2, 3);

-- Données d'instances de cours
INSERT INTO `instance_cours` (`id_instanceCours`, `dateCours`, `id_cours`, `id_prof`, `id_promotion`) VALUES
(1, '2026-11-16', 1, 1, 2), (2, '2026-11-18', 2, 2, 2),
(3, '2026-11-20', 3, 3, 1), (4, '2026-11-17', 1, 1, 2),
(5, '2026-11-19', 4, 2, 1), (6, '2026-11-21', 5, 1, 2),
(7, '2026-11-23', 7, 1, 2), (8, '2026-11-24', 8, 3, 1),
(9, '2026-11-25', 6, 2, 2), (10, '2026-11-26', 3, 3, 1);

-- Données de dossiers
INSERT INTO `dossier` (`id_dossier`, `infos`, `avertissementTravail`, `avertissementComportement`, `id_eleve`) VALUES
(1, 'Bon eleve, participe beaucoup', 0, 0, 1),
(2, 'Retards frequents en debut d annee', 1, 0, 2),
(3, 'Excellent dossier scolaire', 0, 0, 3),
(4, 'Tres motivee, progression constante', 0, 0, 4),
(5, 'Difficultes en algorithmique', 1, 0, 5),
(6, 'Comportement exemplaire', 0, 0, 6),
(7, 'Absences repetees non justifiees', 1, 1, 7),
(8, 'Bonne participation orale', 0, 0, 8),
(9, 'Doit fournir plus d efforts', 1, 0, 9),
(10, 'Eleve serieux et rigoureux', 0, 0, 10);

-- Données de notes
INSERT INTO `note` (`id_note`, `valeur`, `id_eleve`, `id_cours`) VALUES
(1, 16, 1, 1), (2, 12, 2, 1), (3, 18, 3, 3), (4, 14, 1, 3),
(5, 15, 4, 1), (6, 9, 5, 1), (7, 17, 6, 3), (8, 11, 7, 1),
(9, 19, 8, 3), (10, 13, 9, 2), (11, 8, 10, 2), (12, 16, 4, 3),
(13, 14, 5, 3), (14, 20, 6, 1), (15, 10, 7, 2), (16, 12, 8, 1);

-- Données d'absences
INSERT INTO `absence` (`id_absence`, `dureeHeures`, `justificatifAbsence`, `absenceTotal`, `id_eleve`, `id_instanceCours`) VALUES
(1, 2, 'Certificat medical', 2, 1, 1),
(2, 3, NULL, 3, 2, 2),
(3, 1, 'Rendez-vous familial', 1, 3, 3),
(4, 4, 'Maladie', 4, 4, 5),
(5, 2, NULL, 2, 5, 6),
(6, 6, 'Probleme familial', 6, 6, 7),
(7, 1, NULL, 1, 7, 8),
(8, 3, 'Certificat medical', 3, 8, 9),
(9, 2, 'Rendez-vous medical', 2, 9, 10),
(10, 8, NULL, 8, 10, 4);

-- Données de retards
INSERT INTO `retard` (`id_retard`, `justificatifRetard`, `dureeMinutes`, `retardTotal`, `id_eleve`, `id_instanceCours`) VALUES
(1, 'Transport en commun en panne', 15, 15, 2, 1),
(2, 'Aucun justificatif', 30, 30, 2, 2),
(3, 'Embouteillage', 20, 20, 4, 4),
(4, 'Aucun justificatif', 45, 45, 5, 5),
(5, 'Reveil tardif', 10, 10, 6, 6),
(6, 'Transport en commun', 25, 25, 7, 7),
(7, 'Aucun justificatif', 60, 60, 8, 8),
(8, 'Rendez-vous medical', 15, 15, 9, 9),
(9, 'Aucun justificatif', 35, 35, 10, 10);

-- Données de cartes de bibliothèque
INSERT INTO `carte_bibliotheque` (`id_carteBibliotheque`, `numero`, `dateEmission`, `active`, `id_eleve`) VALUES
(1, 1001, '2026-09-01', 1, 1),
(2, 1002, '2026-09-01', 1, 2),
(3, 1003, '2025-09-05', 0, 3),
(4, 1004, '2026-09-01', 1, 4),
(5, 1005, '2026-09-02', 1, 5),
(6, 1006, '2026-09-02', 1, 6),
(7, 1007, '2025-09-10', 0, 7),
(8, 1008, '2026-09-03', 1, 8),
(9, 1009, '2026-09-03', 1, 9),
(10, 1010, '2026-09-04', 1, 10);

-- Données de livres (Avec ajout de la colonne Titre !)
INSERT INTO `livre` (`id_livre`, `titre`, `auteur`, `niveau`, `nbExemplaires`, `id_matiere`) VALUES
('LIV001', 'Le Langage C', 'Dennis Ritchie', 1, 5, 1),
('LIV002', 'Reseaux', 'Andrew Tanenbaum', 2, 3, 2),
('LIV003', 'Introduction a l algorithmique', 'Thomas Cormen', 1, 4, 3),
('LIV004', 'Marketing Management', 'Philip Kotler', 3, 2, 4),
('LIV005', 'Refactoring', 'Martin Fowler', 2, 4, 5),
('LIV006', 'Scrum et XP', 'Henrik Kniberg', 3, 2, 6),
('LIV007', 'Fluent Python', 'Luciano Ramalho', 2, 3, 1),
('LIV008', 'Algorithmes', 'Robert Sedgewick', 2, 5, 3),
('LIV009', 'Mathematics for CS', 'Kenneth Rosen', 1, 6, 2);

-- Données de prêts (Modifié : dateRetourEffective NULL pour les prêts en cours)
INSERT INTO `pret` (`id_pret`, `datePret`, `dateRetourPrevue`, `dateRetourEffective`, `id_carteBibliotheque`, `id_livre`) VALUES
(1, '2026-11-02', '2026-11-16', '2026-11-14', 1, 'LIV001'),
(2, '2026-11-10', '2026-11-24', '2026-11-23', 2, 'LIV003'),
(3, '2026-10-05', '2026-10-19', '2026-10-25', 3, 'LIV004'),
(4, '2026-11-05', '2026-11-19', '2026-11-18', 4, 'LIV005'),
(5, '2026-11-12', '2026-11-26', NULL, 5, 'LIV007'),          -- En cours
(6, '2026-10-01', '2026-10-15', '2026-10-20', 6, 'LIV002'),
(7, '2026-11-15', '2026-11-29', '2026-11-23', 8, 'LIV008'),
(8, '2026-11-20', '2026-12-04', NULL, 9, 'LIV003'),          -- En cours
(9, '2026-09-10', '2026-09-24', '2026-10-01', 10, 'LIV009');

-- Données de renouvellements
INSERT INTO `renouvellement` (`id_renouvellement`, `dateRenouvellement`, `nouvelleDateRetourPrevue`, `id_pret`) VALUES
(1, '2026-11-14', '2026-11-30', 2),
(2, '2026-11-22', '2026-12-07', 5),
(3, '2026-11-24', '2026-12-12', 8);

COMMIT;
-- Lecture de données : 
-- Liste des moyenne de chaque eleve de chaque cours :
SELECT 
    c.nom AS Nom_cours,
    e.nom AS Nom_eleve,
    AVG(n.valeur) AS Moyenne_Notes
FROM 
    cours c
JOIN note n ON n.id_cours = c.id_cours
JOIN eleve e ON e.id_eleve = n.id_eleve
GROUP BY 
    c.id_cours, c.nom, e.id_eleve, e.nom
ORDER BY 
    c.nom ASC, e.nom ASC;	
-- Liste des moyennes supérieur à 10 de chaque élève (nom), dans chaque cours (nom) dans l’ordre décroissant (bonus)
-- Requete
SELECT 
    e.nom           AS nom_eleve,
    c.nom           AS nom_cours,
    AVG(n.valeur)   AS moyenne
FROM note n
JOIN eleve e ON e.id_eleve = n.id_eleve
JOIN cours c ON c.id_cours = n.id_cours
GROUP BY e.id_eleve, e.nom, c.id_cours, c.nom
HAVING AVG(n.valeur) > 10
ORDER BY moyenne DESC;

--Ajouter des données :
-- Ajouter un nouveau prof : 
INSERT INTO prof (nom, email, age) VALUES ('Martin', 'martin@ecole.fr', 42);
-- Ajouter un nouveau cours :
INSERT INTO cours (nom, niveau, id_specialite) VALUES ('Réseaux avancés', 3, 2);
-- Ajouter un nouvel élève avec un dossier qui lui correspond
-- Le nouvel élève suit le nouveau cours
-- Le nouveau prof donne le nouveau cours
