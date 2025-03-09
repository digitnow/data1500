-- Slide 32
CREATE TABLE `Bygning` (
  `BygningsNr` int(11) NOT NULL,
  `Etasjer` int(11) DEFAULT NULL,
  `Areal` decimal(8,2) DEFAULT NULL,
  `BygningsType` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`BygningsNr`)
);
desc Bygning;

-- Slide 34
ALTER TABLE Bygning ADD Avgift DECIMAL(8,2);
desc Bygning

-- Slide 35
INSERT INTO Bygning VALUES 
(1, 2, 600.00, 'garasjebygg', 100.00),
(2, 1, 145.00, 'enebolig', 500.00),
(3, 1, 86.00, 'fritidsbygg', 200.00),
(4, 2, 150.00, 'enebolig', 500.00);
SELECT * FROM Bygning;

-- Slide 45 
-- lager en "kodetabell", en-til-mange relasjon, ikke identifiserende
CREATE TABLE BygningsType (
	BygningsType VARCHAR(45) PRIMARY KEY, 
	Avgift DECIMAL(8,2)
);
INSERT INTO BygningsType VALUES 
('garasjebygg', 100), 
('enebolig', 500), 
('fritidsbygg', 200);
SELECT * FROM BygningsType;

-- Slide 46 
-- for testing (eksempel på inkonsistens i forhold til BygningsTyper)
INSERT INTO Bygning VALUES (5, 2, 250.00, 'hus', 500.00);
-- fjerner kolonnen Avgift fra tabellen Bygning, siden vi bestemte at den skal til en ny entitet / tabell
ALTER TABLE Bygning DROP COLUMN Avgift;
SELECT * FROM Bygning;

-- Slide 47
-- forsøker å lage fremmednøkkel i Bygning mot BygningsType (feilmelding grunnet 'hus' i kolonne Bygning.BygningsType)
ALTER TABLE Bygning ADD CONSTRAINT FK_BType_Bygning FOREIGN KEY (Bygningstype) REFERENCES BygningsType(BygningsType);
-- sletter raden med 'hus' og utførere ALTER på nytt
DELETE FROM Bygning WHERE BygningsType LIKE 'hus';
-- ønsker også å ikke tillate NULL-verdier i Bygning for BygningsType
ALTER TABLE Bygning MODIFY BygningsType VARCHAR(45) NOT NULL;


-- Eksperimenter med strukturen
-- gir feil på NULL begrensning
INSERT INTO Bygning VALUES(5, 2, 150, NULL); 

-- gir feil på inkompatibel fremmednøkken-verdi
INSERT INTO Bygning VALUES(5, 2, 150, 'hus');

-- korrekt 
INSERT INTO Bygning VALUES(5, 2, 150, 'fritidsbygg');

-- Slide 48
-- JOIN 
SELECT * FROM Bygning B 
JOIN BygningsType BT 
  ON BT.BygningsType = B.BygningsType;



