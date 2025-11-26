## NoSql
Tema 1: The CAP theorem
- Availability -- kan fortsette å gi respons og ikke begrense tilgang selv hvis det har oppstått en feil (hvilken type feil? HW, eller andre grunner til at noen av nodene i det distribuerte DBHS er ikke tilgjengelig)
- Consistency -- en READ forespørsel vil alltid returnerer "spor" av den siste WRITE-operasjonen
- Partition Tolerance -- selv under et nettverksfeil som gjør en eller flere noder utilgjengelig, vil det være mulig å få respons fra det distribuerte dbhs


Tema 2: Different NoSQL data models and where __nosql_db__ (ScyllaDB) fits in
- En annen måte å se på nosql_db er typen av data modell
  - Key value
  - Dokument
  - Wide column store
  - Graph (mest komplekse struktru)

Tema 3: The design principles of __nosql_db__ (ScyllaDB)
- lite begrensninger i tilgangen
- god (ofte brukes "høy", uten at en skala for "høyt" og "lavt" blir spesifisert) ytelse (low latency ...)
- skalerbarhet (praktisk å legge til flere noder)
- lave administrasjonskostnader (mindre noder for å kjøre Distribuert DBHS og også "built with autonomous capabilities, has auto tuning")
- kompatibel med Cassandra og DynamoDB (lett å overføre til ScyllaDB, som ikke fører til lock-in)


Tema 4: __nosql_db__ (ScyllaDB) flavors (and design decisions)
- designvalg: 
-- shard per core (threads: noen valper spiser fra samme skål; shard per core: avsetter maskinvare per "shard"*, hver valp har sin skål, unngår kontekst-svitsjing)
-- ecosystem-kompatibilitet (Cassandra)
-- kostnadseffektivt (TCO - 4 Scylla nodes vs 40 Cassandra nodes; 2.5x less expensive)
-- Open Source (community-based), Enterprise (forbedringer i ytelse, 24/7 støtte), Cloud (as a service; kjøring og administrajon blir tatt vare på; "Things like backups, repairs, performance, enhancements, upgrades, security and so on.")

Tema 5: Intro to the __nosql_db__ (ScyllaDB) Architecture
ScyllaDB - open source, active community with forum etc.

* "... a shard is a fundamental building block of a horizontally scaled, distributed database. It's a piece of the whole puzzle, allowing a system to grow beyond the limits of a single machine by distributing data and workload across many. While powerful, it's a trade-off that sacrifices simplicity for scale."" (DeepSeek, 2025-10-09, prompt: 'define "shard" in the context of distributed database')
