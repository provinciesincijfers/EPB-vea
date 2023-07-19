* Encoding: windows-1252.

* todo:
- check mediaan statsec; check ontbreken totaal warmtepomp
- lange termijn: statsec onbekend voor de nieuwe fusies


* haal de data binnen die we reeds eerder kregen.
* die staan bij Ruwe data > VEKA - EPB > koppeling statsec > ontvangen_van_veka > resultaten
* link: https://vlbr.sharepoint.com/teams/DA-Interprovincialewerking/Gedeelde%20documenten/Forms/AllItems.aspx?FolderCTID=0x012000D68A3A593CBA7B4C92385183F8DFDDCA&id=%2Fteams%2FDA%2DInterprovincialewerking%2FGedeelde%20documenten%2FRuwe%20data%2FVEKA%20%2D%20EPB%2Fkoppeling%20statsec%2Fontvangen%5Fvan%5Fveka%2Fresultaten&viewid=462803fb%2D51fe%2D4295%2D8e1e%2Da1af786d79d1 .
* ELK JAAR MOET JE HIER DUS EEN BESTAND TOEVOEGEN.
* eerst kuisen we de dubbels op binnen een bestand, met voorkeur voor gevulde rijen.
* vervolgens voegen we alle bestanden samen, en kuisen de dubbels opnieuw op (want er zijn lege rijen in oude bestanden die in nieuwe opgevuld zijn?!).
* in "94_verwerken_statsec" zal dat nieuwe bestand reeds ingeladen worden, je kunt daar de code gaan ophalen.


* BEGIN inlezen en uitkuisen 2019.
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
* EINDE inlezen en uitkuisen 2019.



* BEGIN inlezen en uitkuisen 2021 (dit bestand bevat ook de data voor 2020).
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

* EINDE inlezen en uitkuisen 2021.



* BEGIN inlezen en uitkuisen 2022.
GET DATA  /TYPE=TXT
  /FILE=datamap + 'statsec\ontvangen_van_veka\resultaten\2022_mapping_aangifte_id_statistische_sector_voor_pic.csv'
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
DATASET NAME statsec2 WINDOW=FRONT.
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


* EINDE inlezen en uitkuisen 2019.

* TODO: HIER 2023 toevoegen om de data in januari correct te kunnen verwerken.

* SAMENVOEGEN van alle bestanden.
* TODO hier de data van 2023 als statsec3 o.i.d. toevoegen.
DATASET ACTIVATE statsec0.
ADD FILES /FILE=*
  /FILE='statsec1'
  /FILE='statsec2'.
EXECUTE.
dataset close statsec1.
dataset close statsec2.


* BEGIN uitkuisen samengevoegd bestand.

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

* EINDE uitkuisen samengevoegd bestand.


* BEGIN: filteren van te verwerken nieuwe dossiers.
* we hebben nu een bestand met alle reeds verwerkte dossiers.
* om te weten welke dossiers nog een statsec nodig hebben, verrijken we het verzamelbestand met deze info.
* wie nog geen statsec heeft, moet die dus nog krijgen.

* haal verzamelbestand op.
GET
  FILE=datamap +  'verwerkt\verzamelbestand.sav'.
DATASET NAME basis WINDOW=FRONT.
sort cases aangifte_id (a).


* koppel het bestand met de statsec.
sort cases aangifte_id (a).
dataset activate basis.
MATCH FILES /FILE=*
  /TABLE='statsec0'
  /BY AANGIFTE_ID.
EXECUTE.
dataset close statsec0.


* wie heeft al een statsec?.
DATASET ACTIVATE basis.
RECODE statsec (''=0) (else=1) INTO has_statsec.
EXECUTE.

* wanneer werden de dossiers aangemaakt?.
compute aanvraag_jaar=number(char.substr(AANVRAAG_DATUM,1,4),f4.0).
compute indien_jaar=number(char.substr(INGEDIEND_DATUM,1,4),f4.0).
EXECUTE.

* we houden enkel records over die nog geen statsec hebben en die voor het recentste jaar zijn.
FILTER OFF.
USE ALL.
SELECT IF (has_statsec = 0 & indien_jaar>=number(datajaar,f4.0)).
EXECUTE.


match files
/file=*
/keep=aangifte_id nis_code.
EXECUTE.

SAVE TRANSLATE OUTFILE=datamap + 'statsec\statsec_aangifte_id_nodig_voor_pinc_data' + datajaar + '.csv'
  /TYPE=CSV
  /ENCODING='Locale'
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=VALUES.

* Voor meer info over wat met dit bestand te doen, zie: 
https://vlbr.sharepoint.com/:w:/r/teams/DA-Interprovincialewerking/Gedeelde%20documenten/Ruwe%20data/Vlaams%20Energie-%20en%20Klimaatagentschap%20-%20EPB/aanpak%20verwerking%20EPB.docx?d=w9872165cbf7145a98aa5a4b17c1ccdef&csf=1&web=1&e=VYQCdi


