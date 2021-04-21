* Encoding: windows-1252.


PRESERVE.
SET DECIMAL DOT.

GET DATA  /TYPE=TXT
  /FILE=datamap +  'ruw\10_AG_INSTALL_VENTILATIE.csv'
  /ENCODING='Locale'
  /DELCASE=LINE
  /DELIMITERS=","
  /QUALIFIER='"'
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
  AANGIFTE_ID A20
  VENTILATIEZONE_ID A20
  ENERGIESECTOR_ID A20
  VENTILATIE_SYSTEEM A200
  M_FACTOR A10
  REDUCTIE_FACTOR_VRAAGSTURING A10
  AANWEZIGHEID_WTW F1
  /MAP.
RESTORE.

CACHE.
EXECUTE.
DATASET NAME d10 WINDOW=FRONT.

compute m_factor=replace(m_factor,".",",").
alter type m_factor (f8.2).
compute REDUCTIE_FACTOR_VRAAGSTURING=replace(REDUCTIE_FACTOR_VRAAGSTURING,".",",").
alter type REDUCTIE_FACTOR_VRAAGSTURING (f8.3).


DATASET ACTIVATE d10.
DATASET DECLARE plat10.
AGGREGATE
  /OUTFILE='plat10'
  /BREAK=AANGIFTE_ID
  /VENTILATIE_SYSTEEM_d10=FIRST(VENTILATIE_SYSTEEM)
  /AANWEZIGHEID_WTW=max(AANWEZIGHEID_WTW).
dataset activate plat10.


SAVE OUTFILE=datamap +  'verwerkt\10_ventilatie.sav'
  /COMPRESSED.