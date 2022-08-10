* Encoding: windows-1252.
* nieuw 2021: type koeling.

PRESERVE.
SET DECIMAL DOT.

GET DATA  /TYPE=TXT
  /FILE=datamap +  'ruw\10_AG_INSTALL_VENTILATIE.csv'
  /DELCASE=LINE
  /DELIMITERS=","
  /QUALIFIER='"'
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
TIMESTAMP_EXTRACT auto
  AANGIFTE_ID A20
  VENTILATIEZONE_ID A20
  ENERGIESECTOR_ID A20
  VENTILATIE_SYSTEEM A200
  M_FACTOR A10
  REDUCTIE_FACTOR_VRAAGSTURING A10
  AANWEZIGHEID_WTW F1
TYPE_KOELING a25
  /MAP.
RESTORE.

CACHE.
EXECUTE.
DATASET NAME d10 WINDOW=FRONT.

dataset close aangiftepanelen.

compute m_factor=replace(m_factor,".",",").
alter type m_factor (f8.2).
compute REDUCTIE_FACTOR_VRAAGSTURING=replace(REDUCTIE_FACTOR_VRAAGSTURING,".",",").
alter type REDUCTIE_FACTOR_VRAAGSTURING (f8.3).

recode TYPE_KOELING
('actieve koeling'=1)
('centrale koeling'=1)
('geen actieve koeling'=0)
('plaatselijke koeling'=1) into koeling.

recode VENTILATIE_SYSTEEM
('geen'=0)
('natuurlijke toevoer, natuurlijke afvoer (A)'=1)
('mechanische toevoer, vrije afvoer (B)'=2)
('vrije toevoer, mechanische afvoer (C)'=3)
('mechanische toevoer, mechanische afvoer (D)'=4) into VENTILATIE_SYSTEEM_num.
value labels VENTILATIE_SYSTEEM_num
0 'geen'
1 'natuurlijke toevoer, natuurlijke afvoer (A)'
2 'mechanische toevoer, vrije afvoer (B)'
3 'vrije toevoer, mechanische afvoer (C)'
4 'mechanische toevoer, mechanische afvoer (D)'.



* er zijn aangiftes met gedeeltelijk wel, gedeeltelijk geen koeling. Er is echter geen opp per zone beschikbaar om een inschatting van het belang van de uimtes te maken. 
* De overgrote meerderheid van aangiftes mét koeling hebben overal koeling. Dus beschouwen we hier als -met koeling- alles wat iets van koeling heeft.
* zelfde issues met de ventilaitiesystemen. Hier nemen we met "meest geavanceerde" systeem als basis.
DATASET ACTIVATE d10.
DATASET DECLARE plat10.
AGGREGATE
  /OUTFILE='plat10'
  /BREAK=AANGIFTE_ID
  /VENTILATIE_SYSTEEM_num=MAX(VENTILATIE_SYSTEEM_num)
  /AANWEZIGHEID_WTW=max(AANWEZIGHEID_WTW)
  /koeling=max(koeling).
dataset activate plat10.


SAVE OUTFILE=datamap +  'verwerkt\10_ventilatie.sav'
  /COMPRESSED.

dataset close d10.
