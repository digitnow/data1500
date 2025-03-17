CREATE DATABASE kap9;
CREATE TABLE Kunde (
    kunde_id INT AUTO_INCREMENT PRIMARY KEY,
    fornavn VARCHAR(50),
    etternavn VARCHAR(50),
    epost VARCHAR(100),
    registreringsdato DATE
);


DELIMITER //
CREATE PROCEDURE FyllKundeTabell()
BEGIN
	DECLARE i INT DEFAULT 0;
	WHILE i < 100000 DO
    	INSERT INTO Kunde (fornavn, etternavn, epost, registreringsdato)
   		VALUES (
    		CONCAT('Fornavn', i),
    		CONCAT('Etternavn', i),
    		CONCAT('epost', i, '@example.com'),
    		DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 365) DAY)
   		);
    	SET i = i + 1;
    END WHILE;
END 

DELIMITER ; 
CALL FyllKundeTabell();

SELECT COUNT(*) FROM Kunde;
SELECT * FROM Kunde WHERE etternavn = 'Etternavn99999';

EXPLAIN SELECT * FROM Kunde WHERE etternavn = 'Etternavn99999';
-- +------+-------------+-------+------+---------------+------+---------+------+-------+-------------+
-- | id   | select_type | table | type | possible_keys | key  | key_len | ref  | rows  | Extra       |
-- +------+-------------+-------+------+---------------+------+---------+------+-------+-------------+
-- |    1 | SIMPLE      | Kunde | ALL  | NULL          | NULL | NULL    | NULL | 99662 | Using where |
-- +------+-------------+-------+------+---------------+------+---------+------+-------+-------------+
CREATE INDEX idx_etternavn ON Kunde (etternavn);
EXPLAIN SELECT * FROM Kunde WHERE etternavn = 'Etternavn99999';
-- +------+-------------+-------+------+---------------+---------------+---------+-------+------+-----------------------+
-- | id   | select_type | table | type | possible_keys | key           | key_len | ref   | rows | Extra                 |
-- +------+-------------+-------+------+---------------+---------------+---------+-------+------+-----------------------+
-- |    1 | SIMPLE      | Kunde | ref  | idx_etternavn | idx_etternavn | 203     | const | 1    | Using index condition |
-- +------+-------------+-------+------+---------------+---------------+---------+-------+------+-----------------------+
EXPLAIN SELECT * FROM Kunde WHERE registreringsdato BETWEEN '2024-01-01' AND '2024-12-31';
-- +------+-------------+-------+------+---------------+------+---------+------+-------+-------------+
-- | id   | select_type | table | type | possible_keys | key  | key_len | ref  | rows  | Extra       |
-- +------+-------------+-------+------+---------------+------+---------+------+-------+-------------+
-- |    1 | SIMPLE      | Kunde | ALL  | NULL          | NULL | NULL    | NULL | 99662 | Using where |
-- +------+-------------+-------+------+---------------+------+---------+------+-------+-------------+
CREATE INDEX idx_registreringsdato ON Kunde (registreringsdato);
EXPLAIN SELECT * FROM Kunde WHERE registreringsdato BETWEEN '2024-01-01' AND '2024-12-31';
-- +------+-------------+-------+-------+-----------------------+-----------------------+---------+------+------+-----------------------+
-- | id   | select_type | table | type  | possible_keys         | key                   | key_len | ref  | rows | Extra                 |
-- +------+-------------+-------+-------+-----------------------+-----------------------+---------+------+------+-----------------------+
-- |    1 | SIMPLE      | Kunde | range | idx_registreringsdato | idx_registreringsdato | 4       | NULL | 1    | Using index condition |
-- +------+-------------+-------+-------+-----------------------+-----------------------+---------+------+------+-----------------------+


SET profiling = 1;
SELECT * FROM Kunde WHERE etternavn = 'Etternavn99999';
SHOW PROFILES;
-- +----------+------------+--------------------------------------------------------+
-- | Query_ID | Duration   | Query                                                  |
-- +----------+------------+--------------------------------------------------------+
-- |        1 | 0.00564500 | SELECT * FROM Kunde WHERE etternavn = 'Etternavn99999' |
-- +----------+------------+--------------------------------------------------------+

-- KEY `idx_etternavn` (`etternavn`),
-- KEY `idx_registreringsdato` (`registreringsdato`)

DROP INDEX idx_etternavn ON Kunde;
SELECT * FROM Kunde WHERE etternavn = 'Etternavn99999';
SHOW PROFILES;
-- +----------+------------+--------------------------------------------------------+
-- | Query_ID | Duration   | Query                                                  |
-- +----------+------------+--------------------------------------------------------+
-- |        1 | 0.00564500 | SELECT * FROM Kunde WHERE etternavn = 'Etternavn99999' |                               
-- |        2 | 0.03321846 | DROP INDEX idx_etternavn ON Kunde                      |
-- |        3 | 0.05336371 | SELECT * FROM Kunde WHERE etternavn = 'Etternavn99999' |
-- +----------+------------+--------------------------------------------------------+