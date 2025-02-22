-- Setningene forutsetter tabellene basert på sykkelutleie.sql fra 2025-01-30

-- Slide 10
-- Disse er feil
INSERT INTO Utleie (SykkelID, Utlevert, Mobilnr, Innlevert, Belop) 
VALUES (1, '2025-01-29 10:00:00', '67426900', '2025-01-29 11:00:00', 50.00);

INSERT INTO Utleie VALUES ('67426900');
INSERT INTO Utleie VALUES (NULL, NULL, '67426900', NULL);
INSERT INTO Utleie VALUES (8, NULL, '67426900', NULL, NULL);

-- Disse er korrekt (en ny sykkel er leid ut)
INSERT INTO Utleie VALUES (8, CURRENT_TIMESTAMP, '27713982', NULL, NULL);

-- Slide 14
DELETE FROM Utleie WHERE SykkelID = 8;

-- Slide 15
-- START TRANSACTION;
UPDATE Sykkel SET StativID = 9, Laasnr = 'V7F2C7SQ8' WHERE SykkelID = 16;
UPDATE Utleie SET Innlevert = NOW(), Belop = 500 WHERE SykkelID = 16;
-- COMMIT;

-- Oppdaterer med en SQL-setning (fordeler?)
-- Relevant for Kap 4., - spørringer mot flere tabeller
UPDATE Sykkel s 
JOIN Utleie u ON u.SykkelID = s.SykkelID 
SET s.StativID = 9, s.Laasnr = 'V7F2C7SQ8', u.Innlevert = NOW(), u.Belop = 500 
WHERE s.SykkelID = 16;


-- Slider 18-20
ALTER TABLE Sykkel ADD COLUMN SistVedlikeholdt DATE;
ALTER TABLE Sykkel DROP Column SistVedlikeholdt;
ALTER TABLE Sykkel ADD COLUMN SistVedlikeholdt DATE NOT NULL;
UPDATE Sykkel SET SistVedlikeholdt = CURDATE() WHERE SykkelID = 1;
-- OBS! Datoformatet må være riktig
UPDATE Sykkel SET SistVedlikeholdt = '2025-01-13' WHERE SykkelID = 2; 
UPDATE Sykkel SET SistVedlikeholdt = CURDATE(); -- "farlig" SQL-spørring


-- Slider 22 -   (ALTER)
-- Bruksmønster:
-- Når kunden blir slettet, fjerner man alle utleier kunden har hatt.
-- Man kunne tenke seg at det totale antallet utleier kan være nyttig informasjon.
-- Før man sletter kunde, kunne man lagret utleier, eventuelt med dato, 
-- i en annen tabell.
ALTER TABLE Utleie DROP FOREIGN KEY fk_Utleie_Mobilnr;
ALTER TABLE Utleie ADD CONSTRAINT fk_Utleie_Mobilnr FOREIGN KEY (Mobilnr) REFERENCES BysykkelKunde (Mobilnr) ON DELETE CASCADE;
SELECT * FROM Utleie WHERE Mobilnr = '18915898';
DELETE FROM BysykkelKunde WHERE Mobilnr = '18915898';
SELECT * FROM Utleie WHERE Mobilnr = '18915898';

-- Slide 23 (mer ALTER)
INSERT INTO Utleie (SykkelID,Utlevert) VALUES (9, NOW());
ALTER TABLE Utleie MODIFY Mobilnr VARCHAR(15) NOT NULL; -- denne feiler
DELETE FROM Utleie WHERE Mobilnr IS NULL;
ALTER TABLE Utleie MODIFY Mobilnr VARCHAR(15) NOT NULL;

-- Slide 24 (tilstand etter ALTER)
SHOW TABLE CREATE Utleie;
CREATE TABLE `Utleie` (
  `SykkelID` smallint(6) NOT NULL,
  `Utlevert` timestamp NOT NULL,
  `Mobilnr` varchar(15) NOT NULL,
  `Innlevert` timestamp NULL DEFAULT NULL,
  `Belop` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`SykkelID`,`Utlevert`),
  KEY `fk_Utleie_Mobilnr` (`Mobilnr`),
  CONSTRAINT `fk_Utleie_Mobilnr` FOREIGN KEY (`Mobilnr`) REFERENCES `BysykkelKunde` (`MobilNr`) ON DELETE CASCADE,
  CONSTRAINT `fk_Utleie_SykkelID` FOREIGN KEY (`SykkelID`) REFERENCES `Sykkel` (`SykkelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

-- Slide 25 (Kap 4 stoff)
SELECT BysykkelKunde.MobilNr,
       BysykkelKunde.Fornavn,
       BysykkelKunde.Etternavn,
       COUNT(Utleie.Utlevert) AS AntallLeie
FROM   BysykkelKunde
LEFT JOIN Utleie ON BysykkelKunde.Mobilnr = Utleie.Mobilnr
GROUP BY BysykkelKunde.MobilNr
ORDER BY AntallLeie DESC;

