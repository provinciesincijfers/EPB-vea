* Encoding: windows-1252.

* OPGELET: plots aangepast datamodel.

*versie 0:
"AANGIFTE_ID",
"VENTILATIE_ZONE_ID",
"ENERGIE_SECTOR_ID",
"TYPE_VERWARMING",
"TYPE_VERWARMINGS_TOESTEL",
"INDICATOR_WARMTEPOMP",
"TYPE_WARMTEPOMP",
"WARMTEPOMP_SPF"

*versie 1 (2020) toevoeging:
DOSSIER_ID,
ENERGIEDRAGER,
WARMTEPOMP_COP,
VERMOGEN,
OPWEKKINGSRENDEMENT

*versie 2 (2021) toevoeging:
AFGIFTE_SYSTEEM


PRESERVE.
SET DECIMAL DOT.

GET DATA  /TYPE=TXT
  /FILE=datamap +  'ruw\07_AG_INSTALL_VW_WP_DETAIL.csv'
  /DELCASE=LINE
  /DELIMITERS=","
  /QUALIFIER='"'
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
TIMESTAMP_EXTRACT AUTO
  DOSSIER_ID A20
  AANGIFTE_ID A20
  VENTILATIE_ZONE_ID AUTO
  ENERGIE_SECTOR_ID AUTO
  TYPE_VERWARMING AUTO
afgifte_systeem AUTO
  TYPE_VERWARMINGS_TOESTEL AUTO
  INDICATOR_WARMTEPOMP AUTO
energiedrager AUTO
  TYPE_WARMTEPOMP AUTO
  WARMTEPOMP_SPF A30
WARMTEPOMP_COP A30
VERMOGEN A30
OPWEKKINGSRENDEMENT A30
  /MAP.
RESTORE.

CACHE.
EXECUTE.
DATASET NAME d07 WINDOW=FRONT.
dataset close d06a.

sort cases energie_sector_id (a).

compute WARMTEPOMP_SPF=replace(WARMTEPOMP_SPF,".",",").
compute WARMTEPOMP_COP=replace(WARMTEPOMP_COP,".",",").
compute VERMOGEN=replace(VERMOGEN,".",",").
compute OPWEKKINGSRENDEMENT=replace(OPWEKKINGSRENDEMENT,".",",").
alter type WARMTEPOMP_SPF (f8.2).
alter type WARMTEPOMP_COP (f8.2).
alter type VERMOGEN (f8.2).
alter type OPWEKKINGSRENDEMENT (f8.2).

if type_warmtepomp='Enkel buitenlucht-Water' lucht_water=1.
if type_warmtepomp='Bodem-Water' bodem_water=1.
if type_warmtepomp='Enkel buitenlucht-Binnenlucht' lucht_lucht=1.
if type_warmtepomp='Grondwater-Water' water_water=1.
if type_warmtepomp='Afgevoerde lucht vermengd met buitenlucht-Water' lucht_lucht=1.
if type_warmtepomp='Waterlus-Water' water_water=1.
if type_warmtepomp='Enkel buitenlucht-Ruimtelucht' lucht_lucht=1.
if type_warmtepomp='Enkel afgevoerde ventilatielucht-Water' lucht_water=1.
if type_warmtepomp='Oppervlaktewater-Water' water_water=1.
if type_warmtepomp='Enkel afgevoerde ventilatielucht-Toegevoerde ventilatielucht volledig bestaand uit buitenlucht' lucht_lucht=1.
if type_warmtepomp='Enkel buitenlucht-Toegevoerde ventilatielucht volledig bestaand uit buitenlucht' lucht_lucht=1.
if type_warmtepomp='Enkel buitenlucht-Toegevoerde ventilatielucht volledig bestaand uit buitenlucht' lucht_lucht=1.
compute type_warmtepomp_bekend=max(lucht_water,bodem_water,lucht_lucht,water_water).

* als opwekkingsrendement en warmtepomp_spf zijn ingevuld, zijn beide identiek. Opgelet: enkel doordrukken als het effectief om het vermogen van een warmtepomp gaat!.
if missing(warmtepomp_spf) & INDICATOR_WARMTEPOMP=1 warmtepomp_spf=opwekkingsrendement..


* opgelet: dit maakt abstractie van energie sector en ventilatie zone.
DATASET ACTIVATE d07.
DATASET DECLARE plat07.
AGGREGATE
  /OUTFILE='plat07'
  /BREAK=AANGIFTE_ID
  /TYPE_VERWARMING_first=FIRST(TYPE_VERWARMING) 
  /TYPE_VERWARMING_last=LAST(TYPE_VERWARMING) 
  /INDICATOR_WARMTEPOMP_max=MAX(INDICATOR_WARMTEPOMP) 
  /WARMTEPOMP_SPF_max=MAX(WARMTEPOMP_SPF)
 /lucht_water=max(lucht_water)
 /bodem_water=max(bodem_water)
 /lucht_lucht=max(lucht_lucht)
 /water_water=max(water_water)
 /type_warmtepomp_bekend=max(type_warmtepomp_bekend)
  /aantal_records_07=N.
DATASET ACTIVATE plat07.

alter type INDICATOR_WARMTEPOMP_max (f8.0).

compute begin_07=$sysmis.
compute einde_07=$sysmis.
match files
/file=*
/keep=aangifte_id
begin_07
TYPE_VERWARMING_first
TYPE_VERWARMING_last
INDICATOR_WARMTEPOMP_max
WARMTEPOMP_SPF_max
lucht_water
bodem_water
lucht_lucht
water_water
type_warmtepomp_bekend
aantal_records_07
einde_07.


SAVE OUTFILE=datamap +  'verwerkt\07_verwarming.sav'
  /COMPRESSED.

dataset close d07.
