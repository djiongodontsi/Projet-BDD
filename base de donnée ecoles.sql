-- ==========================================
-- 1. NETTOYAGE ET CRÉATION DE LA BASE
-- ==========================================
DROP DATABASE IF EXISTS `adam_frere_djiongo_dany_merbah_yanis_malblanc_joacquim`;
CREATE DATABASE `adam_frere_djiongo_dany_merbah_yanis_malblanc_joacquim` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `adam_frere_djiongo_dany_merbah_yanis_malblanc_joacquim`;

-- ==========================================
-- 2. CRÉATION DES TABLES (Conformes aux règles)
-- ==========================================

-- Tables de référence (sans dépendances)
CREATE TABLE `specialite` (
  `id_specialite` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_specialite`)
) ENGINE=InnoDB;

CREATE TABLE `prof` (
  `id_prof` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_prof`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB;

CREATE TABLE `matiere` (
  `id_matiere` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_matiere`)
) ENGINE=InnoDB;

-- Table promotion (avec la spécialité intégrée)
CREATE TABLE `promotion` (
  `id_promotion` int NOT NULL AUTO_INCREMENT,
  `annee` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_specialite` int DEFAULT NULL,
  PRIMARY KEY (`id_promotion`),
  CONSTRAINT `fk_promotion_specialite` FOREIGN KEY (`id_specialite`) REFERENCES `specialite`(`id_specialite`) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Table eleve (sans la spécialité)
CREATE TABLE `eleve` (
  `id_eleve` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `age` int NOT NULL,
  `motDePasse` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_promotion` int DEFAULT NULL,
  PRIMARY KEY (`id_eleve`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `fk_eleve_promotion` FOREIGN KEY (`id_promotion`) REFERENCES `promotion`(`id_promotion`) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Table cours (avec la spécialité, sans la matière)
CREATE TABLE `cours` (
  `id_cours` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `niveau` int NOT NULL DEFAULT '1',
  `id_specialite` int DEFAULT NULL,
  PRIMARY KEY (`id_cours`),
  CONSTRAINT `fk_cours_specialite` FOREIGN KEY (`id_specialite`) REFERENCES `specialite`(`id_specialite`) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Table de liaison Prof <-> Cours (N-N)
CREATE TABLE `prof_cours` (
  `id_prof` int NOT NULL,
  `id_cours` int NOT NULL,
  PRIMARY KEY (`id_prof`, `id_cours`),
  CONSTRAINT `fk_pc_prof` FOREIGN KEY (`id_prof`) REFERENCES `prof`(`id_prof`) ON DELETE CASCADE,
  CONSTRAINT `fk_pc_cours` FOREIGN KEY (`id_cours`) REFERENCES `cours`(`id_cours`) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Table instance_cours (sans le prof)
CREATE TABLE `instance_cours` (
  `id_instanceCours` int NOT NULL AUTO_INCREMENT,
  `dateCours` date NOT NULL,
  `id_cours` int DEFAULT NULL,
  `id_promotion` int DEFAULT NULL,
  PRIMARY KEY (`id_instanceCours`),
  CONSTRAINT `fk_ic_cours` FOREIGN KEY (`id_cours`) REFERENCES `cours`(`id_cours`) ON DELETE CASCADE,
  CONSTRAINT `fk_ic_promotion` FOREIGN KEY (`id_promotion`) REFERENCES `promotion`(`id_promotion`) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Table note (avec le prof)
CREATE TABLE `note` (
  `id_note` int NOT NULL AUTO_INCREMENT,
  `valeur` int DEFAULT NULL,
  `id_eleve` int DEFAULT NULL,
  `id_cours` int DEFAULT NULL,
  `id_prof` int DEFAULT NULL,
  PRIMARY KEY (`id_note`),
  CONSTRAINT `fk_note_eleve` FOREIGN KEY (`id_eleve`) REFERENCES `eleve`(`id_eleve`) ON DELETE CASCADE,
  CONSTRAINT `fk_note_cours` FOREIGN KEY (`id_cours`) REFERENCES `cours`(`id_cours`) ON DELETE CASCADE,
  CONSTRAINT `fk_note_prof` FOREIGN KEY (`id_prof`) REFERENCES `prof`(`id_prof`) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Table absence
CREATE TABLE `absence` (
  `id_absence` int NOT NULL AUTO_INCREMENT,
  `dureeHeures` int NOT NULL,
  `justificatifAbsence` varchar(2550) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `absenceTotal` int NOT NULL,
  `id_eleve` int DEFAULT NULL,
  `id_instanceCours` int DEFAULT NULL,
  PRIMARY KEY (`id_absence`),
  CONSTRAINT `fk_absence_eleve` FOREIGN KEY (`id_eleve`) REFERENCES `eleve`(`id_eleve`) ON DELETE CASCADE,
  CONSTRAINT `fk_absence_ic` FOREIGN KEY (`id_instanceCours`) REFERENCES `instance_cours`(`id_instanceCours`) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Table retard
CREATE TABLE `retard` (
  `id_retard` int NOT NULL AUTO_INCREMENT,
  `justificatifRetard` varchar(2550) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dureeMinutes` int NOT NULL,
  `retardTotal` int NOT NULL,
  `id_eleve` int DEFAULT NULL,
  `id_instanceCours` int DEFAULT NULL,
  PRIMARY KEY (`id_retard`),
  CONSTRAINT `fk_retard_eleve` FOREIGN KEY (`id_eleve`) REFERENCES `eleve`(`id_eleve`) ON DELETE CASCADE,
  CONSTRAINT `fk_retard_ic` FOREIGN KEY (`id_instanceCours`) REFERENCES `instance_cours`(`id_instanceCours`) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Table dossier
CREATE TABLE `dossier` (
  `id_dossier` int NOT NULL AUTO_INCREMENT,
  `infos` varchar(2550) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avertissementTravail` tinyint(1) NOT NULL,
  `avertissementComportement` tinyint(1) NOT NULL,
  `id_eleve` int DEFAULT NULL,
  PRIMARY KEY (`id_dossier`),
  UNIQUE KEY `id_eleve` (`id_eleve`),
  CONSTRAINT `fk_dossier_eleve` FOREIGN KEY (`id_eleve`) REFERENCES `eleve`(`id_eleve`) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Table livre (on garde la matière)
CREATE TABLE `livre` (
  `id_livre` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `titre` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `auteur` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `niveau` int DEFAULT NULL,
  `nbExemplaires` int NOT NULL,
  `id_matiere` int DEFAULT NULL,
  PRIMARY KEY (`id_livre`),
  CONSTRAINT `fk_livre_matiere` FOREIGN KEY (`id_matiere`) REFERENCES `matiere`(`id_matiere`) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Table carte_bibliotheque
CREATE TABLE `carte_bibliotheque` (
  `id_carteBibliotheque` int NOT NULL AUTO_INCREMENT,
  `numero` int NOT NULL,
  `dateEmission` date NOT NULL,
  `active` tinyint(1) NOT NULL,
  `id_eleve` int DEFAULT NULL,
  PRIMARY KEY (`id_carteBibliotheque`),
  CONSTRAINT `fk_carte_eleve` FOREIGN KEY (`id_eleve`) REFERENCES `eleve`(`id_eleve`) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Table pret
CREATE TABLE `pret` (
  `id_pret` int NOT NULL AUTO_INCREMENT,
  `datePret` date NOT NULL,
  `dateRetourPrevue` date NOT NULL,
  `dateRetourEffective` date DEFAULT NULL,
  `id_carteBibliotheque` int DEFAULT NULL,
  `id_livre` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_pret`),
  CONSTRAINT `fk_pret_carte` FOREIGN KEY (`id_carteBibliotheque`) REFERENCES `carte_bibliotheque`(`id_carteBibliotheque`) ON DELETE SET NULL,
  CONSTRAINT `fk_pret_livre` FOREIGN KEY (`id_livre`) REFERENCES `livre`(`id_livre`) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Table renouvellement
CREATE TABLE `renouvellement` (
  `id_renouvellement` int NOT NULL AUTO_INCREMENT,
  `dateRenouvellement` date NOT NULL,
  `nouvelleDateRetourPrevue` date NOT NULL,
  `id_pret` int DEFAULT NULL,
  PRIMARY KEY (`id_renouvellement`),
  CONSTRAINT `fk_renouv_pret` FOREIGN KEY (`id_pret`) REFERENCES `pret`(`id_pret`) ON DELETE CASCADE
) ENGINE=InnoDB;


-- ==========================================
-- 3. INSERTION DES DONNÉES (Cohérentes)
-- ==========================================

INSERT INTO `specialite` (`id_specialite`, `nom`) VALUES
(1, 'Informatique'), (2, 'Mathematiques'), (3, 'Business');

INSERT INTO `matiere` (`id_matiere`, `nom`) VALUES
(1, 'Programmation'), (2, 'Reseaux'), (3, 'Algorithmique'), (4, 'Marketing');

INSERT INTO `prof` (`id_prof`, `nom`, `prenom`, `email`) VALUES
(1, 'Merbah', 'Yanis', 'yanis.merbah@ecole.fr'),
(2, 'Malblanc', 'Joacquim', 'joacquim.malblanc@ecole.fr'),
(3, 'Martin', 'Sophie', 'sophie.martin@ecole.fr');

-- Promotions (Maintenant rattachées à une spécialité)
INSERT INTO `promotion` (`id_promotion`, `annee`, `id_specialite`) VALUES
(1, '2024-2025', 1), -- Promo 1 est en Informatique
(2, '2025-2026', 2); -- Promo 2 est en Mathématiques

-- Élèves (Plus de id_specialite, juste id_promotion)
INSERT INTO `eleve` (`id_eleve`, `nom`, `prenom`, `email`, `age`, `motDePasse`, `id_promotion`) VALUES
(1, 'Djiongo Dontsi', 'Dany Brel', 'dany.brel@ecole.fr', 20, 'mdp123', 2),
(2, 'Adam', 'Lucas', 'lucas.adam@ecole.fr', 19, 'mdp456', 2),
(3, 'Bernard', 'Emma', 'emma.bernard@ecole.fr', 21, 'mdp789', 1);

-- Cours (Rattachés à une spécialité)
INSERT INTO `cours` (`id_cours`, `nom`, `niveau`, `id_specialite`) VALUES
(1, 'Python les bases', 1, 1),
(2, 'Reseaux TCP/IP', 2, 1),
(3, 'Structures de donnees', 1, 1),
(4, 'Marketing digital', 3, 3);

-- Liaison Prof-Cours (Un cours peut avoir plusieurs profs, un prof plusieurs cours)
INSERT INTO `prof_cours` (`id_prof`, `id_cours`) VALUES
(1, 1), -- Yanis donne Python
(1, 3), -- Yanis donne Structures de données
(2, 2), -- Joacquim donne Réseaux
(3, 4); -- Sophie donne Marketing

-- Instances de cours (Plus de prof ici)
INSERT INTO `instance_cours` (`id_instanceCours`, `dateCours`, `id_cours`, `id_promotion`) VALUES
(1, '2026-11-16', 1, 2),
(2, '2026-11-18', 2, 2),
(3, '2026-11-20', 3, 1);

-- Notes (Avec l'id du prof qui a noté)
INSERT INTO `note` (`id_note`, `valeur`, `id_eleve`, `id_cours`, `id_prof`) VALUES
(1, 16, 1, 1, 1),
(2, 12, 2, 1, 1),
(3, 18, 3, 3, 1),
(4, 14, 1, 3, 1),
(5, 15, 2, 2, 2);

-- Dossiers
INSERT INTO `dossier` (`id_dossier`, `infos`, `avertissementTravail`, `avertissementComportement`, `id_eleve`) VALUES
(1, 'Bon eleve, participe beaucoup', 0, 0, 1),
(2, 'Retards frequents en debut d annee', 1, 0, 2),
(3, 'Excellent dossier scolaire', 0, 0, 3);

-- Absences
INSERT INTO `absence` (`id_absence`, `dureeHeures`, `justificatifAbsence`, `absenceTotal`, `id_eleve`, `id_instanceCours`) VALUES
(1, 2, 'Certificat medical', 2, 1, 1),
(2, 3, NULL, 3, 2, 2),
(3, 1, 'Rendez-vous familial', 1, 3, 3);

-- Retards
INSERT INTO `retard` (`id_retard`, `justificatifRetard`, `dureeMinutes`, `retardTotal`, `id_eleve`, `id_instanceCours`) VALUES
(1, 'Transport en commun en panne', 15, 15, 2, 1),
(2, 'Aucun justificatif', 30, 30, 2, 2);

-- Livres (On garde la matière pour les livres, c'est logique)
INSERT INTO `livre` (`id_livre`, `titre`, `auteur`, `niveau`, `nbExemplaires`, `id_matiere`) VALUES
('LIV001', 'Le Langage C', 'Dennis Ritchie', 1, 5, 1),
('LIV002', 'Reseaux', 'Andrew Tanenbaum', 2, 3, 2),
('LIV003', 'Introduction a l algorithmique', 'Thomas Cormen', 1, 4, 3),
('LIV004', 'Marketing Management', 'Philip Kotler', 3, 2, 4);

-- Cartes Bibliothèque
INSERT INTO `carte_bibliotheque` (`id_carteBibliotheque`, `numero`, `dateEmission`, `active`, `id_eleve`) VALUES
(1, 1001, '2026-09-01', 1, 1),
(2, 1002, '2026-09-01', 1, 2),
(3, 1003, '2025-09-05', 0, 3);

-- Prêts
INSERT INTO `pret` (`id_pret`, `datePret`, `dateRetourPrevue`, `dateRetourEffective`, `id_carteBibliotheque`, `id_livre`) VALUES
(1, '2026-11-02', '2026-11-16', '2026-11-14', 1, 'LIV001'),
(2, '2026-11-10', '2026-11-24', '2026-11-23', 2, 'LIV003'),
(3, '2026-10-05', '2026-10-19', '2026-10-25', 3, 'LIV004');

-- Renouvellements
INSERT INTO `renouvellement` (`id_renouvellement`, `dateRenouvellement`, `nouvelleDateRetourPrevue`, `id_pret`) VALUES
(1, '2026-11-14', '2026-11-30', 2);

COMMIT;