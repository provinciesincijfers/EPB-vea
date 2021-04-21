* Encoding: windows-1252.

GET
  FILE=datamap +  'verwerkt\11_basis.sav'.
DATASET NAME basis WINDOW=FRONT.
sort cases aangifte_id (a).

dataset close plat11.

GET
  FILE=datamap +  'verwerkt\05_overzicht_resultaten.sav'.
DATASET NAME d05 WINDOW=FRONT.
sort cases aangifte_id (a).
dataset activate basis.
MATCH FILES /FILE=*
  /FILE='d05'
  /BY AANGIFTE_ID.
EXECUTE.
dataset close d05.

GET
  FILE=datamap +  'verwerkt\06_geometrie.sav'.
DATASET NAME d06 WINDOW=FRONT.
sort cases aangifte_id (a).
dataset activate basis.
MATCH FILES /FILE=*
  /FILE='d06'
  /BY AANGIFTE_ID.
EXECUTE.
dataset close d06.

GET
  FILE=datamap +  'verwerkt\07_verwarming.sav'.
DATASET NAME d07 WINDOW=FRONT.
sort cases aangifte_id (a).
dataset activate basis.
MATCH FILES /FILE=*
  /FILE='d07'
  /BY AANGIFTE_ID.
EXECUTE.
dataset close d07.


GET
  FILE=datamap +  'verwerkt\08_productie.sav'.
DATASET NAME d08 WINDOW=FRONT.
sort cases aangifte_id (a).
dataset activate basis.
MATCH FILES /FILE=*
  /FILE='d08'
  /BY AANGIFTE_ID.
EXECUTE.
dataset close d08.


GET
  FILE=datamap +  'verwerkt\09_zonnepanelen.sav'.
DATASET NAME d09 WINDOW=FRONT.
sort cases aangifte_id (a).
dataset activate basis.
MATCH FILES /FILE=*
  /FILE='d09'
  /BY AANGIFTE_ID.
EXECUTE.
dataset close d09.

GET
  FILE=datamap +  'verwerkt\10_ventilatie.sav'.
DATASET NAME d10 WINDOW=FRONT.
sort cases aangifte_id (a).
dataset activate basis.
MATCH FILES /FILE=*
  /FILE='d10'
  /BY AANGIFTE_ID.
EXECUTE.
dataset close d10.


SAVE OUTFILE=datamap +  'verwerkt\verzamelbestand.sav'
  /COMPRESSED.
