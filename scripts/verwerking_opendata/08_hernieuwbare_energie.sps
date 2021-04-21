* Encoding: windows-1252.


PRESERVE.
SET DECIMAL DOT.

GET DATA  /TYPE=TXT
  /FILE=datamap +  'ruw\08_AG_INSTALL_HEB_DETAIL.csv'
  /ENCODING='Locale'
  /DELCASE=LINE
  /DELIMITERS=","
  /QUALIFIER='"'
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
  AANGIFTE_ID A20
  TOTAAL_HEB_EENH_OPP a10
  TOTAAL_EIS_HEB_EENH_OPP f8
  HEB_SYSTEEM_ID f8
  HEB_TYPE_SYSTEEM a100
  QRE_EENH_OPP a10
  EIS_HEB_EENH_OPP f8.0
  /MAP.
RESTORE.

CACHE.
EXECUTE.
DATASET NAME d08 WINDOW=FRONT.

compute TOTAAL_HEB_EENH_OPP=replace(TOTAAL_HEB_EENH_OPP,".",",").
compute QRE_EENH_OPP=replace(QRE_EENH_OPP,".",",").
alter type TOTAAL_HEB_EENH_OPP QRE_EENH_OPP (f8.2).

if heb_type_systeem='BIOMASSA' prod_biomassa=qre_eenh_opp.
if heb_type_systeem='FOTOVOLTAISCH_ZONNE_ENERGIESYSTEEM' prod_zonnepaneel=qre_eenh_opp.
if heb_type_systeem='PARTICIPATIE' prod_participatie=qre_eenh_opp.
if heb_type_systeem='STADSVERWARMING_OF_KOELING' prod_stadsnet=qre_eenh_opp.
if heb_type_systeem='WARMTEPOMP' prod_warmtepomp=qre_eenh_opp.
if heb_type_systeem='ZONNE_THERMISCH_ENERGIESYSTEEM' prod_zonnecollector=qre_eenh_opp.
EXECUTE.

compute leeg=$sysmis.

DATASET ACTIVATE d08.
DATASET DECLARE plat08.
AGGREGATE
  /OUTFILE='plat08'
  /BREAK=AANGIFTE_ID
  /begin_08=first(leeg)
  /TOTAAL_HEB_EENH_OPP=MAX(TOTAAL_HEB_EENH_OPP) 
  /TOTAAL_EIS_HEB_EENH_OPP=MAX(TOTAAL_EIS_HEB_EENH_OPP) 
  /prod_biomassa=MAX(prod_biomassa) 
  /prod_zonnepaneel=MAX(prod_zonnepaneel) 
  /prod_participatie=MAX(prod_participatie) 
  /prod_stadsnet=MAX(prod_stadsnet) 
  /prod_warmtepomp=MAX(prod_warmtepomp) 
  /prod_zonnecollector=MAX(prod_zonnecollector)
 /einde_08=first(leeg).
dataset activate plat08.


SAVE OUTFILE=datamap +  'verwerkt\08_productie.sav'
  /COMPRESSED.
