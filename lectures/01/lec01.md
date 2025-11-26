# Database
Et elektronisk arkivskap.

Et oppbevaringssted (arkiv, kodelager) eller container (beholder, pakke) for en samling av data[maskin]styrte filer (fil er en av hovedabstraksjonene brukt i datafaget); datamaskinstyrk informasjon kunne også bli brukt, men informasjon er et generelt begrep og ikke en enhet, som spesifisert i den engelske definisjonen av "file").

NB! Språk kan betraktes som kode i konteksten av en datamaskin


# Databasesystem
Et databasesystem er datamaskin-basert arkiv-(post-/oppførings- eller fil-) system. 

Definisjon fra pensumboken er problematisk: "Kan lagre "store" mengder data over "lang" tid på en "sikker" måte og tilby "hensiktsmessige" mekanismer for å gjenfinne data "effektivt" og "korrekt", selv når et "stort" antall brukere jobber mot databasen "samtidig".

"Stor", "lang", "sikker", "hensiktsmessig", "effektivt", "korrekt" og "samtidig" er tvetydige begreper, som i tillegg kan være misvisende.

"Et databasehåndteringssystem skal kunne håndtere datamengder, lagringstider og sikkerhetsnivåer, som er passende for dens intenderte applikasjonsdomene, og med skalerbarhetsmekanismer som gir mulighet til å tilpasse det for fremtidige behov. Et databasehåndteringssystem skal kunne tilby mekanismer, som oppfyller applikasjonens-spesifikke krav til ytelse, korrekthet og skalerbarhet, med muligheter / kapabiliteter til å håndtere forventet brukermengde og samtidighetsmønstre."


Bruker videre en forkortelse fra pensumboken, - DBHS - DataBase HåndteringsSystem

Brukere av et DBHS kan utføre (eller forespørre et system for at det utfører) diverse operasjoner, som involverer filer, for eksempel:
- legge til nye filer til databasen (CREATE)
- sette inn data i eksisterende filer (INSERT, UPDATE)
- hente data fra eksisterende filer (SELECT, READ)
- slette data fra eksisterende filer (DELETE med modifikasjoner)
- endre data i eksisterende filer (UPDATE)
- slette filer fra databasen (kommandoen avhenger av hvilke abstraksjoner er brukt i systemet)

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

# Eksempel: database
Anta at database ...

# Begrepseavklaring
en. record 
  - no. post/oppføring, register, logg, antegnelse, opptegning, journal, dokument, fortegnelse
  - a thing constituting a piece of evidence about the past (record - remembrance, recordari - remember) (Oxford English Dictionary OED)
en. filing
  - no. arkivering, innsending, arkivsystem
en. repository
  - no. oppbevaringssted, lager, arkiv, kodelager
  - objekt som kan lagre informasjon (Teknisk engelsk-norsk TE-N)
en. container
  - no. beholder, tank, boks, kasse, container, lagringssted, pakke
en. collection
  - no. samling, oppsamling
  - a group of things or people
en. file
  - no. fil, samlingsperm, mappe, brevordner, kartotek
  - in computing, a collection of related information held on backing store that is treated as a unit; a file may contain data of any kind. (Oxford Dictionary of Business and Management ODB&M)
en. statement - setning, kommando, utsagn, informasjon


## Sammensatte begreper (brukt i en smalere/avgrenset kontekst)
**en. weak entity type**

Brukes i forbindelse med modellering. 
> "Entity types that do not have key attributes on their own are called weak entity types."

**The opposite is "strong entity types" or "regular entity types"** 
entity A "being related" to an entity B in combination with one of the B's attribute values. B is a specific entity of another entity type than A. A(a1, a2, ..., aN), B(b1, b2, ..., bM).
B is called identifying or owner entity type. 
