-- brukeradministrasjon
CREATE DATABASE kap10;

CREATE USER 'u_kap10_25'@'localhost' IDENTIFIED BY '123.Kap10#';
GRANT CREATE ON kap10.* TO 'u_kap10_25'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON kap10.* TO 'u_kap10_25'@'localhost';
-- GRANT ALL PRIVILEGES ON kap10.* TO 'u_kap10_25'@'localhost';
-- SHOW GRANTS FOR 'u_kap10_25'@'%';
-- dette fikset problemet med mellom-container-kommunikasjon
GRANT USAGE ON kap10.* TO 'u_kap10_25'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE ON `kap10`.* TO 'u_kap10_25'@'%';

-- dirty read (usikker lesing)
USE kap10;

CREATE TABLE Konto (
    KontoId INT AUTO_INCREMENT PRIMARY KEY,
    KontoNavn VARCHAR(50) NOT NULL,
    Balanse DECIMAL(10, 2) NOT NULL
);

INSERT INTO Konto (KontoNavn, Balanse) VALUES ('Alice', 1000.00), ('Bob', 500.00);

SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
-- SELECT @@transaction_isolation;

-- Vi simulerer en dirty read ved å ha to samtidige transaksjoner:
--    Transaksjon 1 (T1): Oppdaterer en rad uten å committe endringen.
--    Transaksjon 2 (T2): Leser den oppdaterte raden før Transaksjon 1 committer.
-- T1
START TRANSACTION;
-- SELECT * FROM information_schema.innodb_trx\G
-- SELECT count(*) FROM information_schema.innodb_trx; 
-- trenger PROCESS rettighet

-- Oppdater balansen til Alice
UPDATE Konto SET Balanse = Balanse + 100 WHERE name = 'Alice';

-- Vent litt for å simulere en langvarig transaksjon
SELECT SLEEP(10);

-- Rollback transaksjonen (ikke commit)
ROLLBACK;

-- T2
START TRANSACTION;

-- Les balansen til Alice
SELECT Balanse FROM Konto WHERE name = 'Alice';

-- Commit transaksjonen
COMMIT;

