* Encoding: windows-1252.

***** OPMERKING *********
* Doordat VEKA nu X-Y coördinaten bewaart in haar databank, is het niet langer nodig om dit allemaal te doen.
* Dus scripts 01, 02 en 03 vervallen.





PRESERVE.
 SET DECIMAL COMMA.

GET DATA  /TYPE=TXT
  /FILE=
    "C:\Users\plu3532\Documents\VEA\EPB\koppeling_statsec\v1\matching_tabel_epb_data_crab\matching_ta"+
    "bel_epb_data_crab.csv"
  /DELIMITERS="\t,|"
  /QUALIFIER='"'
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
  ID AUTO
  CRABCODE_ID AUTO
  CRAB_GEMEENTE_ID AUTO
  CRAB_STRAAT_ID AUTO
  CRAB_HUISNUMMER_ID AUTO
  CRAB_SUBDRES_ID AUTO
  POSTCODE AUTO
  GEMEENTE AUTO
  STRAAT AUTO
  NUMMER AUTO
  BUS AUTO
  /MAP.
RESTORE.
CACHE.
EXECUTE.
DATASET NAME epbcrab WINDOW=FRONT.


PRESERVE.
SET DECIMAL DOT.

* koppeling op basis van adressenregister.
** neem adressenregister
** vind de adressen die we nodig hebben
** schrijf weg naar bestand, koppel die in GIS aan de statsec
** haal resultaten op

GET DATA  /TYPE=TXT
  /FILE="C:\Users\plu3532\Documents\crab\gbr\datalevering op maat\4Joost\adreshuisnr.csv"
  /ENCODING='Locale'
  /DELCASE=LINE
  /DELIMITERS=","
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
  AdresID F6.0
  CrabHuisnummerID F5.0
  /MAP.
RESTORE.

CACHE.
EXECUTE.
DATASET NAME huisnr WINDOW=FRONT.
rename variables (CrabHuisnummerID
AdresID =
 CRAB_HUISNUMMER_ID
 AdresID_hnr).
sort cases CRAB_HUISNUMMER_ID (a).

PRESERVE.
SET DECIMAL DOT.

GET DATA  /TYPE=TXT
  /FILE="C:\Users\plu3532\Documents\crab\gbr\datalevering op maat\4Joost\adresmappingtosubadres.csv"    
  /DELCASE=LINE
  /DELIMITERS=","
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
  AdresID F7.0
  CrabSubadresID F6.0
  /MAP.
RESTORE.

CACHE.
EXECUTE.
DATASET NAME subadr WINDOW=FRONT.

rename variables (CrabSubadresID
AdresID =
 CRAB_SUBDRES_ID
 AdresID_sub).
sort cases CRAB_SUBDRES_ID (a).


DATASET ACTIVATE epbcrab.
sort cases CRAB_HUISNUMMER_ID (a).
MATCH FILES /FILE=*
  /TABLE='huisnr'
  /BY CRAB_HUISNUMMER_ID.
EXECUTE.

sort cases CRAB_SUBDRES_ID (a).
MATCH FILES /FILE=*
  /TABLE='subadr'
  /BY CRAB_SUBDRES_ID.
EXECUTE.

dataset close subadr.
dataset close huisnr.

IF (CRAB_HUISNUMMER_ID > 0 | CRAB_SUBDRES_ID > 0) ok_adres=1.
compute AdresID=max(AdresID_hnr,AdresID_sub).
EXECUTE.

DATASET DECLARE benodigdeadressen.
AGGREGATE
  /OUTFILE='benodigdeadressen'
  /BREAK=AdresID
  /ok_adres=sum(ok_adres).


DATASET ACTIVATE benodigdeadressen.
FILTER OFF.
USE ALL.
SELECT IF (AdresID > 0).
EXECUTE.
alter type adresid (f10.0).
alter type adresid (a10).
compute adresid=ltrim(rtrim(adresid)).
sort cases adresid (a).

GET TRANSLATE 
  FILE='C:\Users\plu3532\Documents\crab\gbr\Testbestand_latest\Adres.dbf' 
  /TYPE=DBF /MAP . 
DATASET NAME adres WINDOW=FRONT.
delete variables d_r.
compute volgnummer=$casenum.
EXECUTE.
sort cases adresid (a).




DATASET ACTIVATE adres.
MATCH FILES /FILE=*
  /TABLE='benodigdeadressen'
  /BY AdresID.
EXECUTE.

sort cases volgnummer (a).
* zorg dat er een backup is!.
SAVE TRANSLATE OUTFILE='C:\Users\plu3532\Documents\crab\gbr\Testbestand_latest\Adres.dbf'
  /TYPE=DBF
  /VERSION=4
  /MAP
  /REPLACE.

* STAPJE IN GIS.

GET TRANSLATE 
  FILE='C:\Users\plu3532\Documents\crab\gbr\Testbestand_latest\Adres_EPB_statsec.dbf' 
  /TYPE=DBF /MAP . 
DATASET NAME result WINDOW=FRONT.
match files
/file=*
/keep=adresid nis9 
straatnmid
straatnm
huisnr
busnr
postcode
gemeentenm.
EXECUTE.

alter type adresid (f10.0).
sort cases adresid (a).

rename variables (straatnmid
straatnm
huisnr
busnr
postcode
gemeentenm=
straatnmid_gbr
straatnm_gbr
huisnr_gbr
busnr_gbr
postcode_gbr
gemeentenm_gbr).

dataset activate epbcrab.
sort cases adresid (a).


DATASET ACTIVATE epbcrab.
MATCH FILES /FILE=*
  /TABLE='result'
  /BY adresid.
EXECUTE.

alter type postcode_gbr (f4.0).
alter type straatnmid_gbr (f6.0).

dataset close adres.
dataset close benodigdeadressen.
dataset close result.

rename variables nis9=statsec.



* voeg gebiedsindelingen toe om resultaten te kunnen checken.

GET DATA
  /TYPE=XLS
  /FILE='C:\temp\kerntabel.xls'
  /SHEET=name 'toewijzingstabel_alles'
  /CELLRANGE=FULL
  /READNAMES=ON
  /DATATYPEMIN PERCENTAGE=95.0.
EXECUTE.
DATASET NAME statsec WINDOW=FRONT.
match files
/file=*
/keep=statsec gemeente2018 gemeente2018_naam gemeente
gemeente_naam.
sort cases statsec (a).
rename variables
(gemeente2018
gemeente2018_naam
gemeente
gemeente_naam=
gemeente2018_ss
gemeente2018_naam_ss
gemeente_ss
gemeente_naam_ss).

DATASET ACTIVATE epbcrab.
sort cases statsec (a).
MATCH FILES /FILE=*
  /TABLE='statsec'
  /BY statsec.
EXECUTE.

dataset close statsec.
