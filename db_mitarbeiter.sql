-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Erstellungszeit: 05. Jul 2021 um 18:06
-- Server-Version: 10.4.11-MariaDB
-- PHP-Version: 7.4.6
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
--
-- Datenbank: `db_mitarbeiterverwaltung`
--
619
-- --------------------------------------------------------
--
-- Tabellenstruktur für Tabelle `tbl_gehaltsniveaus`
--
CREATE TABLE `tbl_gehaltsniveaus` (
 `IDGehaltsniveau` int(10) UNSIGNED NOT NULL,
 `Bezeichnung` varchar(64) NOT NULL,
 `Stufe` tinyint(2) UNSIGNED NOT NULL,
 `Beschreibung` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- --------------------------------------------------------
--
-- Tabellenstruktur für Tabelle `tbl_geschlechter`
--
CREATE TABLE `tbl_geschlechter` (
 `IDGeschlecht` int(10) UNSIGNED NOT NULL,
 `Bezeichnung` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- --------------------------------------------------------
--
-- Tabellenstruktur für Tabelle `tbl_marken`
--
CREATE TABLE `tbl_marken` (
 `IDMarke` int(10) UNSIGNED NOT NULL,
 `Bezeichnung` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- --------------------------------------------------------
--
-- Tabellenstruktur für Tabelle `tbl_mitarbeiter`
--
CREATE TABLE `tbl_mitarbeiter` (
 `IDMitarbeiter` int(10) UNSIGNED NOT NULL,
620
 `FIDVorgesetzter` int(10) UNSIGNED DEFAULT NULL,
 `Titel` varchar(64) DEFAULT NULL,
 `Vorname` varchar(32) NOT NULL,
 `Nachname` varchar(64) NOT NULL,
 `GebDatum` date NOT NULL,
 `FIDGeschlecht` int(10) UNSIGNED NOT NULL,
 `Eintrittsdatum` date NOT NULL,
 `Austrittsdatum` date DEFAULT NULL,
 `FIDGehaltsniveau` int(10) UNSIGNED NOT NULL,
 `Gehalt` double(10,2) NOT NULL,
 `TelPrivat` varchar(32) DEFAULT NULL,
 `TelDienstlich` varchar(32) NOT NULL,
 `Notizen` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- --------------------------------------------------------
--
-- Tabellenstruktur für Tabelle `tbl_mobiltelefone`
--
CREATE TABLE `tbl_mobiltelefone` (
 `IDMobiltelefon` int(10) UNSIGNED NOT NULL,
 `IMEI` varchar(16) NOT NULL,
 `Telefonnummer` varchar(32) NOT NULL,
 `FIDMarke` int(10) UNSIGNED NOT NULL,
 `Typ` varchar(32) NOT NULL,
 `Notizen` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- --------------------------------------------------------
--
-- Tabellenstruktur für Tabelle `tbl_mobiltelefone_mitarbeiter`
--
CREATE TABLE `tbl_mobiltelefone_mitarbeiter` (
 `IDMobiltelefonMitarbeiter` int(10) UNSIGNED NOT NULL,
 `FIDMobiltelefon` int(10) UNSIGNED NOT NULL,
 `FIDMitarbeiter` int(10) UNSIGNED NOT NULL,
 `Ausgabedatum` date NOT NULL,
 `Rueckgabedatum` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
621
--
-- Indizes der exportierten Tabellen
--
--
-- Indizes für die Tabelle `tbl_gehaltsniveaus`
--
ALTER TABLE `tbl_gehaltsniveaus`
 ADD PRIMARY KEY (`IDGehaltsniveau`);
--
-- Indizes für die Tabelle `tbl_geschlechter`
--
ALTER TABLE `tbl_geschlechter`
 ADD PRIMARY KEY (`IDGeschlecht`);
--
-- Indizes für die Tabelle `tbl_marken`
--
ALTER TABLE `tbl_marken`
 ADD PRIMARY KEY (`IDMarke`);
--
-- Indizes für die Tabelle `tbl_mitarbeiter`
--
ALTER TABLE `tbl_mitarbeiter`
 ADD PRIMARY KEY (`IDMitarbeiter`),
 ADD KEY `FIDVorgesetzter` (`FIDVorgesetzter`),
 ADD KEY `FIDGeschlecht` (`FIDGeschlecht`),
 ADD KEY `FIDGehaltsniveau` (`FIDGehaltsniveau`);
--
-- Indizes für die Tabelle `tbl_mobiltelefone`
--
ALTER TABLE `tbl_mobiltelefone`
 ADD PRIMARY KEY (`IDMobiltelefon`),
 ADD KEY `FIDMarke` (`FIDMarke`);
--
-- Indizes für die Tabelle `tbl_mobiltelefone_mitarbeiter`
--
ALTER TABLE `tbl_mobiltelefone_mitarbeiter`
622
 ADD PRIMARY KEY (`IDMobiltelefonMitarbeiter`),
 ADD KEY `FIDMobiltelefon` (`FIDMobiltelefon`),
 ADD KEY `FIDMitarbeiter` (`FIDMitarbeiter`);
--
-- AUTO_INCREMENT für exportierte Tabellen
--
--
-- AUTO_INCREMENT für Tabelle `tbl_gehaltsniveaus`
--
ALTER TABLE `tbl_gehaltsniveaus`
 MODIFY `IDGehaltsniveau` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `tbl_mitarbeiter`
--
ALTER TABLE `tbl_mitarbeiter`
 MODIFY `IDMitarbeiter` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `tbl_mobiltelefone`
--
ALTER TABLE `tbl_mobiltelefone`
 MODIFY `IDMobiltelefon` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Constraints der exportierten Tabellen
--
--
-- Constraints der Tabelle `tbl_mitarbeiter`
--
ALTER TABLE `tbl_mitarbeiter`
 ADD CONSTRAINT `tbl_mitarbeiter_ibfk_1` FOREIGN KEY (`FIDGehaltsniveau`) 
REFERENCES `tbl_gehaltsniveaus` (`IDGehaltsniveau`) ON UPDATE CASCADE,
 ADD CONSTRAINT `tbl_mitarbeiter_ibfk_2` FOREIGN KEY (`FIDGeschlecht`) REFERENCES 
`tbl_geschlechter` (`IDGeschlecht`) ON UPDATE CASCADE,
 ADD CONSTRAINT `tbl_mitarbeiter_ibfk_3` FOREIGN KEY (`FIDVorgesetzter`) REFERENCES
`tbl_mitarbeiter` (`IDMitarbeiter`) ON DELETE SET NULL ON UPDATE CASCADE;
--
-- Constraints der Tabelle `tbl_mobiltelefone`
623
--
ALTER TABLE `tbl_mobiltelefone`
 ADD CONSTRAINT `tbl_mobiltelefone_ibfk_1` FOREIGN KEY (`FIDMarke`) REFERENCES 
`tbl_marken` (`IDMarke`) ON UPDATE CASCADE;
--
-- Constraints der Tabelle `tbl_mobiltelefone_mitarbeiter`
--
ALTER TABLE `tbl_mobiltelefone_mitarbeiter`
 ADD CONSTRAINT `tbl_mobiltelefone_mitarbeiter_ibfk_1` FOREIGN KEY 
(`FIDMitarbeiter`) REFERENCES `tbl_mitarbeiter` (`IDMitarbeiter`) ON UPDATE CASCADE,
 ADD CONSTRAINT `tbl_mobiltelefone_mitarbeiter_ibfk_2` FOREIGN KEY 
(`FIDMobiltelefon`) REFERENCES `tbl_mobiltelefone` (`IDMobiltelefon`) ON DELETE 
CASCADE ON UPDATE CASCADE;
COMMIT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
