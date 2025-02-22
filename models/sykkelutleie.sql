-- Siden jeg kan ikke bruke understrek i en script
-- markerer jeg primærnøkler med #
-- * betyr fremmednøkkel
-- Sykkel(#SykkelID, Startdato, StativID*, Låsnr*) 
-- Sykkelstativ(#StativID, Sted)
-- Lås(#StativID*, #Låsnr)
-- Kunde(#Mobilnr, Fornavn, Etternavn, Betalingskortnr) 
-- Utleie(#SykkelID*, #Utlevert, Mobilnr*, Innlevert, Beløp)

DROP TABLE IF EXISTS Utleie;
DROP TABLE IF EXISTS Sykkel;
DROP TABLE IF EXISTS Laas;
DROP TABLE IF EXISTS Sykkelstativ;
DROP TABLE IF EXISTS BysykkelKunde;



-- Opprettelse av tabellen for kunder
CREATE TABLE BysykkelKunde (
    MobilNr CHAR(8),
    Fornavn VARCHAR(50) NOT NULL,
    Etternavn VARCHAR(50) NOT NULL,
    Betalingskort CHAR(16), 
    CONSTRAINT pk_Mobilnr PRIMARY KEY (MobilNr)
);


-- Opprettelse av tabellen for sykkelstativer
CREATE TABLE Sykkelstativ (
    StativID SMALLINT AUTO_INCREMENT,
    Sted VARCHAR(50) NOT NULL,
    CONSTRAINT pk_StativID PRIMARY KEY (StativID)
);

-- Opprettelse av tabellen for låser
CREATE TABLE Laas (
    StativID SMALLINT,
    Laasnr CHAR(10),
    CONSTRAINT pk_StativIS_Laasnr PRIMARY KEY (StativID, Laasnr),
    CONSTRAINT fk_Laas_StativID FOREIGN KEY (`StativID`) REFERENCES Sykkelstativ (StativID)
);


-- Opprettelse av tabellen for sykler
CREATE TABLE Sykkel (
    SykkelID SMALLINT,
    Startdato DATE,
    StativID SMALLINT,
    Laasnr CHAR(10),
    CONSTRAINT pk_SykkelID PRIMARY KEY (SykkelID),
    CONSTRAINT fk_Sykkel_StativID_Laasnr FOREIGN KEY (StativID, Laasnr) REFERENCES Laas (StativID, Laasnr)
);

-- Opprettelse av tabellen for utleie
CREATE TABLE Utleie (
    SykkelID SMALLINT,
    Utlevert TIMESTAMP,
    Mobilnr CHAR(8),
    Innlevert TIMESTAMP,
    Belop DECIMAL(10, 2),
    CONSTRAINT pk_SykkelID_Utlevert PRIMARY KEY (SykkelID, Utlevert),
    CONSTRAINT fk_Utleie_SykkelID FOREIGN KEY (SykkelID) REFERENCES Sykkel (SykkelID),
    CONSTRAINT fk_Utleie_Mobilnr FOREIGN KEY (Mobilnr) REFERENCES BysykkelKunde (Mobilnr)
);

-- Sett inn data i Kunde-tabellen
INSERT INTO BysykkelKunde (Mobilnr,Fornavn,Etternavn,Betalingskort)
VALUES
  ("67426915","Clayton","Witt","3754676784726780"),
  ("21854140","Iris","Sampson","1133359244166342"),
  ("61512286","Wynter","Stevenson","5896367215646685"),
  ("26488053","Colette","Mcclure","5693151666783628"),
  ("18915898","Salvador","Richardson","7166256432877454"),
  ("39647539","Amery","Ramsey","6428267637174983"),
  ("02543172","Pascale","Nichols","3138755164483860"),
  ("79425171","Blake","Wade","2349776050717255"),
  ("31465221","John","Baxter","6818271128363291"),
  ("19437756","Nayda","Cohen","4127757415772463"),
  ("55784833","Chastity","Shaffer","0791476559624598"),
  ("47268958","Jordan","Sampson","4997564454473141"),
  ("28978860","Juliet","Callahan","6653375748631295"),
  ("66813703","Gil","Vega","4221721754173529"),
  ("01717145","Cynthia","Simon","7163346367720772"),
  ("27713982","Helen","Holden","4308561151442403"),
  ("78662653","Violet","Hansen","1404296644656396"),
  ("03657121","Dexter","Willis","8748289660676125"),
  ("65595425","Aristotle","Roth","5025462450181182"),
  ("15842333","Gray","Richmond","3133265558873173"),
  ("92182524","Aquila","Melton","2553976891342741"),
  ("86512127","Sopoline","Avila","4475680738980978"),
  ("14614115","Lyle","Jordan","7384072928811885"),
  ("15142737","Fitzgerald","Rich","1360911866258124"),
  ("75223418","Lacy","Schultz","3776241361203234"),
  ("64147057","Jana","Snow","9437231599774237"),
  ("78816632","Madeson","Frank","2610181521860882"),
  ("53552833","Dara","Justice","6647284905434476"),
  ("72753148","Caesar","Farmer","2684581144841285"),
  ("04137141","Emery","Bush","1456683743834357"),
  ("12131462","Aquila","Logan","3276317063221381"),
  ("86812279","Victoria","Roy","2922473612921992"),
  ("32649506","Rachel","Crane","8919267287565741"),
  ("44423738","Hyatt","Hinton","6713364341987279"),
  ("78139578","Anthony","Mitchell","5463537362874571"),
  ("44172638","Porter","Brennan","8431209419871010"),
  ("70185272","Drake","Suarez","4633447391393176"),
  ("61246543","Halee","Hughes","5896045843244417"),
  ("81918227","Branden","Stanley","3717756755763541"),
  ("23110334","Price","Foster","5653486646266723"),
  ("80338568","Addison","Tran","6216134002737682"),
  ("22681453","Minerva","Munoz","6258338908548394"),
  ("82781571","Kyle","Barron","7867243635374198"),
  ("69254121","Madeline","Bowen","8773400529389288"),
  ("44810559","Cullen","Little","8426328032218117"),
  ("52773885","Wynne","Wallace","8931365347588767"),
  ("48185748","Mohammad","Long","8285692473198253"),
  ("64326567","Desiree","Prince","9525113470151712"),
  ("32611917","Salvador","Gross","4783613591438707"),
  ("92717488","Coby","Murphy","7401120017592400");

-- Sett inn data i Sykkelstativ-tabellen
-- Siden vi har brukt AUTO_INCREMENT
INSERT INTO Sykkelstativ (Sted)
VALUES
  ("Bergtunveien 2"),
  ("Glacisgata 10"),
  ("Grubbebakken 23"),
  ("Harelabbveien 43"),
  ("Storgata 34"),
  ("Kirkegate 11"),
  ("Biskopsgate 65"),
  ("Jonsrudveien 15"),
  ("Kjølberggata 1"),
  ("Drammensveien 100");

-- Sett inn data i Lås-tabellen
INSERT INTO Laas (StativID,Laasnr)
VALUES
  (3,"Q7N1U7IN3"),
  (8,"N8U5U4OT7"),
  (1,"R8K9T0QE3"),
  (5,"O7G4D2RI2"),
  (3,"F3V0H8BH7"),
  (6,"O7D0I9CY5"),
  (8,"D7J9J5RS5"),
  (8,"B7W3Y5UD1"),
  (9,"S5V6X9AK3"),
  (7,"F2E7H2AV3"),
  (4,"C4P8L8JD2"),
  (9,"F1G6F5UP7"),
  (7,"S3V1T4JO2"),
  (2,"T3Y2D6VS7"),
  (4,"V4G6D4AI7"),
  (8,"C6R7H2RT4"),
  (2,"A6X8Q7VC0"),
  (7,"R4E9L7SC6"),
  (8,"S8M7D5EJ5"),
  (7,"T2D1L6HJ4"),
  (1,"D7C5J5ME4"),
  (9,"K8K6O7JL7"),
  (7,"T7W5Y3UR0"),
  (9,"V7F2C7SQ8"),
  (4,"M5I8D6MR3"),
  (4,"V5V7O2XH8"),
  (9,"U4L4Y1KF2"),
  (3,"S6D2L4FV0"),
  (6,"W9F1G2ES7"),
  (1,"B1K4K6DS8");

-- Sett inn data i Sykkel-tabellen
INSERT INTO Sykkel (SykkelID, Startdato, StativID, Laasnr)
VALUES
(1, '2025-01-01', 1, "B1K4K6DS8"),
(2, '2025-01-02', 1, "D7C5J5ME4"),
(3, '2025-01-03', 1, "R8K9T0QE3"),
(4, '2025-01-04', 6, "W9F1G2ES7"),
(5, '2025-01-05', 2, "T3Y2D6VS7"),
(6, '2025-01-06', 2, "A6X8Q7VC0"),
(7, '2025-01-07', 6, "O7D0I9CY5"),
(8, '2025-01-08', 7, "F2E7H2AV3"),
(9, '2025-01-09', 3, "S6D2L4FV0"),
(10, '2025-01-10', 3, "F3V0H8BH7"),
(11, '2025-01-11', 3, "Q7N1U7IN3"),
(12, '2025-01-12', 4, "C4P8L8JD2"),
(13, '2025-01-13', 4, "V4G6D4AI7"),
(14, '2025-01-14', 4, "M5I8D6MR3"),
(15, '2025-01-15', 4, "V5V7O2XH8"),
(16, '2025-01-16', NULL, NULL);

-- Sett inn data i Utleie-tabellen
INSERT INTO Utleie (SykkelID, Utlevert, Mobilnr, Innlevert, Belop)
VALUES
(1, '2025-01-21 10:00:00', '67426915', '2025-01-21 11:00:00', 50.00),
(2, '2025-01-22 12:00:00', '21854140', '2025-01-22 13:06:00', 55.00),
(3, '2025-01-23 14:00:00', '61512286', '2025-01-23 15:12:00', 60.00),
(4, '2025-01-24 08:00:00', '26488053', '2025-01-24 08:54:00', 45.00),
(11, '2025-01-30 10:00:00', '67426915', '2025-01-21 11:00:00', 50.00),
(5, '2025-01-25 09:00:00', '18915898', '2025-01-25 10:00:00', 50.00),
(5, '2025-01-25 11:00:00', '22681453', '2025-01-25 13:00:00', 100.00),
(5, '2025-01-25 15:00:00', '48185748', '2025-01-25 16:30:00', 75.00),
(16, '2025-01-28 15:00:00', '32649506', NULL, NULL);