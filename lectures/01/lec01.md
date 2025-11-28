# Database
> Et elektronisk arkivskap.
> Et oppbevaringssted (arkiv, kodelager) eller container (beholder, pakke) for en samling av data[maskin]styrte filer.
> Fra pensumboken: en samling av logisk relaterte data som brukes for et bestemt formål

**Fil** er en av hovedabstraksjonene brukt i datafaget. **Datamaskinstyrt informasjon** kunne også bli brukt, men informasjon er et generelt begrep og ikke en enhet, som spesifisert i den engelske definisjonen av "file").

**en. file**
- In computing, a collection of related information held on backing store that is treated as a unit. A file may contain data of any kind.

NB! Språk er det sammen som kode i konteksten av en datamaskin.

# Fil
Databaser oppfattes som (mer eller mindre strukturert) informasjon av mennesker. På en datamaskin er alle data fysisk lagret enten i primært minne (RAM) eller i sekundært minne (SSD Solid Disk Drive, HDD Hard Disk Drive, *CD*, *DVD*, magnetbånd), som mønster i et spesifikt materiale eller som elektriske ladninger i elektriske kretser. Det er mekaniske og elektriske prosesser, som gjør det mulig å bruke en datamaskin til noe meningsfult. 

Modellen som blir ofte brukt for å beskrive en datamaskin er HW - OS - APP, hvor HW står for HardWare, OS for Operating System og APP for Applikasjon. DBHS er en applikasjon, som bruker OS for å lagre data på en måte at det er mulig å bevare data for en viss tid (i et lager), eventuelt endre deler av data, samt hente/lese data fra et lager. Det fysiske lageret (HW) blir styrt av programmer, som hører til operativsystemet (OS) og programmene fra OS blir benyttet av applikasjoner (APP, som du, som utvikler, lager). Husk modell #1, - trelagsmodellen.  

Minnehierarki (se i pensumboken på side 260): CPU registre - Cache minne - Random Access Memory (primærminne) - 

## Typer av databaser
Se https://www.youtube.com/watch?v=VfcRxtBKI54

- 0:00 Intro
- 0:25 Relational Database
- 3:12 Columnar Database
- 6:28 Document Database
- 10:53 Graph Database
- 13:31 Vector Database
- 14:40 Key-value Database
- 16:51 Time-series Database
- 17:44 Outro

### Relasjonsdatbaser
- Unik identifikator for hver
- Skalerer ikke bra

...

# Databasesystem
Et databasesystem er datamaskin-basert arkiv-(post-/oppførings- eller fil-) system. 

Definisjon fra pensumboken er problematisk: "Kan lagre "store" mengder data over "lang" tid på en "sikker" måte og tilby "hensiktsmessige" mekanismer for å gjenfinne data "effektivt" og "korrekt", selv når et "stort" antall brukere jobber mot databasen "samtidig".

"Stor", "lang", "sikker", "hensiktsmessig", "effektivt", "korrekt" og "samtidig" er tvetydige begreper, som i tillegg kan være misvisende.

"Et databasehåndteringssystem skal kunne håndtere datamengder, lagringstider og sikkerhetsnivåer, som er passende for dens intenderte applikasjonsdomene, og med skalerbarhetsmekanismer som gir mulighet til å tilpasse det for fremtidige behov. Et databasehåndteringssystem skal kunne tilby mekanismer, som oppfyller applikasjonens-spesifikke krav til ytelse, korrekthet og skalerbarhet, med muligheter / kapabiliteter til å håndtere forventet brukermengde og samtidighetsmønstre."

Bruker videre en forkortelse fra pensumboken, - DBHS - DataBase HåndteringsSystem

Brukere av et DBHS kan utføre (eller rettere sagt forespørre et system for at det utfører) diverse operasjoner, som involverer filer, for eksempel:
- legge til nye filer til databasen (CREATE)
- sette inn data i eksisterende filer (INSERT, UPDATE)
- hente data fra eksisterende filer (SELECT, READ)
- slette data fra eksisterende filer (DELETE med modifikasjoner)
- endre data i eksisterende filer (UPDATE)
- slette filer fra databasen (kommandoen avhenger av hvilke abstraksjoner er brukt i systemet)


# Eksempel: database
Anta at data fra alle bevegelser på en webside lagres i en database ... 

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

# Referanser
Anton Putra. (2023). "Types of Databases: Relational vs. ...". https://www.youtube.com/watch?v=VfcRxtBKI54 , sist sett 2025-11-26
