-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : mar. 11 mars 2025 à 10:39
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `tp_api`
--

-- --------------------------------------------------------

--
-- Structure de la table `Notes`
--

CREATE TABLE `Notes` (
  `id_notes` int(11) NOT NULL,
  `nom_notes` varchar(45) NOT NULL,
  `date_ajout` timestamp NOT NULL DEFAULT current_timestamp(),
  `contenu_note` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `Notes`
--

INSERT INTO `Notes` (`id_notes`, `nom_notes`, `date_ajout`, `contenu_note`) VALUES
(1, 'Rediger dossier projet', '2025-03-11 09:26:30', 'Blabla faut faire le dossier'),
(2, 'FOURNIR MCD', '2025-03-11 09:28:36', 'FOURNIR MCD SVP'),
(3, 'mettre en place api', '2025-03-11 09:29:00', 'faire api svp vite');

-- --------------------------------------------------------

--
-- Structure de la table `Notes_has_Tags`
--

CREATE TABLE `Notes_has_Tags` (
  `Notes_id_notes` int(11) NOT NULL,
  `Tags_id_tags` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `Notes_has_Tags`
--

INSERT INTO `Notes_has_Tags` (`Notes_id_notes`, `Tags_id_tags`) VALUES
(1, 1),
(2, 2),
(3, 1),
(3, 3);

-- --------------------------------------------------------

--
-- Structure de la table `Tags`
--

CREATE TABLE `Tags` (
  `id_tags` int(11) NOT NULL,
  `nom_tags` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `Tags`
--

INSERT INTO `Tags` (`id_tags`, `nom_tags`) VALUES
(1, 'IMPORTANT'),
(2, 'URGENT'),
(3, 'EN COURS');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `Notes`
--
ALTER TABLE `Notes`
  ADD PRIMARY KEY (`id_notes`);

--
-- Index pour la table `Notes_has_Tags`
--
ALTER TABLE `Notes_has_Tags`
  ADD PRIMARY KEY (`Notes_id_notes`,`Tags_id_tags`),
  ADD KEY `fk_Notes_has_Tags_Tags1_idx` (`Tags_id_tags`),
  ADD KEY `fk_Notes_has_Tags_Notes_idx` (`Notes_id_notes`);

--
-- Index pour la table `Tags`
--
ALTER TABLE `Tags`
  ADD PRIMARY KEY (`id_tags`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `Notes`
--
ALTER TABLE `Notes`
  MODIFY `id_notes` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `Tags`
--
ALTER TABLE `Tags`
  MODIFY `id_tags` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `Notes_has_Tags`
--
ALTER TABLE `Notes_has_Tags`
  ADD CONSTRAINT `fk_Notes_has_Tags_Notes` FOREIGN KEY (`Notes_id_notes`) REFERENCES `Notes` (`id_notes`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Notes_has_Tags_Tags1` FOREIGN KEY (`Tags_id_tags`) REFERENCES `Tags` (`id_tags`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
