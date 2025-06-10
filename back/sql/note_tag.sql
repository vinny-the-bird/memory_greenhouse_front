-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 11 mars 2025 à 13:40
-- Version du serveur : 8.3.0
-- Version de PHP : 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `note_tag`
--

-- --------------------------------------------------------

--
-- Structure de la table `note`
--

DROP TABLE IF EXISTS `note`;
CREATE TABLE IF NOT EXISTS `note` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `note`
--

INSERT INTO `note` (`id`, `title`, `content`, `datetime`) VALUES
(1, 'Amélioration de l\'UX', 'J\'aimerais que l\'on continue la réflexion notre nouvelle UX. Le client a fait de nouveaux retours.', '2025-03-11 10:33:48'),
(2, 'MCD à revoir', 'Les MCD peuvent être améliorer. C\'est l\'occasion de faire un bon exercice avec les étudiants.', '2025-03-11 10:34:44'),
(3, 'Pas de café ce matin', 'Pensez bien à signaler quand le café est en basse quantité, qu\'on ai le temps de prévoir. Manque de chance on a plus de sacs en réserve, donc il faudra attendre cette après-midi.', '2025-03-11 10:35:42'),
(4, 'Sport ce soir avec Timéo', 'Le coach nous emmene nous courir à 18h', '2025-03-11 14:23:13');

-- --------------------------------------------------------

--
-- Structure de la table `tag`
--

DROP TABLE IF EXISTS `tag`;
CREATE TABLE IF NOT EXISTS `tag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `experimental` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `tag`
--

INSERT INTO `tag` (`id`, `name`, `experimental`) VALUES
(1, 'Interne', 0),
(2, 'Externe', 0),
(3, 'Frontend', 0),
(4, 'Backend', 0),
(5, 'Training', 0),
(6, 'Wellbeing', 0);

-- --------------------------------------------------------

--
-- Structure de la table `tag_by_note`
--

DROP TABLE IF EXISTS `tag_by_note`;
CREATE TABLE IF NOT EXISTS `tag_by_note` (
  `id_note` int NOT NULL,
  `id_tag` int NOT NULL,
  KEY `id_note` (`id_note`),
  KEY `id_tag` (`id_tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `tag_by_note`
--

INSERT INTO `tag_by_note` (`id_note`, `id_tag`) VALUES
(1, 1),
(1, 3),
(2, 5),
(3, 6),
(1, 5),
(2, 4);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `tag_by_note`
--
ALTER TABLE `tag_by_note`
  ADD CONSTRAINT `tag_by_note_ibfk_1` FOREIGN KEY (`id_note`) REFERENCES `note` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `tag_by_note_ibfk_2` FOREIGN KEY (`id_tag`) REFERENCES `tag` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
