* Encoding: windows-1252.
* set file locations first!.
* check nieuwe velden 2021:
S_PEIL
S_PEIL_EIS
TOTAAL_PRIMAIR_ENERGIEVERBRUIK
PRIMAIR_EB_WKK
PRIMAIR_EV_VERWARMING
PRIMAIR_EV_TAPWATER
PRIMAIR_EB_PV
PRIMAIR_EV_KOELING
PRIMAIR_EV_HULPENERGIE.




PRESERVE.
SET DECIMAL DOT.
GET DATA  /TYPE=TXT
  /FILE=datamap +  'ruw\05_AG_OVERZICHT_RESULTATEN_DETAIL.csv'
  /DELCASE=LINE
  /DELIMITERS=","
  /QUALIFIER='"'
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
  TIMESTAMP_EXTRACT AUTO
  AANGIFTE_ID A20
  E_PEIL AUTO
  E_EIS AUTO
  K_PEIL AUTO
  K_EIS AUTO
S_PEIL AUTO
S_PEIL_EIS AUTO
  PRIMAIR_ENERGIE_VERBRUIK_M2 a30
TOTAAL_PRIMAIR_ENERGIEVERBRUIK AUTO
PRIMAIR_EB_WKK AUTO
PRIMAIR_EV_VERWARMING AUTO
PRIMAIR_EV_TAPWATER AUTO
PRIMAIR_EB_PV AUTO
PRIMAIR_EV_KOELING AUTO
PRIMAIR_EV_HULPENERGIE AUTO
  INDICATOR_VOLDOEN_VENTILATIE AUTO
  INDICATOR_VOLDOEN_OVERVERH AUTO
  INDICATOR_VOLDOEN_U_R AUTO
  NEB_VOOR_VERWARMING a30
  NEB_VOOR_VERW_EENH_OPP a30
  INDICATOR_VOLDOEN_INST_EIS auto
  /MAP.
RESTORE.

CACHE.
EXECUTE.
DATASET NAME d05 WINDOW=FRONT.

* geen dubbels verwacht, maar toch effe checken.
DATASET ACTIVATE d05.
AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES
  /BREAK=AANGIFTE_ID
  /N_BREAK=N.
freq N_BREAK.
delete variables n_break.

* deze drie statements geven foutmeldingen omdat er niet steeds iets is ingevuld.
compute PRIMAIR_ENERGIE_VERBRUIK_M2=replace(PRIMAIR_ENERGIE_VERBRUIK_M2,".",",").
compute NEB_VOOR_VERWARMING=replace(NEB_VOOR_VERWARMING,".",",").
compute NEB_VOOR_VERW_EENH_OPP=replace(NEB_VOOR_VERW_EENH_OPP,".",",").
alter type E_PEIL
E_EIS
INDICATOR_VOLDOEN_VENTILATIE
INDICATOR_VOLDOEN_OVERVERH
INDICATOR_VOLDOEN_U_R (f8.0).
alter type 
NEB_VOOR_VERWARMING
NEB_VOOR_VERW_EENH_OPP
PRIMAIR_ENERGIE_VERBRUIK_M2 (f8.2).

compute begin_05=$sysmis.
compute einde_05=$sysmis.
match files
/file=*
/keep=aangifte_id
begin_05
E_PEIL
E_EIS
PRIMAIR_ENERGIE_VERBRUIK_M2
TOTAAL_PRIMAIR_ENERGIEVERBRUIK
INDICATOR_VOLDOEN_VENTILATIE
INDICATOR_VOLDOEN_OVERVERH
INDICATOR_VOLDOEN_U_R
NEB_VOOR_VERWARMING
NEB_VOOR_VERW_EENH_OPP
einde_05.



SAVE OUTFILE=datamap +  'verwerkt\05_overzicht_resultaten.sav'
  /COMPRESSED.


