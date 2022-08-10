* Encoding: windows-1252.

PRESERVE.
SET DECIMAL DOT.

GET DATA  /TYPE=TXT
  /FILE=datamap +  'ruw\09_AG_INSTALL_ZON_DETAIL.csv'
  /DELIMITERS=","
  /QUALIFIER='"'
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
TIMESTAMP_EXTRACT auto
  AANGIFTE_ID A20
  THERMISCHE_ZONNE_ENERGIE_ID F4.0
  COLLECTOR_ID F4.0
  APERTUUR_OPPERVLAKTE A20
  ORIENTATIE_TH_PANELEN A20
  HELLING_TH_PANELEN A20
  INDICATOR_PV_PANELEN A20
  PV_PANELEN_ID F4.0
  AANTAL_PV_PANELEN F4.0
  HELLING_PV_PANELEN A20
  OMVORMER_PV_PANELEN A200
  OPSTELLING_PV_PANELEN A200
  ORIENTATIE_PV_PANELEN A20
  OPGEWEKTE_STROOM_PV_PANELEN A20
  /MAP.
RESTORE.
CACHE.
EXECUTE.
DATASET NAME d09 WINDOW=FRONT.
dataset close plat08.

* data proper inlezen.
compute APERTUUR_OPPERVLAKTE=replace(APERTUUR_OPPERVLAKTE,'.',',').
compute ORIENTATIE_TH_PANELEN=replace(ORIENTATIE_TH_PANELEN,'.',',').
compute HELLING_TH_PANELEN=replace(HELLING_TH_PANELEN,'.',',').
compute INDICATOR_PV_PANELEN=replace(INDICATOR_PV_PANELEN,'.',',').
compute HELLING_PV_PANELEN=replace(HELLING_PV_PANELEN,'.',',').
compute ORIENTATIE_PV_PANELEN=replace(ORIENTATIE_PV_PANELEN,'.',',').
compute OPGEWEKTE_STROOM_PV_PANELEN=replace(OPGEWEKTE_STROOM_PV_PANELEN,'.',',').
alter type APERTUUR_OPPERVLAKTE (F8.2).
alter type ORIENTATIE_TH_PANELEN (F8.2).
alter type HELLING_TH_PANELEN (F8.2).
alter type INDICATOR_PV_PANELEN (F8.2).
alter type HELLING_PV_PANELEN (F8.2).
alter type ORIENTATIE_PV_PANELEN (F8.2).
alter type OPGEWEKTE_STROOM_PV_PANELEN (F8.2).


* voorbereiden data over zonnecollector.
* dubbels door PV wegwerken.
DATASET ACTIVATE d09.
DATASET DECLARE collector.
AGGREGATE
  /OUTFILE='collector'
  /BREAK=AANGIFTE_ID THERMISCHE_ZONNE_ENERGIE_ID
  /APERTUUR_OPPERVLAKTE_max=MAX(APERTUUR_OPPERVLAKTE)
  /N_BREAK=N.

* data zonder collector weggooien.
DATASET ACTIVATE collector.
FILTER OFF.
USE ALL.
SELECT IF (THERMISCHE_ZONNE_ENERGIE_ID > 0).
EXECUTE.

* het aantal rijen per dossier (toevallig altijd 1) geeft mee of er al of niet een collector is.
* de oppervlakte geven we ook mee (pas ingevuld vanaf 2017).
DATASET DECLARE collectorbis.
AGGREGATE
  /OUTFILE='collectorbis'
  /BREAK=AANGIFTE_ID
  /zonnecollector_opp=SUM(APERTUUR_OPPERVLAKTE_max)
  /thermische_zonne_energie=N.
* hier komen we later op terug.

dataset activate d09.
dataset close collector.
* indicatoren maken.
if PV_PANELEN_ID >0 pv_panelen=1.



* optellen of max bij aggregeren naar aangifte_id.


DATASET ACTIVATE d09.
DATASET DECLARE pvpanelen.
AGGREGATE
  /OUTFILE='pvpanelen'
  /BREAK=PV_PANELEN_ID
  /AANGIFTE_ID=FIRST(AANGIFTE_ID) 
  /OPGEWEKTE_STROOM_PV_PANELEN=MAX(OPGEWEKTE_STROOM_PV_PANELEN).

DATASET DECLARE aangiftepanelen.
AGGREGATE
  /OUTFILE='aangiftepanelen'
  /BREAK=AANGIFTE_ID
  /pv_panelen=MAX(pv_panelen).

DATASET ACTIVATE pvpanelen.
FILTER OFF.
USE ALL.
SELECT IF (PV_PANELEN_ID >0).
EXECUTE.

DATASET DECLARE totstroom.
AGGREGATE
  /OUTFILE='totstroom'
  /BREAK=AANGIFTE_ID
  /OPGEWEKTE_STROOM_PV_PANELEN=SUM(OPGEWEKTE_STROOM_PV_PANELEN).



DATASET ACTIVATE aangiftepanelen.
MATCH FILES /FILE=*
  /TABLE='totstroom'
  /BY AANGIFTE_ID.
EXECUTE.

MATCH FILES /FILE=*
  /TABLE='collectorbis'
  /BY AANGIFTE_ID.
EXECUTE.

dataset close totstroom.
dataset close pvpanelen.
dataset close collectorbis.
dataset close d09.

compute begin_09=$sysmis.
compute einde_09=$sysmis.
match files
/file=*
/keep=aangifte_id
begin_09
thermische_zonne_energie
pv_panelen
OPGEWEKTE_STROOM_PV_PANELEN
zonnecollector_opp
einde_09.
EXECUTE.


SAVE OUTFILE=datamap +  'verwerkt\09_zonnepanelen.sav'
  /COMPRESSED.
