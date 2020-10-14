* Encoding: windows-1252.

* koppel adressen op basis van:
- reeds verwerkte adressenlijst CRAB
- reeds verwerkte adresposities CRAB
- reeds verwerkte lijst straten die in slechts één statsec liggen.
* schrijf de rest weg naar een CSV om in GIS manueel te matchen.

* op basis van adreslijst.

GET
  FILE='C:\Users\plu3532\Documents\crab\CRAB_adressenlijst\crab_adressenlijst.sav'.
DATASET NAME cradadreslijst WINDOW=FRONT.


DATASET ACTIVATE cradadreslijst.
DATASET DECLARE straatnamenlijst.
AGGREGATE
  /OUTFILE='straatnamenlijst'
  /BREAK=straatnmid_adreslijst straatnm_adreslijst
  /N_BREAK=N.


DATASET ACTIVATE cradadreslijst.
DATASET DECLARE adreslijstha.
AGGREGATE
  /OUTFILE='adreslijstha'
  /BREAK=hoofdadres_id statsec_adreslijst
  /N_BREAK=N.

DATASET ACTIVATE adreslijstha.
FILTER OFF.
USE ALL.
SELECT IF (hoofdadres_id > 0).
EXECUTE.

delete variables n_break.
rename variables statsec_adreslijst = statsec_adreslijst_ha.
rename variables hoofdadres_id = CRAB_HUISNUMMER_ID.

dataset activate epbcrab.
sort cases CRAB_HUISNUMMER_ID (a).

DATASET ACTIVATE epbcrab.
MATCH FILES /FILE=*
  /TABLE='adreslijstha'
  /BY CRAB_HUISNUMMER_ID.
EXECUTE.
dataset close adreslijstha.




DATASET ACTIVATE cradadreslijst.
DATASET DECLARE adreslijstsa.
AGGREGATE
  /OUTFILE='adreslijstsa'
  /BREAK=subadres_id statsec_adreslijst
  /N_BREAK=N.

DATASET ACTIVATE adreslijstsa.
FILTER OFF.
USE ALL.
SELECT IF (subadres_id > 0).
EXECUTE.

delete variables n_break.
rename variables statsec_adreslijst = statsec_adreslijst_sa.
rename variables subadres_id = CRAB_SUBDRES_ID.

dataset activate epbcrab.
sort cases CRAB_SUBDRES_ID (a).

DATASET ACTIVATE epbcrab.
MATCH FILES /FILE=*
  /TABLE='adreslijstsa'
  /BY CRAB_SUBDRES_ID.
EXECUTE.
dataset close adreslijstsa.
dataset close cradadreslijst.



* op basis van hoofdadres, koppeltabel op basis van adresposities.
** zoals verwerkt in script C:\Users\plu3532\Documents\crab\opzet basis.sps.
GET
  FILE='C:\Users\plu3532\Documents\crab\verwerkt\koppel_statsec.sav'.
DATASET NAME koppeltabel WINDOW=FRONT.

DATASET ACTIVATE koppeltabel.
FILTER OFF.
USE ALL.
SELECT IF (geocode_typematch = 1).
EXECUTE.

match files
/file=*
/keep=geocode_huisnrid geocode_statsec_clean.
sort cases geocode_huisnrid (a).

rename variables geocode_huisnrid = CRAB_HUISNUMMER_ID.

dataset activate epbcrab.
sort cases CRAB_HUISNUMMER_ID (a).

DATASET ACTIVATE epbcrab.
MATCH FILES /FILE=*
  /TABLE='koppeltabel'
  /BY CRAB_HUISNUMMER_ID.
EXECUTE.
dataset close koppeltabel.



* adresposities verder verwerkt: unieke combinaties van straatnamen en statsec.
** voorbereid in script C:\Users\plu3532\Documents\crab\opzet straatnaam.sps.
GET
  FILE='C:\Users\plu3532\Documents\crab\verwerkt\koppel_statsec_op_straatnaam.sav'.
DATASET NAME straatnaam WINDOW=FRONT.

DATASET ACTIVATE straatnaam.
sort cases streetcode_straatnaam_id (a).
rename variables streetcode_straatnaam_id=CRAB_STRAAT_ID.


dataset activate epbcrab.
sort cases CRAB_STRAAT_ID (a).

DATASET ACTIVATE epbcrab.
MATCH FILES /FILE=*
  /TABLE='straatnaam'
  /BY CRAB_STRAAT_ID.
EXECUTE.
dataset close straatnaam.



dataset activate straatnamenlijst.
delete variables n_break.
RENAME VARIABLES straatnmid_adreslijst=CRAB_STRAAT_ID.
sort cases CRAB_STRAAT_ID (a).
DATASET ACTIVATE epbcrab.
sort cases CRAB_STRAAT_ID (a).
MATCH FILES /FILE=*
  /TABLE='straatnamenlijst'
  /BY CRAB_STRAAT_ID.
EXECUTE.
dataset close straatnamenlijst.


string statsec_def (a9).
compute statsec_def=statsec.
if statsec_def="" statsec_def=statsec_adreslijst_sa.
if statsec_def="" statsec_def=statsec_adreslijst_ha.
if statsec_def="" statsec_def=geocode_statsec_clean.
if statsec_def="" statsec_def=streetcode_statsec_clean.
EXECUTE.


sort cases statsec_def (a) POSTCODE (a)
GEMEENTE (a)
STRAAT (a)
NUMMER (a).

compute volgnummer=$casenum.


AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES
  /BREAK=statsec_def POSTCODE GEMEENTE STRAAT NUMMER
  /volgnummer_first=FIRST(volgnummer).

SAVE OUTFILE='C:\Users\plu3532\Documents\VEA\EPB\koppeling_statsec\v1\matching_tabel_epb_data_crab\matching_adressenregister_crab.sav'
  /COMPRESSED.




DATASET DECLARE werk.
AGGREGATE
  /OUTFILE='werk'
  /BREAK=volgnummer_first statsec_def POSTCODE GEMEENTE STRAAT NUMMER
 /straatnm_adreslijst_first=first(straatnm_adreslijst)
/straatnm_adreslijst_last=last(straatnm_adreslijst)
  /N_BREAK=N.
dataset activate werk.

DATASET ACTIVATE werk.
FILTER OFF.
USE ALL.
SELECT IF (statsec_def ="").
EXECUTE.
delete variables statsec_def.




compute testvr=CHAR.INDEX(STRAAT,"?").
EXECUTE.
compute straatnm_adreslijst_first=REPLACE(straatnm_adreslijst_first,"³","ü").
compute straatnm_adreslijst_first=REPLACE(straatnm_adreslijst_first,"Ù","ë").
compute straatnm_adreslijst_first=REPLACE(straatnm_adreslijst_first,"Þ","è").
compute straatnm_adreslijst_first=REPLACE(straatnm_adreslijst_first,"Ú","é").
compute straatnm_adreslijst_first=REPLACE(straatnm_adreslijst_first,"þ","ç").
EXECUTE.

if straatnm_adreslijst_first~="" & testvr>0 STRAAT=straatnm_adreslijst_first.
EXECUTE.

delete variables straatnm_adreslijst_first
straatnm_adreslijst_last testvr.


SAVE TRANSLATE OUTFILE='C:\Users\plu3532\Documents\VEA\EPB\koppeling_statsec\v1\matching_tabel_epb_data_crab\manuele_lijst.csv'
  /TYPE=CSV
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=VALUES.
