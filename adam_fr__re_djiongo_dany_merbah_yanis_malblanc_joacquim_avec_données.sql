-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 23, 2026 at 02:06 PM
-- Server version: 8.4.7
-- PHP Version: 8.4.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `adam_frère_djiongo_dany_merbah_yanis_malblanc_joacquim`
--

-- --------------------------------------------------------

--
-- Table structure for table `absence`
--

DROP TABLE IF EXISTS `absence`;
CREATE TABLE IF NOT EXISTS `absence` (
  `id_absence` int NOT NULL,
  `duree_heure` int NOT NULL,
  `justificatif` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `absenceTotal` int NOT NULL,
  `id_eleve` int DEFAULT NULL,
  `id_instanceCours` int DEFAULT NULL,
  PRIMARY KEY (`id_absence`),
  KEY `fk_absence_eleve` (`id_eleve`),
  KEY `fk_absence_ic` (`id_instanceCours`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `absence`
--

INSERT INTO `absence` (`id_absence`, `duree_heure`, `justificatif`, `absenceTotal`, `id_eleve`, `id_instanceCours`) VALUES
(1, 2, 'Certificat medical', 2, 1, 1),
(2, 3, NULL, 3, 2, 2),
(3, 1, 'Rendez-vous familial', 1, 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `carte_bibliotheque`
--

DROP TABLE IF EXISTS `carte_bibliotheque`;
CREATE TABLE IF NOT EXISTS `carte_bibliotheque` (
  `id_carteBibliotheque` int NOT NULL,
  `numero` int NOT NULL,
  `dateEmission` date NOT NULL,
  `active` tinyint(1) NOT NULL,
  `id_eleve` int DEFAULT NULL,
  PRIMARY KEY (`id_carteBibliotheque`),
  KEY `fk_carte_eleve` (`id_eleve`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `carte_bibliotheque`
--

INSERT INTO `carte_bibliotheque` (`id_carteBibliotheque`, `numero`, `dateEmission`, `active`, `id_eleve`) VALUES
(1, 1001, '2026-09-01', 1, 1),
(2, 1002, '2026-09-01', 1, 2),
(3, 1003, '2025-09-05', 0, 3);

-- --------------------------------------------------------

--
-- Table structure for table `cours`
--

DROP TABLE IF EXISTS `cours`;
CREATE TABLE IF NOT EXISTS `cours` (
  `id_cours` int NOT NULL,
  `nom` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `niveau` int NOT NULL DEFAULT '1',
  `id_matiere` int DEFAULT NULL,
  PRIMARY KEY (`id_cours`),
  KEY `fk_cours_matiere` (`id_matiere`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cours`
--

INSERT INTO `cours` (`id_cours`, `nom`, `niveau`, `id_matiere`) VALUES
(1, 'Python les bases', 1, 1),
(2, 'Reseaux TCP/IP', 2, 2),
(3, 'Structures de donnees', 1, 3),
(4, 'Marketing digital', 3, 4);

-- --------------------------------------------------------

--
-- Table structure for table `dossier`
--

DROP TABLE IF EXISTS `dossier`;
CREATE TABLE IF NOT EXISTS `dossier` (
  `id_dossier` int NOT NULL,
  `infos` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `avertissementTravail` tinyint(1) NOT NULL,
  `avertissementComportement` tinyint(1) NOT NULL,
  `id_eleve` int DEFAULT NULL,
  PRIMARY KEY (`id_dossier`),
  UNIQUE KEY `id_eleve` (`id_eleve`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `dossier`
--

INSERT INTO `dossier` (`id_dossier`, `infos`, `avertissementTravail`, `avertissementComportement`, `id_eleve`) VALUES
(1, 'Bon eleve, participe beaucoup', 0, 0, 1),
(2, 'Retards frequents en debut d annee', 1, 0, 2),
(3, 'Excellent dossier scolaire', 0, 0, 3);

-- --------------------------------------------------------

--
-- Table structure for table `eleve`
--

DROP TABLE IF EXISTS `eleve`;
CREATE TABLE IF NOT EXISTS `eleve` (
  `id_eleve` int NOT NULL,
  `nom` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `age` int NOT NULL,
  `motDePasse` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_promotion` int DEFAULT NULL,
  `id_specialite` int DEFAULT NULL,
  PRIMARY KEY (`id_eleve`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_eleve_promotion` (`id_promotion`),
  KEY `fk_eleve_specialite` (`id_specialite`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `eleve`
--

INSERT INTO `eleve` (`id_eleve`, `nom`, `prenom`, `email`, `age`, `motDePasse`, `id_promotion`, `id_specialite`) VALUES
(1, 'Djiongo Dontsi', 'Dany Brel', 'dany.brel@ecole.fr', 20, 'mdp123', 2, 1),
(2, 'Adam', 'Lucas', 'lucas.adam@ecole.fr', 19, 'mdp456', 2, 1),
(3, 'Bernard', 'Emma', 'emma.bernard@ecole.fr', 21, 'mdp789', 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `instance_cours`
--

DROP TABLE IF EXISTS `instance_cours`;
CREATE TABLE IF NOT EXISTS `instance_cours` (
  `id_instanceCours` int NOT NULL,
  `dateCours` date NOT NULL,
  `id_cours` int DEFAULT NULL,
  `id_prof` int DEFAULT NULL,
  `id_promotion` int DEFAULT NULL,
  PRIMARY KEY (`id_instanceCours`),
  KEY `fk_ic_cours` (`id_cours`),
  KEY `fk_ic_prof` (`id_prof`),
  KEY `fk_ic_promotion` (`id_promotion`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `instance_cours`
--

INSERT INTO `instance_cours` (`id_instanceCours`, `dateCours`, `id_cours`, `id_prof`, `id_promotion`) VALUES
(1, '2026-11-16', 1, 1, 2),
(2, '2026-11-18', 2, 2, 2),
(3, '2026-11-20', 3, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `livre`
--

DROP TABLE IF EXISTS `livre`;
CREATE TABLE IF NOT EXISTS `livre` (
  `id_livre` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `auteur` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `niveau` int DEFAULT NULL,
  `nbExemplaires` int NOT NULL,
  `id_matiere` int DEFAULT NULL,
  PRIMARY KEY (`id_livre`),
  KEY `fk_livre_matiere` (`id_matiere`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `livre`
--

INSERT INTO `livre` (`id_livre`, `auteur`, `niveau`, `nbExemplaires`, `id_matiere`) VALUES
('LIV001', 'Dennis Ritchie', 1, 5, 1),
('LIV002', 'Andrew Tanenbaum', 2, 3, 2),
('LIV003', 'Thomas Cormen', 1, 4, 3),
('LIV004', 'Philip Kotler', 3, 2, 4);

-- --------------------------------------------------------

--
-- Table structure for table `matiere`
--

DROP TABLE IF EXISTS `matiere`;
CREATE TABLE IF NOT EXISTS `matiere` (
  `id_matiere` int NOT NULL,
  `nom` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_matiere`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `matiere`
--

INSERT INTO `matiere` (`id_matiere`, `nom`) VALUES
(1, 'Programmation'),
(2, 'Reseaux'),
(3, 'Algorithmique'),
(4, 'Marketing');

-- --------------------------------------------------------

--
-- Table structure for table `note`
--

DROP TABLE IF EXISTS `note`;
CREATE TABLE IF NOT EXISTS `note` (
  `id_note` int NOT NULL,
  `valeur` int DEFAULT NULL,
  `id_eleve` int DEFAULT NULL,
  `id_cours` int DEFAULT NULL,
  PRIMARY KEY (`id_note`),
  KEY `fk_note_eleve` (`id_eleve`),
  KEY `fk_note_cours` (`id_cours`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `note`
--

INSERT INTO `note` (`id_note`, `valeur`, `id_eleve`, `id_cours`) VALUES
(1, 16, 1, 1),
(2, 12, 2, 1),
(3, 18, 3, 3),
(4, 14, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `pret`
--

DROP TABLE IF EXISTS `pret`;
CREATE TABLE IF NOT EXISTS `pret` (
  `id_pret` int NOT NULL,
  `datePret` date NOT NULL,
  `dateRetourPrevue` date NOT NULL,
  `dateRetourEffective` date NOT NULL,
  `id_carteBibliotheque` int DEFAULT NULL,
  `id_livre` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_pret`),
  KEY `fk_pret_carte` (`id_carteBibliotheque`),
  KEY `fk_pret_livre` (`id_livre`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pret`
--

INSERT INTO `pret` (`id_pret`, `datePret`, `dateRetourPrevue`, `dateRetourEffective`, `id_carteBibliotheque`, `id_livre`) VALUES
(1, '2026-11-02', '2026-11-16', '2026-11-14', 1, 'LIV001'),
(2, '2026-11-10', '2026-11-24', '2026-11-23', 2, 'LIV003'),
(3, '2026-10-05', '2026-10-19', '2026-10-25', 3, 'LIV004');

-- --------------------------------------------------------

--
-- Table structure for table `prof`
--

DROP TABLE IF EXISTS `prof`;
CREATE TABLE IF NOT EXISTS `prof` (
  `id_prof` int NOT NULL,
  `nom` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_prof`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `prof`
--

INSERT INTO `prof` (`id_prof`, `nom`, `prenom`, `email`) VALUES
(1, 'Merbah', 'Yanis', 'yanis.merbah@ecole.fr'),
(2, 'Malblanc', 'Joacquim', 'joacquim.malblanc@ecole.fr'),
(3, 'Martin', 'Sophie', 'sophie.martin@ecole.fr');

-- --------------------------------------------------------

--
-- Table structure for table `promotion`
--

DROP TABLE IF EXISTS `promotion`;
CREATE TABLE IF NOT EXISTS `promotion` (
  `id_promotion` int NOT NULL,
  `annee` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_promotion`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `promotion`
--

INSERT INTO `promotion` (`id_promotion`, `annee`) VALUES
(1, '2024-2025'),
(2, '2025-2026');

-- --------------------------------------------------------

--
-- Table structure for table `renouvellement`
--

DROP TABLE IF EXISTS `renouvellement`;
CREATE TABLE IF NOT EXISTS `renouvellement` (
  `id_renouvellement` int NOT NULL,
  `dateRenouvellement` date NOT NULL,
  `nouvelleDateRetourPrevue` date NOT NULL,
  `id_pret` int DEFAULT NULL,
  PRIMARY KEY (`id_renouvellement`),
  KEY `fk_renouv_pret` (`id_pret`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `renouvellement`
--

INSERT INTO `renouvellement` (`id_renouvellement`, `dateRenouvellement`, `nouvelleDateRetourPrevue`, `id_pret`) VALUES
(1, '2026-11-14', '2026-11-30', 2);

-- --------------------------------------------------------

--
-- Table structure for table `retard`
--

DROP TABLE IF EXISTS `retard`;
CREATE TABLE IF NOT EXISTS `retard` (
  `id_retard` int NOT NULL,
  `justificatifRetard` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dureeMinutes` int NOT NULL,
  `retardTotal` int NOT NULL,
  `id_eleve` int DEFAULT NULL,
  `id_instanceCours` int DEFAULT NULL,
  PRIMARY KEY (`id_retard`),
  KEY `fk_retard_eleve` (`id_eleve`),
  KEY `fk_retard_ic` (`id_instanceCours`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `retard`
--

INSERT INTO `retard` (`id_retard`, `justificatifRetard`, `dureeMinutes`, `retardTotal`, `id_eleve`, `id_instanceCours`) VALUES
(1, 'Transport en commun en panne', 15, 15, 2, 1),
(2, 'Aucun justificatif', 30, 30, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `specialite`
--

DROP TABLE IF EXISTS `specialite`;
CREATE TABLE IF NOT EXISTS `specialite` (
  `id_specialite` int NOT NULL,
  `nom` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_specialite`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `specialite`
--

INSERT INTO `specialite` (`id_specialite`, `nom`) VALUES
(1, 'Informatique'),
(2, 'Mathematiques'),
(3, 'Business');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cours`
--
ALTER TABLE `cours`
  ADD CONSTRAINT `fk_cours_matiere` FOREIGN KEY (`id_matiere`) REFERENCES `matiere` (`id_matiere`);

--
-- Constraints for table `livre`
--
ALTER TABLE `livre`
  ADD CONSTRAINT `fk_livre_matiere` FOREIGN KEY (`id_matiere`) REFERENCES `matiere` (`id_matiere`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
