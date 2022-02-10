* Encoding: windows-1252.

* todo:
- check mediaan statsec; check ontbreken totaal warmtepomp
- lange termijn: statsec onbekend voor de nieuwe fusies


* haal de data binnen die we reeds eerder kregen.
* dus: E:\data\epb\statsec\ontvangen_van_veka\resultaten\
* ELK JAAR MOET JE HIER DUS EEN BESTAND TOEVOEGEN.
* eerst kuisen we de dubbels op binnen een bestand, met voorkeur voor gevulde rijen.
* vervolgens voegen we alle bestanden samen, en kuisen de dubbels opnieuw op (want er zijn lege rijen in oude bestanden die in nieuwe opgevuld zijn?!).

GET DATA  /TYPE=TXT
  /FILE=datamap + 'statsec\ontvangen_van_veka\resultaten\2019_mapping_aangifte_id_statistische_sector_voor_pic.csv'
  /ENCODING='UTF8'
  /DELCASE=LINE
  /DELIMITERS="|"
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
  AANGIFTE_ID A20
  statsec A9
  /MAP.
CACHE.
EXECUTE.
DATASET NAME statsec0 WINDOW=FRONT.
sort cases aangifte_id (a).

* Identify Duplicate Cases.
SORT CASES BY AANGIFTE_ID(A) statsec(A).
MATCH FILES
  /FILE=*
  /BY AANGIFTE_ID
  /FIRST=PrimaryFirst
  /LAST=PrimaryLast.
DO IF (PrimaryFirst).
COMPUTE  MatchSequence=1-PrimaryLast.
ELSE.
COMPUTE  MatchSequence=MatchSequence+1.
END IF.
LEAVE  MatchSequence.
FORMATS  MatchSequence (f7).
COMPUTE  InDupGrp=MatchSequence>0.
SORT CASES InDupGrp(D).
MATCH FILES
  /FILE=*
  /DROP=PrimaryFirst InDupGrp MatchSequence.
VARIABLE LABELS  PrimaryLast 'Indicator of each last matching case as Primary'.
VALUE LABELS  PrimaryLast 0 'Duplicate Case' 1 'Primary Case'.
VARIABLE LEVEL  PrimaryLast (ORDINAL).
FREQUENCIES VARIABLES=PrimaryLast.
EXECUTE.

FILTER OFF.
USE ALL.
SELECT IF (PrimaryLast = 1).
EXECUTE.
delete variables PrimaryLast.


GET DATA  /TYPE=TXT
  /FILE=datamap + 'statsec\ontvangen_van_veka\resultaten\2021_mapping_aangifte_id_statistische_sector_voor_pic.csv'
  /ENCODING='UTF8'
  /DELCASE=LINE
  /DELIMITERS="|"
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
  AANGIFTE_ID A20
  statsec A9
  /MAP.
CACHE.
EXECUTE.
DATASET NAME statsec1 WINDOW=FRONT.
sort cases aangifte_id (a).


* Identify Duplicate Cases.
SORT CASES BY AANGIFTE_ID(A) statsec(A).
MATCH FILES
  /FILE=*
  /BY AANGIFTE_ID
  /FIRST=PrimaryFirst
  /LAST=PrimaryLast.
DO IF (PrimaryFirst).
COMPUTE  MatchSequence=1-PrimaryLast.
ELSE.
COMPUTE  MatchSequence=MatchSequence+1.
END IF.
LEAVE  MatchSequence.
FORMATS  MatchSequence (f7).
COMPUTE  InDupGrp=MatchSequence>0.
SORT CASES InDupGrp(D).
MATCH FILES
  /FILE=*
  /DROP=PrimaryFirst InDupGrp MatchSequence.
VARIABLE LABELS  PrimaryLast 'Indicator of each last matching case as Primary'.
VALUE LABELS  PrimaryLast 0 'Duplicate Case' 1 'Primary Case'.
VARIABLE LEVEL  PrimaryLast (ORDINAL).
FREQUENCIES VARIABLES=PrimaryLast.
EXECUTE.

FILTER OFF.
USE ALL.
SELECT IF (PrimaryLast = 1).
EXECUTE.
delete variables PrimaryLast.



DATASET ACTIVATE statsec0.
ADD FILES /FILE=*
  /FILE='statsec1'.
EXECUTE.
dataset close statsec1.



* Identify Duplicate Cases.
SORT CASES BY AANGIFTE_ID(A) statsec(A).
MATCH FILES
  /FILE=*
  /BY AANGIFTE_ID
  /FIRST=PrimaryFirst
  /LAST=PrimaryLast.
DO IF (PrimaryFirst).
COMPUTE  MatchSequence=1-PrimaryLast.
ELSE.
COMPUTE  MatchSequence=MatchSequence+1.
END IF.
LEAVE  MatchSequence.
FORMATS  MatchSequence (f7).
COMPUTE  InDupGrp=MatchSequence>0.
SORT CASES InDupGrp(D).
MATCH FILES
  /FILE=*
  /DROP=PrimaryFirst InDupGrp MatchSequence.
VARIABLE LABELS  PrimaryLast 'Indicator of each last matching case as Primary'.
VALUE LABELS  PrimaryLast 0 'Duplicate Case' 1 'Primary Case'.
VARIABLE LEVEL  PrimaryLast (ORDINAL).
FREQUENCIES VARIABLES=PrimaryLast.
EXECUTE.

FILTER OFF.
USE ALL.
SELECT IF (PrimaryLast = 1).
EXECUTE.
delete variables PrimaryLast.

sort cases AANGIFTE_ID (a).



GET
  FILE=datamap +  'verwerkt\verzamelbestand.sav'.
DATASET NAME basis WINDOW=FRONT.
sort cases aangifte_id (a).



sort cases aangifte_id (a).
dataset activate basis.
MATCH FILES /FILE=*
  /TABLE='statsec0'
  /BY AANGIFTE_ID.
EXECUTE.
dataset close statsec0.






DATASET ACTIVATE basis.
RECODE statsec (''=0) (else=1) INTO has_statsec.
EXECUTE.

compute aanvraag_jaar=number(char.substr(AANVRAAG_DATUM,1,4),f4.0).
compute indien_jaar=number(char.substr(INGEDIEND_DATUM,1,4),f4.0).
EXECUTE.

FILTER OFF.
USE ALL.
SELECT IF (has_statsec = 0 & indien_jaar>=number(datajaar,f4.0)).
EXECUTE.

match files
/file=*
/keep=aangifte_id nis_code.
EXECUTE.


SAVE TRANSLATE OUTFILE=datamap + 'statsec\statsec_aangifte_id_nodig_voor_pinc.csv'
  /TYPE=CSV
  /ENCODING='Locale'
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=VALUES.

* Voor meer info over wat met dit bestand te doen, zie: 
https://vlbr.sharepoint.com/:w:/r/teams/DA-Interprovincialewerking/Gedeelde%20documenten/Ruwe%20data/Vlaams%20Energie-%20en%20Klimaatagentschap%20-%20EPB/aanpak%20verwerking%20EPB.docx?d=w9872165cbf7145a98aa5a4b17c1ccdef&csf=1&web=1&e=VYQCdi


