
CREATE TABLE freelancer(
  pers_id INTEGER NOT NULL,
  fornavn VARCHAR(15),
  etternavn VARCHAR(15),
  PRIMARY KEY(pers_id)
);


CREATE TABLE freelancer_i_avis(
  pers_id INTEGER NOT NULL,
  avisnavn VARCHAR(20) NOT NULL,
  PRIMARY KEY(pers_id, avisnavn),
  FOREIGN KEY(pers_id) REFERENCES freelancer(pers_id)
);


CREATE TABLE freelancer_spesialitet(
  pers_id INTEGER NOT NULL,
  spesialitet VARCHAR(25) NOT NULL,
  PRIMARY KEY(pers_id, spesialitet),
  FOREIGN KEY(pers_id) REFERENCES freelancer(pers_id)
);


INSERT INTO freelancer VALUES(1001, 'Per', 'Olsen');
INSERT INTO freelancer VALUES(1002, 'Anne', 'Jensen');
INSERT INTO freelancer VALUES(1003, 'Jens-Eilert', 'Grimstad Olsen');
INSERT INTO freelancer VALUES(1004, 'Anders', 'Jespersen');
INSERT INTO freelancer VALUES(1005, 'Skandalemakeren', null);

INSERT INTO freelancer_i_avis VALUES(1001, 'VG');
INSERT INTO freelancer_i_avis VALUES(1001, 'Dagbladet');
INSERT INTO freelancer_i_avis VALUES(1001, 'Aftenposten');
INSERT INTO freelancer_i_avis VALUES(1001, 'Rabarbladet');
INSERT INTO freelancer_i_avis VALUES(1002, 'VG');
INSERT INTO freelancer_i_avis VALUES(1003, 'VG');
INSERT INTO freelancer_i_avis VALUES(1003, 'Dagbladet');
INSERT INTO freelancer_i_avis VALUES(1004, 'Aftenposten');
INSERT INTO freelancer_i_avis VALUES(1004, 'Agderposten');
INSERT INTO freelancer_i_avis VALUES(1004, 'Dagens Næringsliv');
INSERT INTO freelancer_i_avis VALUES(1005, 'VG');

INSERT INTO freelancer_spesialitet VALUES(1001, 'Sport');
INSERT INTO freelancer_spesialitet VALUES(1001, 'Politikk');
INSERT INTO freelancer_spesialitet VALUES(1002, 'Sport');
INSERT INTO freelancer_spesialitet VALUES(1003, 'Kultur');
INSERT INTO freelancer_spesialitet VALUES(1003, 'Politikk');
INSERT INTO freelancer_spesialitet VALUES(1004, 'Midt-Østen');
INSERT INTO freelancer_spesialitet VALUES(1004, 'Økonomi');
INSERT INTO freelancer_spesialitet VALUES(1005, 'Det engelske kongehuset');

