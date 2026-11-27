-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 27 nov. 2026 à 08:09
-- Version du serveur : 8.4.7
-- Version de PHP : 8.4.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `adam_frère_djiongo_dany_merbah_yanis_malblanc_joacquim`
--

-- --------------------------------------------------------

--
-- Structure de la table `absence`
--

DROP TABLE IF EXISTS `absence`;
CREATE TABLE IF NOT EXISTS `absence` (
  `id_absence` int NOT NULL AUTO_INCREMENT,
  `dureeHeures` int NOT NULL,
  `justificatifAbsence` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `absenceTotal` int NOT NULL,
  `id_eleve` int DEFAULT NULL,
  `id_instanceCours` int DEFAULT NULL,
  PRIMARY KEY (`id_absence`),
  KEY `fk_absence_eleve` (`id_eleve`),
  KEY `fk_absence_ic` (`id_instanceCours`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `absence`
--

INSERT INTO `absence` (`id_absence`, `dureeHeures`, `justificatifAbsence`, `absenceTotal`, `id_eleve`, `id_instanceCours`) VALUES
(1, 2, 'Certificat medical', 2, 1, 1),
(2, 3, NULL, 3, 2, 2),
(3, 1, 'Rendez-vous familial', 1, 3, 3);

-- --------------------------------------------------------

--
-- Structure de la table `carte_bibliotheque`
--

DROP TABLE IF EXISTS `carte_bibliotheque`;
CREATE TABLE IF NOT EXISTS `carte_bibliotheque` (
  `id_carteBibliotheque` int NOT NULL AUTO_INCREMENT,
  `numero` int NOT NULL,
  `dateEmission` date NOT NULL,
  `active` tinyint(1) NOT NULL,
  `id_eleve` int DEFAULT NULL,
  PRIMARY KEY (`id_carteBibliotheque`),
  KEY `fk_carte_eleve` (`id_eleve`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `carte_bibliotheque`
--

INSERT INTO `carte_bibliotheque` (`id_carteBibliotheque`, `numero`, `dateEmission`, `active`, `id_eleve`) VALUES
(1, 1001, '2026-09-01', 1, 1),
(2, 1002, '2026-09-01', 1, 2),
(3, 1003, '2025-09-05', 0, 3);

-- --------------------------------------------------------

--
-- Structure de la table `cours`
--

DROP TABLE IF EXISTS `cours`;
CREATE TABLE IF NOT EXISTS `cours` (
  `id_cours` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `niveau` int NOT NULL DEFAULT '1',
  `id_specialite` int DEFAULT NULL,
  PRIMARY KEY (`id_cours`),
  KEY `fk_cours_specialite` (`id_specialite`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cours`
--

INSERT INTO `cours` (`id_cours`, `nom`, `niveau`, `id_specialite`) VALUES
(1, 'Python les bases', 1, 1),
(2, 'Reseaux TCP/IP', 2, 1),
(3, 'Structures de donnees', 1, 1),
(4, 'Marketing digital', 3, 3);

-- --------------------------------------------------------

--
-- Structure de la table `dossier`
--

DROP TABLE IF EXISTS `dossier`;
CREATE TABLE IF NOT EXISTS `dossier` (
  `id_dossier` int NOT NULL AUTO_INCREMENT,
  `infos` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `avertissementTravail` tinyint(1) NOT NULL,
  `avertissementComportement` tinyint(1) NOT NULL,
  `id_eleve` int DEFAULT NULL,
  PRIMARY KEY (`id_dossier`),
  UNIQUE KEY `id_eleve` (`id_eleve`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `dossier`
--

INSERT INTO `dossier` (`id_dossier`, `infos`, `avertissementTravail`, `avertissementComportement`, `id_eleve`) VALUES
(1, 'Bon eleve, participe beaucoup', 0, 0, 1),
(2, 'Retards frequents en debut d annee', 1, 0, 2),
(3, 'Excellent dossier scolaire', 0, 0, 3);

-- --------------------------------------------------------

--
-- Structure de la table `eleve`
--

DROP TABLE IF EXISTS `eleve`;
CREATE TABLE IF NOT EXISTS `eleve` (
  `id_eleve` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `age` int NOT NULL,
  `motDePasse` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_promotion` int DEFAULT NULL,
  PRIMARY KEY (`id_eleve`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_eleve_promotion` (`id_promotion`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `eleve`
--

INSERT INTO `eleve` (`id_eleve`, `nom`, `prenom`, `email`, `age`, `motDePasse`, `id_promotion`) VALUES
(1, 'Djiongo Dontsi', 'Dany Brel', 'dany.brel@ecole.fr', 20, 'mdp123', 2),
(2, 'Adam', 'Lucas', 'lucas.adam@ecole.fr', 19, 'mdp456', 2),
(3, 'Bernard', 'Emma', 'emma.bernard@ecole.fr', 21, 'mdp789', 1);

-- --------------------------------------------------------

--
-- Structure de la table `instance_cours`
--

DROP TABLE IF EXISTS `instance_cours`;
CREATE TABLE IF NOT EXISTS `instance_cours` (
  `id_instanceCours` int NOT NULL AUTO_INCREMENT,
  `dateCours` date NOT NULL,
  `id_cours` int DEFAULT NULL,
  `id_promotion` int DEFAULT NULL,
  PRIMARY KEY (`id_instanceCours`),
  KEY `fk_ic_cours` (`id_cours`),
  KEY `fk_ic_promotion` (`id_promotion`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `instance_cours`
--

INSERT INTO `instance_cours` (`id_instanceCours`, `dateCours`, `id_cours`, `id_promotion`) VALUES
(1, '2026-11-16', 1, 2),
(2, '2026-11-18', 2, 2),
(3, '2026-11-20', 3, 1);

-- --------------------------------------------------------

--
-- Structure de la table `livre`
--

DROP TABLE IF EXISTS `livre`;
CREATE TABLE IF NOT EXISTS `livre` (
  `id_livre` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `titre` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `auteur` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `niveau` int DEFAULT NULL,
  `nbExemplaires` int NOT NULL,
  `id_matiere` int DEFAULT NULL,
  PRIMARY KEY (`id_livre`),
  KEY `fk_livre_matiere` (`id_matiere`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `livre`
--

INSERT INTO `livre` (`id_livre`, `titre`, `auteur`, `niveau`, `nbExemplaires`, `id_matiere`) VALUES
('LIV001', 'Le Langage C', 'Dennis Ritchie', 1, 5, 1),
('LIV002', 'Reseaux', 'Andrew Tanenbaum', 2, 3, 2),
('LIV003', 'Introduction a l algorithmique', 'Thomas Cormen', 1, 4, 3),
('LIV004', 'Marketing Management', 'Philip Kotler', 3, 2, 4);

-- --------------------------------------------------------

--
-- Structure de la table `matiere`
--

DROP TABLE IF EXISTS `matiere`;
CREATE TABLE IF NOT EXISTS `matiere` (
  `id_matiere` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_matiere`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `matiere`
--

INSERT INTO `matiere` (`id_matiere`, `nom`) VALUES
(1, 'Programmation'),
(2, 'Reseaux'),
(3, 'Algorithmique'),
(4, 'Marketing');

-- --------------------------------------------------------

--
-- Structure de la table `note`
--

DROP TABLE IF EXISTS `note`;
CREATE TABLE IF NOT EXISTS `note` (
  `id_note` int NOT NULL AUTO_INCREMENT,
  `valeur` int DEFAULT NULL,
  `id_eleve` int DEFAULT NULL,
  `id_cours` int DEFAULT NULL,
  `id_prof` int DEFAULT NULL,
  PRIMARY KEY (`id_note`),
  KEY `fk_note_eleve` (`id_eleve`),
  KEY `fk_note_cours` (`id_cours`),
  KEY `fk_note_prof` (`id_prof`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `note`
--

INSERT INTO `note` (`id_note`, `valeur`, `id_eleve`, `id_cours`, `id_prof`) VALUES
(1, 16, 1, 1, 1),
(2, 12, 2, 1, 1),
(3, 18, 3, 3, 1),
(4, 14, 1, 3, 1),
(5, 15, 2, 2, 2);

-- --------------------------------------------------------

--
-- Structure de la table `pret`
--

DROP TABLE IF EXISTS `pret`;
CREATE TABLE IF NOT EXISTS `pret` (
  `id_pret` int NOT NULL AUTO_INCREMENT,
  `datePret` date NOT NULL,
  `dateRetourPrevue` date NOT NULL,
  `dateRetourEffective` date DEFAULT NULL,
  `id_carteBibliotheque` int DEFAULT NULL,
  `id_livre` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_pret`),
  KEY `fk_pret_carte` (`id_carteBibliotheque`),
  KEY `fk_pret_livre` (`id_livre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `pret`
--

INSERT INTO `pret` (`id_pret`, `datePret`, `dateRetourPrevue`, `dateRetourEffective`, `id_carteBibliotheque`, `id_livre`) VALUES
(1, '2026-11-02', '2026-11-16', '2026-11-14', 1, 'LIV001'),
(2, '2026-11-10', '2026-11-24', '2026-11-23', 2, 'LIV003'),
(3, '2026-10-05', '2026-10-19', '2026-10-25', 3, 'LIV004');

-- --------------------------------------------------------

--
-- Structure de la table `prof`
--

DROP TABLE IF EXISTS `prof`;
CREATE TABLE IF NOT EXISTS `prof` (
  `id_prof` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_prof`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `prof`
--

INSERT INTO `prof` (`id_prof`, `nom`, `prenom`, `email`) VALUES
(1, 'Merbah', 'Yanis', 'yanis.merbah@ecole.fr'),
(2, 'Malblanc', 'Joacquim', 'joacquim.malblanc@ecole.fr'),
(3, 'Martin', 'Sophie', 'sophie.martin@ecole.fr');

-- --------------------------------------------------------

--
-- Structure de la table `prof_cours`
--

DROP TABLE IF EXISTS `prof_cours`;
CREATE TABLE IF NOT EXISTS `prof_cours` (
  `id_prof` int NOT NULL,
  `id_cours` int NOT NULL,
  PRIMARY KEY (`id_prof`,`id_cours`),
  KEY `fk_pc_cours` (`id_cours`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `prof_cours`
--

INSERT INTO `prof_cours` (`id_prof`, `id_cours`) VALUES
(1, 1),
(2, 2),
(1, 3),
(3, 4);

-- --------------------------------------------------------

--
-- Structure de la table `promotion`
--

DROP TABLE IF EXISTS `promotion`;
CREATE TABLE IF NOT EXISTS `promotion` (
  `id_promotion` int NOT NULL AUTO_INCREMENT,
  `annee` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_specialite` int DEFAULT NULL,
  PRIMARY KEY (`id_promotion`),
  KEY `fk_promotion_specialite` (`id_specialite`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `promotion`
--

INSERT INTO `promotion` (`id_promotion`, `annee`, `id_specialite`) VALUES
(1, '2024-2025', 1),
(2, '2025-2026', 2);

-- --------------------------------------------------------

--
-- Structure de la table `renouvellement`
--

DROP TABLE IF EXISTS `renouvellement`;
CREATE TABLE IF NOT EXISTS `renouvellement` (
  `id_renouvellement` int NOT NULL AUTO_INCREMENT,
  `dateRenouvellement` date NOT NULL,
  `nouvelleDateRetourPrevue` date NOT NULL,
  `id_pret` int DEFAULT NULL,
  PRIMARY KEY (`id_renouvellement`),
  KEY `fk_renouv_pret` (`id_pret`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `renouvellement`
--

INSERT INTO `renouvellement` (`id_renouvellement`, `dateRenouvellement`, `nouvelleDateRetourPrevue`, `id_pret`) VALUES
(1, '2026-11-14', '2026-11-30', 2);

-- --------------------------------------------------------

--
-- Structure de la table `retard`
--

DROP TABLE IF EXISTS `retard`;
CREATE TABLE IF NOT EXISTS `retard` (
  `id_retard` int NOT NULL AUTO_INCREMENT,
  `justificatifRetard` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dureeMinutes` int NOT NULL,
  `retardTotal` int NOT NULL,
  `id_eleve` int DEFAULT NULL,
  `id_instanceCours` int DEFAULT NULL,
  PRIMARY KEY (`id_retard`),
  KEY `fk_retard_eleve` (`id_eleve`),
  KEY `fk_retard_ic` (`id_instanceCours`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `retard`
--

INSERT INTO `retard` (`id_retard`, `justificatifRetard`, `dureeMinutes`, `retardTotal`, `id_eleve`, `id_instanceCours`) VALUES
(1, 'Transport en commun en panne', 15, 15, 2, 1),
(2, 'Aucun justificatif', 30, 30, 2, 2);

-- --------------------------------------------------------

--
-- Structure de la table `specialite`
--

DROP TABLE IF EXISTS `specialite`;
CREATE TABLE IF NOT EXISTS `specialite` (
  `id_specialite` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_specialite`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `specialite`
--

INSERT INTO `specialite` (`id_specialite`, `nom`) VALUES
(1, 'Informatique'),
(2, 'Mathematiques'),
(3, 'Business');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `absence`
--
ALTER TABLE `absence`
  ADD CONSTRAINT `fk_absence_eleve` FOREIGN KEY (`id_eleve`) REFERENCES `eleve` (`id_eleve`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_absence_ic` FOREIGN KEY (`id_instanceCours`) REFERENCES `instance_cours` (`id_instanceCours`) ON DELETE CASCADE;

--
-- Contraintes pour la table `carte_bibliotheque`
--
ALTER TABLE `carte_bibliotheque`
  ADD CONSTRAINT `fk_carte_eleve` FOREIGN KEY (`id_eleve`) REFERENCES `eleve` (`id_eleve`) ON DELETE CASCADE;

--
-- Contraintes pour la table `cours`
--
ALTER TABLE `cours`
  ADD CONSTRAINT `fk_cours_specialite` FOREIGN KEY (`id_specialite`) REFERENCES `specialite` (`id_specialite`) ON DELETE SET NULL;

--
-- Contraintes pour la table `dossier`
--
ALTER TABLE `dossier`
  ADD CONSTRAINT `fk_dossier_eleve` FOREIGN KEY (`id_eleve`) REFERENCES `eleve` (`id_eleve`) ON DELETE CASCADE;

--
-- Contraintes pour la table `eleve`
--
ALTER TABLE `eleve`
  ADD CONSTRAINT `fk_eleve_promotion` FOREIGN KEY (`id_promotion`) REFERENCES `promotion` (`id_promotion`) ON DELETE SET NULL;

--
-- Contraintes pour la table `instance_cours`
--
ALTER TABLE `instance_cours`
  ADD CONSTRAINT `fk_ic_cours` FOREIGN KEY (`id_cours`) REFERENCES `cours` (`id_cours`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ic_promotion` FOREIGN KEY (`id_promotion`) REFERENCES `promotion` (`id_promotion`) ON DELETE CASCADE;

--
-- Contraintes pour la table `livre`
--
ALTER TABLE `livre`
  ADD CONSTRAINT `fk_livre_matiere` FOREIGN KEY (`id_matiere`) REFERENCES `matiere` (`id_matiere`) ON DELETE SET NULL;

--
-- Contraintes pour la table `note`
--
ALTER TABLE `note`
  ADD CONSTRAINT `fk_note_cours` FOREIGN KEY (`id_cours`) REFERENCES `cours` (`id_cours`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_note_eleve` FOREIGN KEY (`id_eleve`) REFERENCES `eleve` (`id_eleve`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_note_prof` FOREIGN KEY (`id_prof`) REFERENCES `prof` (`id_prof`) ON DELETE SET NULL;

--
-- Contraintes pour la table `pret`
--
ALTER TABLE `pret`
  ADD CONSTRAINT `fk_pret_carte` FOREIGN KEY (`id_carteBibliotheque`) REFERENCES `carte_bibliotheque` (`id_carteBibliotheque`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_pret_livre` FOREIGN KEY (`id_livre`) REFERENCES `livre` (`id_livre`) ON DELETE SET NULL;

--
-- Contraintes pour la table `prof_cours`
--
ALTER TABLE `prof_cours`
  ADD CONSTRAINT `fk_pc_cours` FOREIGN KEY (`id_cours`) REFERENCES `cours` (`id_cours`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pc_prof` FOREIGN KEY (`id_prof`) REFERENCES `prof` (`id_prof`) ON DELETE CASCADE;

--
-- Contraintes pour la table `promotion`
--
ALTER TABLE `promotion`
  ADD CONSTRAINT `fk_promotion_specialite` FOREIGN KEY (`id_specialite`) REFERENCES `specialite` (`id_specialite`) ON DELETE SET NULL;

--
-- Contraintes pour la table `renouvellement`
--
ALTER TABLE `renouvellement`
  ADD CONSTRAINT `fk_renouv_pret` FOREIGN KEY (`id_pret`) REFERENCES `pret` (`id_pret`) ON DELETE CASCADE;

--
-- Contraintes pour la table `retard`
--
ALTER TABLE `retard`
  ADD CONSTRAINT `fk_retard_eleve` FOREIGN KEY (`id_eleve`) REFERENCES `eleve` (`id_eleve`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_retard_ic` FOREIGN KEY (`id_instanceCours`) REFERENCES `instance_cours` (`id_instanceCours`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
