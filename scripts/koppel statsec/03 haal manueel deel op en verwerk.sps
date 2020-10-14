* Encoding: windows-1252.
GET
  FILE='C:\Users\plu3532\Documents\VEA\EPB\koppeling_statsec\v1\matching_tabel_epb_data_crab\matching_adressenregister_crab.sav'.
DATASET NAME crabadreslijst WINDOW=FRONT.




GET DATA
  /TYPE=XLSX
  /FILE=
    'C:\Users\plu3532\Documents\VEA\EPB\koppeling_statsec\v1\matching_tabel_epb_data_crab\tabfin.xlsx'
  /SHEET=name 'Blad1'
  /CELLRANGE=FULL
  /READNAMES=ON
  /DATATYPEMIN PERCENTAGE=95.0
  /HIDDEN IGNORE=YES.
EXECUTE.
DATASET NAME manueel WINDOW=FRONT.

DATASET ACTIVATE manueel.
FILTER OFF.
USE ALL.
SELECT IF (volgnummer_first >-1).
EXECUTE.

MATCH FILES
/file=*
/keep=volgnummer_first
codsec type_fin.
sort cases volgnummer_first (a).


DATASET ACTIVATE crabadreslijst.
MATCH FILES /FILE=*
  /TABLE='manueel'
  /BY volgnummer_first.
EXECUTE.
dataset close manueel.

if statsec_def="" statsec_def=codsec.
EXECUTE.


if statsec~="" type_match=1.
if statsec="" & statsec_adreslijst_sa~=""  type_match=2.
if statsec="" & statsec_adreslijst_sa="" & statsec_adreslijst_ha~="" type_match=3.
if statsec="" & statsec_adreslijst_sa="" & statsec_adreslijst_ha="" & geocode_statsec_clean~="" type_match=4.
if statsec="" & statsec_adreslijst_sa="" & statsec_adreslijst_ha="" & geocode_statsec_clean="" & streetcode_statsec_clean~="" type_match=5.
if statsec="" & statsec_adreslijst_sa="" & statsec_adreslijst_ha="" & geocode_statsec_clean="" & streetcode_statsec_clean="" & codsec~="" type_match=6.
if statsec_def="" type_match=7.
freq type_match.


value labels type_match
1 'Adressenregister - op basis van koppeltabel'
2 'CRAB adressenlijst - op basis van CRAB-id subadres'
3 'CRAB adressenlijst  - op basis CRAB-id hoofdadres'
4 'CRAB adresposities - op basis CRAB-id hoofdadres'
5 'CRAB adresposities - straatcode bestaat in slechts één statsec'
6 'overige, manuele match (houdt niet steeds rekening met huisnummer)'
7 'geen match'.

delete variables gemeente2018_ss
gemeente2018_naam_ss
gemeente_ss
gemeente_naam_ss.


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
(statsec gemeente2018
gemeente2018_naam
gemeente
gemeente_naam=
statsec_def gemeente2018_ss
gemeente2018_naam_ss
gemeente_ss
gemeente_naam_ss).

DATASET ACTIVATE crabadreslijst.
sort cases statsec_def (a).
MATCH FILES /FILE=*
  /TABLE='statsec'
  /BY statsec_def.
EXECUTE.



* enkele fouten in oorspronkelijk veld gemeente.
** gemeente met spaties die wegvallen
** lag in een andere gemeente die nu wel tot dezelfde fusie behoort
** was een onofficiële schrijfwijze.
** was een andere dan gewoonlijke schrijfwijze.

string gemeente_orig_cleaned (a21).
compute gemeente_orig_cleaned = gemeente.
recode gemeente_orig_cleaned ('DeHaan'='De Haan') ('DePanne'='De Panne') ('DePinte'='De Pinte')
('Kruishoutem'='Kruisem')
('Meeuwen-Gruitrode'='Oudsbergen')
('Overpelt'='Pelt')
('Glabbeek-Zuurbemde'='Glabbeek')
('Moerbeke-waas'='Moerbeke')
('Beveren-Waas'='Beveren')
('Nieuwrode'='Holsbeek')
('AFFLIGEM'='Affligem')
('Heist-op-den-Berg'='Heist-Op-Den-Berg')
('Herk-de-Stad'='Herk-De-Stad')
('Kapelle-op-den-Bos'='Kapelle-Op-Den-Bos')
('nieuwpoort'='Nieuwpoort').
if CHAR.INDEX(gemeente,"(")>0 gemeente_orig_cleaned = ltrim(rtrim(char.substr(gemeente,1,CHAR.INDEX(gemeente,"(")-1))).
EXECUTE.

compute statsec_in_juiste_gemeente = 0.
if lower(gemeente_orig_cleaned)=lower(gemeente2018_naam_ss) | lower(gemeente_orig_cleaned)=lower(gemeente_naam_ss) statsec_in_juiste_gemeente=1.
if statsec_def="" | gemeente_orig_cleaned="" statsec_in_juiste_gemeente= -1.
freq statsec_in_juiste_gemeente.

DATASET ACTIVATE statsec.
DATASET DECLARE gemeente.
AGGREGATE
  /OUTFILE='gemeente'
  /BREAK=gemeente_naam gemeente
  /N_BREAK=N.

DATASET DECLARE gemeentemism.
AGGREGATE
  /OUTFILE='gemeentemism'
  /BREAK=gemeente_naam gemeente gemeente2018 gemeente2018_naam
  /N_BREAK=N.
dataset activate gemeentemism.
dataset close statsec.

FILTER OFF.
USE ALL.
SELECT IF (gemeente_naam ~= gemeente2018_naam).
EXECUTE.
match files
/file=*
/keep=gemeente2018_naam gemeente.
rename variables gemeente2018_naam = gemeente_naam.

ADD FILES /FILE=*
  /FILE='gemeente'
  /RENAME (N_BREAK=d0)
  /DROP=d0.
EXECUTE.
dataset close gemeente.

sort cases gemeente_naam (a).
rename variables gemeente_naam = gemeente_orig_cleaned.
rename variables gemeente=niscode_epb.
alter type gemeente_orig_cleaned (a21).

FILTER OFF.
USE ALL.
SELECT IF (niscode_epb<99990).
EXECUTE.

DATASET ACTIVATE crabadreslijst.
sort cases gemeente_orig_cleaned (a).
MATCH FILES /FILE=*
  /TABLE='gemeentemism'
  /BY gemeente_orig_cleaned.
EXECUTE.


if statsec_in_juiste_gemeente= -1 & statsec_def="" & niscode_epb>0 statsec_def=concat(ltrim(rtrim(string(niscode_epb,f5.0))),"ZZZZ").
if statsec_in_juiste_gemeente= 0 statsec_def=concat(ltrim(rtrim(string(niscode_epb,f5.0))),"ZZZZ").
if statsec_def="" statsec_def='99991ZZZZ'.
EXECUTE.

SAVE OUTFILE='C:\Users\plu3532\Documents\VEA\EPB\koppeling_statsec\v1\matching_tabel_epb_data_crab\matching_epb_colledig_verwerkt.sav'
  /COMPRESSED.

RENAME VARIABLES statsec_def=statsec.
match files
/file=*
/keep=ID gemeente gemeente_orig_cleaned statsec type_match statsec_in_juiste_gemeente.
EXECUTE.
SAVE TRANSLATE OUTFILE='C:\Users\plu3532\Documents\VEA\EPB\koppeling_statsec\v1\matching_tabel_epb_data_crab\matching_tabel_epb_data_crab_RESULTS_BREED.csv'
  /TYPE=CSV
  /ENCODING='Locale'
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=VALUES.

match files
/file=*
/keep=ID statsec.
EXECUTE.
SAVE TRANSLATE OUTFILE='C:\Users\plu3532\Documents\VEA\EPB\koppeling_statsec\v1\matching_tabel_epb_data_crab\matching_tabel_epb_data_crab_RESULTS_SMAL.csv'
  /TYPE=CSV
  /ENCODING='Locale'
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=VALUES.

dataset activate gemeentemism.
dataset close crabadreslijst.
