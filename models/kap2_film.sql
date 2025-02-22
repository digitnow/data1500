-- Database: Film


-- Sletter tabellen

-- For å få et skript som kan kjøres flere ganger:

-- DROP TABLE Film;


-- MySQL
-- For å få et skript som kan kjøres flere ganger,
-- og som fungerer enten tabellen finnes eller ikke:

-- DROP TABLE IF EXISTS Film;



-- Oppretter tabellen

CREATE TABLE Film
(
    FNr     INTEGER NOT NULL,
    Tittel  VARCHAR(100),
    År      SMALLINT,
    Land    VARCHAR(50),
    Sjanger VARCHAR(50),
    Alder   SMALLINT,
    Tid     SMALLINT,
    Pris    DECIMAL(8, 2),
    CONSTRAINT FilmPN PRIMARY KEY (FNr)
);


-- Setter inn eksempeldata

INSERT INTO Film (FNr, Tittel, År, Land, Sjanger, Alder, Tid, Pris) VALUES
( 1, 'Casablanca',           1942, 'USA',          'Drama',     15, 102, '149.00'),
( 2, 'Fort Apachea',         1948, 'USA',          'Western',   15, 127,     NULL),
( 3, 'Apocalypse Now',       1979, 'USA',          'Action',    18, 155, '123.00'),
( 4, 'Streets of Fire',      1984, 'USA',          'Action',    15,  93,     NULL),
( 5, 'High Noon',            1952, 'USA',          'Western',   15,  85, '123.00'),
( 6, 'Cinema Paradiso',      1988, 'Italia',       'Komedie',   11, 123,     NULL),
( 7, 'Asterix hos britene',  1988, 'Frankrike',    'Tegnefilm',  7,  78, '149.00'),
( 8, 'Veiviseren',           1987, 'Norge',        'Action',    15,  96,  '87.00'),
( 9, 'Salmer fra kjøkkenet', 2002, 'Norge',        'Komedie',    7,  80, '149.00'),
(10, 'Anastasia',            1997, 'USA',          'Tegnefilm',  7,  94, '123.00'),
(11, 'La Grande bouffe',     1973, 'Frankrike',    'Drama',     15, 129, ' 87.00'),
(12, 'The Blues Brothers',   1980, 'USA',          'Komedie',   11, 124, '135.00'),
(13, 'Beatles: Help',        1965, 'Storbritania', 'Musikk',    11, 144,     NULL);
