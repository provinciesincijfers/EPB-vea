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
  APERTUUR_OPPERVLAKTE F4.0
  ORIENTATIE_TH_PANELEN F5.0
  HELLING_TH_PANELEN F5.0
  INDICATOR_PV_PANELEN F4.0
  PV_PANELEN_ID F4.0
  AANTAL_PV_PANELEN F4.0
  HELLING_PV_PANELEN F4.0
  OMVORMER_PV_PANELEN A200
  OPSTELLING_PV_PANELEN A200
  ORIENTATIE_PV_PANELEN F5.0
  OPGEWEKTE_STROOM_PV_PANELEN F4.0
  /MAP.
RESTORE.
CACHE.
EXECUTE.
DATASET NAME d09 WINDOW=FRONT.

dataset close plat08.

* indicatoren maken.
if THERMISCHE_ZONNE_ENERGIE_ID>0 thermische_zonne_energie=1.
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
  /thermische_zonne_energie=MAX(thermische_zonne_energie) 
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

dataset close totstroom.
dataset close pvpanelen.
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
einde_09.
EXECUTE.


SAVE OUTFILE=datamap +  'verwerkt\09_zonnepanelen.sav'
  /COMPRESSED.


