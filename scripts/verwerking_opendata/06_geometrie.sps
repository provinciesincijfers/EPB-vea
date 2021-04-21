* Encoding: windows-1252.

PRESERVE.
SET DECIMAL DOT.

GET DATA  /TYPE=TXT
  /FILE=datamap +  'ruw\06_AG_OVERZICHT_GEOMETRIE_DETAIL.csv'
  /ENCODING='Locale'
  /DELCASE=LINE
  /DELIMITERS=","
  /QUALIFIER='"'
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
  AANGIFTE_ID A20
  VENTILATIE_ZONE_ID AUTO
  ENERGIE_SECTOR_ID AUTO
  BESCHERMD_VOLUME_EPB_EENH AUTO
  CONSTRUCTIE_TYPE AUTO
  LDH_LEK_DEBIET_50PA AUTO
  BESCHERMD_VOLUME_GEBOUW AUTO
  VERLIES_OPPERVLAKTE AUTO
  U_WAARDE AUTO
  COMPACTHEID AUTO
  REKENMETHODE_BOUWKNOPEN AUTO
  BRUTO_VLOER_OPPERVLAKTE A25
  VENSTER_OPPERVLAKTE AUTO
  GLAS_OPPERVLAKTE AUTO
  /MAP.
RESTORE.

CACHE.
EXECUTE.
DATASET NAME d06 WINDOW=FRONT.

compute BRUTO_VLOER_OPPERVLAKTE=replace(BRUTO_VLOER_OPPERVLAKTE,".",",").
alter type BRUTO_VLOER_OPPERVLAKTE (f8.2).



DATASET ACTIVATE d06.
DATASET DECLARE d06a.
AGGREGATE
  /OUTFILE='d06a'
  /BREAK=AANGIFTE_ID BRUTO_VLOER_OPPERVLAKTE
  /N_BREAK=N.
dataset activate d06a.



DATASET ACTIVATE d06a.
FILTER OFF.
USE ALL.
SELECT IF (BRUTO_VLOER_OPPERVLAKTE >  - 1).
EXECUTE.

delete variables n_break.
rename variables BRUTO_VLOER_OPPERVLAKTE=BRUTO_VLOER_OPPERVLAKTE_06.

SAVE OUTFILE=datamap +  'verwerkt\06_geometrie.sav'
  /COMPRESSED.
