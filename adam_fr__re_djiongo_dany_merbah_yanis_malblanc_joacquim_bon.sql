-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 23, 2026 at 01:45 PM
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

-- --------------------------------------------------------

--
-- Table structure for table `cours`
--

DROP TABLE IF EXISTS `cours`;
CREATE TABLE IF NOT EXISTS `cours` (
  `id_cours` int NOT NULL,
  `nom` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `niveau` int NOT NULL DEFAULT (1),
  `id_matiere` int DEFAULT NULL,
  PRIMARY KEY (`id_cours`),
  KEY `fk_cours_matiere` (`id_matiere`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

-- --------------------------------------------------------

--
-- Table structure for table `livre`
--

DROP TABLE IF EXISTS `livre`;
CREATE TABLE IF NOT EXISTS `livre` (
  `id_livre` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `auteur` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `niveau` int DEFAULT NULL,
  `nbExemplaires` int NOT NULL,
  `id_matiere` int DEFAULT NULL,
  PRIMARY KEY (`id_livre`),
  KEY `fk_livre_matiere` (`id_matiere`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `matiere`
--

DROP TABLE IF EXISTS `matiere`;
CREATE TABLE IF NOT EXISTS `matiere` (
  `id_livre` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_livre`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
