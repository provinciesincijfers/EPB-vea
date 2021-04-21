* Encoding: windows-1252.

* TODO: controleren te veel of te weinig gemeenten. Afhandelen Brussel.

* dit script laat toe om de data te verwerken tot op gemeenteniveau, zonder een overeenkomst met de leverancier.

GET
  FILE=datamap +  'verwerkt\verzamelbestand.sav'.
DATASET NAME basis WINDOW=FRONT.

* corrigeer enkele foutjes in de dump.
recode nis_code (24302=24104) (22002=23099).




* verwijder foute niscodes.
recode nis_code
(12030=12041)
(12034=12041)
(44011=44083)
(44049=44083)
(44001=44084)
(44029=44084)
(44036=44085)
(44072=44085)
(44080=44085)
(45017=45068)
(45057=45068)
(71047=72042)
(72040=72042)
(72025=72043)
(72029=72043)
(else=copy) into niscode_nieuwegemeenten.

recode niscode_nieuwegemeenten
(11001=10000)
(11002=10000)
(11004=10000)
(11005=10000)
(11007=10000)
(11008=10000)
(11009=10000)
(11013=10000)
(11016=10000)
(11018=10000)
(11021=10000)
(11022=10000)
(11023=10000)
(11024=10000)
(11025=10000)
(11029=10000)
(11030=10000)
(11035=10000)
(11037=10000)
(11038=10000)
(11039=10000)
(11040=10000)
(11044=10000)
(11050=10000)
(11052=10000)
(11053=10000)
(11054=10000)
(11055=10000)
(11056=10000)
(11057=10000)
(12002=10000)
(12005=10000)
(12007=10000)
(12009=10000)
(12014=10000)
(12021=10000)
(12025=10000)
(12026=10000)
(12029=10000)
(12035=10000)
(12040=10000)
(12041=10000)
(13001=10000)
(13002=10000)
(13003=10000)
(13004=10000)
(13006=10000)
(13008=10000)
(13010=10000)
(13011=10000)
(13012=10000)
(13013=10000)
(13014=10000)
(13016=10000)
(13017=10000)
(13019=10000)
(13021=10000)
(13023=10000)
(13025=10000)
(13029=10000)
(13031=10000)
(13035=10000)
(13036=10000)
(13037=10000)
(13040=10000)
(13044=10000)
(13046=10000)
(13049=10000)
(13053=10000)
(21001=4000)
(21002=4000)
(21003=4000)
(21004=4000)
(21005=4000)
(21006=4000)
(21007=4000)
(21008=4000)
(21009=4000)
(21010=4000)
(21011=4000)
(21012=4000)
(21013=4000)
(21014=4000)
(21015=4000)
(21016=4000)
(21017=4000)
(21018=4000)
(21019=4000)
(23002=20001)
(23003=20001)
(23009=20001)
(23016=20001)
(23023=20001)
(23024=20001)
(23025=20001)
(23027=20001)
(23032=20001)
(23033=20001)
(23038=20001)
(23039=20001)
(23044=20001)
(23045=20001)
(23047=20001)
(23050=20001)
(23052=20001)
(23060=20001)
(23062=20001)
(23064=20001)
(23077=20001)
(23081=20001)
(23086=20001)
(23088=20001)
(23094=20001)
(23096=20001)
(23097=20001)
(23098=20001)
(23099=20001)
(23100=20001)
(23101=20001)
(23102=20001)
(23103=20001)
(23104=20001)
(23105=20001)
(24001=20001)
(24007=20001)
(24008=20001)
(24009=20001)
(24011=20001)
(24014=20001)
(24016=20001)
(24020=20001)
(24028=20001)
(24033=20001)
(24038=20001)
(24041=20001)
(24043=20001)
(24045=20001)
(24048=20001)
(24054=20001)
(24055=20001)
(24059=20001)
(24062=20001)
(24066=20001)
(24086=20001)
(24094=20001)
(24104=20001)
(24107=20001)
(24109=20001)
(24130=20001)
(24133=20001)
(24134=20001)
(24135=20001)
(24137=20001)
(31003=30000)
(31004=30000)
(31005=30000)
(31006=30000)
(31012=30000)
(31022=30000)
(31033=30000)
(31040=30000)
(31042=30000)
(31043=30000)
(32003=30000)
(32006=30000)
(32010=30000)
(32011=30000)
(32030=30000)
(33011=30000)
(33016=30000)
(33021=30000)
(33029=30000)
(33037=30000)
(33039=30000)
(33040=30000)
(33041=30000)
(34002=30000)
(34003=30000)
(34009=30000)
(34013=30000)
(34022=30000)
(34023=30000)
(34025=30000)
(34027=30000)
(34040=30000)
(34041=30000)
(34042=30000)
(34043=30000)
(35002=30000)
(35005=30000)
(35006=30000)
(35011=30000)
(35013=30000)
(35014=30000)
(35029=30000)
(36006=30000)
(36007=30000)
(36008=30000)
(36010=30000)
(36011=30000)
(36012=30000)
(36015=30000)
(36019=30000)
(37002=30000)
(37007=30000)
(37010=30000)
(37011=30000)
(37012=30000)
(37015=30000)
(37017=30000)
(37018=30000)
(37020=30000)
(38002=30000)
(38008=30000)
(38014=30000)
(38016=30000)
(38025=30000)
(41002=40000)
(41011=40000)
(41018=40000)
(41024=40000)
(41027=40000)
(41034=40000)
(41048=40000)
(41063=40000)
(41081=40000)
(41082=40000)
(42003=40000)
(42004=40000)
(42006=40000)
(42008=40000)
(42010=40000)
(42011=40000)
(42023=40000)
(42025=40000)
(42026=40000)
(42028=40000)
(43002=40000)
(43005=40000)
(43007=40000)
(43010=40000)
(43014=40000)
(43018=40000)
(44012=40000)
(44013=40000)
(44019=40000)
(44020=40000)
(44021=40000)
(44034=40000)
(44040=40000)
(44043=40000)
(44045=40000)
(44048=40000)
(44052=40000)
(44064=40000)
(44073=40000)
(44081=40000)
(44083=40000)
(44084=40000)
(44085=40000)
(45035=40000)
(45041=40000)
(45059=40000)
(45060=40000)
(45061=40000)
(45062=40000)
(45063=40000)
(45064=40000)
(45065=40000)
(45068=40000)
(46003=40000)
(46013=40000)
(46014=40000)
(46020=40000)
(46021=40000)
(46024=40000)
(46025=40000)
(71002=70000)
(71004=70000)
(71011=70000)
(71016=70000)
(71017=70000)
(71020=70000)
(71022=70000)
(71024=70000)
(71034=70000)
(71037=70000)
(71045=70000)
(71053=70000)
(71057=70000)
(71066=70000)
(71067=70000)
(71069=70000)
(71070=70000)
(72003=70000)
(72004=70000)
(72018=70000)
(72020=70000)
(72021=70000)
(72030=70000)
(72037=70000)
(72038=70000)
(72039=70000)
(72041=70000)
(72042=70000)
(72043=70000)
(73001=70000)
(73006=70000)
(73009=70000)
(73022=70000)
(73028=70000)
(73032=70000)
(73040=70000)
(73042=70000)
(73066=70000)
(73083=70000)
(73098=70000)
(73107=70000)
(73109=70000)
(99991=99991)
(99992=4000)
(99999=99999) into provinciecode.

FILTER OFF.
USE ALL.
SELECT IF (provinciecode>0).
EXECUTE.

* einde verwijder foute niscodes.

compute afgeleide_variabelen=$sysmis.


***** omdat de datum verknald was in 2018 ****.
*COMPUTE aanvraag_corr=DATESUM(DATE.DMY(1,1,1970),(AANVRAAG_DATUM-25569),"days").
*COMPUTE indien_corr=DATESUM(DATE.DMY(1,1,1970),(INGEDIEND_DATUM-25569),"days").
* als datumveld instellen is enkel nodig voor het visuele.
*compute aanvraag_jaar=XDATE.YEAR(aanvraag_corr).
*compute indien_jaar=XDATE.YEAR(indien_corr).



**** normaal gezien ****.
compute aanvraag_jaar=number(char.substr(AANVRAAG_DATUM,1,4),f4.0).
compute indien_jaar=number(char.substr(INGEDIEND_DATUM,1,4),f4.0).
EXECUTE.



*match files
/file=*
/keep=AANGIFTE_ID
aanvraag_jaar
indien_jaar
NIS_CODE
AARD_WERKEN
BESTEMMING
BOUWVORM
E_PEIL
E_EIS
PRIMAIR_ENERGIE_VERBRUIK_M2
INDICATOR_VOLDOEN_VENTILATIE
INDICATOR_VOLDOEN_OVERVERH
INDICATOR_VOLDOEN_U_R
NEB_VOOR_VERWARMING
NEB_VOOR_VERW_EENH_OPP
BRUTO_VLOER_OPPERVLAKTE_06
TYPE_VERWARMING_first
TYPE_VERWARMING_last
INDICATOR_WARMTEPOMP_max
WARMTEPOMP_SPF_max
aantal_records_07
TOTAAL_HEB_EENH_OPP
TOTAAL_EIS_HEB_EENH_OPP
prod_biomassa
prod_zonnepaneel
prod_participatie
prod_stadsnet
prod_warmtepomp
prod_zonnecollector
thermische_zonne_energie
pv_panelen
OPGEWEKTE_STROOM_PV_PANELEN
VENTILATIE_SYSTEEM_d10
AANWEZIGHEID_WTW
types_functie_last.



recode aard_werken ("Nieuwbouw"=1) (else=0) into nieuwbouw.
value labels nieuwbouw
0 "renovatie/wijziging"
1 "nieuwbouw".

recode bestemming ('ANDERE'=8)
('ANDERE MET KANTOOR'=8)
('GD NIET RESIDENTIEEL'=8)
('NIET RESIDENTIEEL EPN'=8)
('INDUSTRIE'=5)
('INDUSTRIE MET KANTOOR'=3)
('KANTOOR'=4)
('LANDBOUW'=7)
('NULL'=9)
('GD RESIDENTIEEL'=1)
('WONEN'=1)
('WONEN MET KANTOOR'=2)
('SCHOOL'=6)
into bestemming_cat.
value labels bestemming_cat
1 'residentieel'
2 'residentieel met kantoor'
3 'industrie met kantoor'
4 'kantoor'
5 'industrie'
6 'school'
7 'landbouw'
8 'andere niet residentieel'
9 'onbekend (ongewijzigd)'.

* enkel voor residentieel en kantoor+residentieel classificeren we de bouwvorm.
do if bestemming_cat=1 | bestemming_cat=2.
recode bouwvorm ('Gesloten bebouwing'=1)
('Halfopen bebouwing'=2)
('Vrijstaand'=3)
 into type_woning.
end if.
value labels type_woning
1 'Gesloten bebouwing'
2 'Halfopen bebouwing'
3 'Vrijstaand'.


compute type_bebouwing=0.
variable labels type_bebouwing 'soort woning'.
value labels type_bebouwing
0 'andere'
1 'appartement, studio, loft, collectieve woning'
2 'gesloten huis'
3 'halfopen huis'
4 'vrijstaand huis'.
* zoek doorheen de tekst naar appartementen en aanverwanten.
if CHAR.INDEX(types_functie_last,"APPARTEMENT")> 0 | CHAR.INDEX(types_functie_last,"STUDIO")> 0 | 
CHAR.INDEX(types_functie_last,"COLLECTIVE_HOUSING")> 0 | CHAR.INDEX(types_functie_last,"LOFT")> 0 type_bebouwing=1.
* we nemen type woning over, maar schuiven het een omhoog.
if any(type_woning,1,2,3)=1 type_bebouwing=type_woning+1.



* even controleren.
frequencies type_bebouwing.

recode e_peil (lowest thru -0.01 = -1) (0 thru highest =1) (missing=9) into e_peil_test.

variable labels PRIMAIR_ENERGIE_VERBRUIK_M2 'totale energie voor alle voorzieningen in kwh/m2*jaar'.
recode PRIMAIR_ENERGIE_VERBRUIK_M2 (0 thru 15=1) (15 thru 70=2) (70 thru highest =3) (missing=9) into primair_energie_cat.

* geef voorang aan wat toevallig eerst was.
if type_verwarming_first="centraal" type_verwarming_simp =1.
if type_verwarming_first="gemeenschappelijk" type_verwarming_simp =2.
if type_verwarming_first="plaatselijk" type_verwarming_simp =3.
* geef voorang aan centraal indien toevallig laatst.
if type_verwarming_last="centraal" type_verwarming_simp =1.
* als geen van deze drie in first, neem dan die van last.
if type_verwarming_last="gemeenschappelijk" & missing(type_verwarming_simp) type_verwarming_simp =2.
if type_verwarming_last="plaatselijk" & missing(type_verwarming_simp) type_verwarming_simp =3.
if type_verwarming_first="geen" &  type_verwarming_last="geen" type_verwarming_simp = 4.
if missing(type_verwarming_simp) type_verwarming_simp=99.
value labels type_verwarming_simp
1 'centraal'
2 'gemeenschappelijk'
3 'plaatselijk'
4 'geen'
99 'leeg'.
freq type_verwarming_simp.

recode TOTAAL_HEB_EENH_OPP
TOTAAL_EIS_HEB_EENH_OPP (missing=99) (0=0) (else=1) into
produceert_hernieuwbaar
moet_hernieuwbaar_produceren.

compute m2=NEB_VOOR_VERWARMING/
NEB_VOOR_VERW_EENH_OPP.

* INDICATOREN SWING.
* nieuwbouwwoningen afgewerkt in jaar X, dus norm afhankelijk van hoe lang geleden vergund.
rename variables indien_jaar=period.
compute geoitem= nis_code.
alter type geoitem (f8.0).

* enkel residentiele nieuwbouw for now.
DATASET ACTIVATE basis.
USE ALL.
COMPUTE filter_$=(nieuwbouw = 1 & bestemming_cat = 1).
VARIABLE LABELS filter_$ 'nieuwbouw = 1 & bestemming_cat = 1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

* er zijn enkele extreem grote panden. Deze wissen we als ze ook een onrealistisch laag energieverbruik hebben.
do if BRUTO_VLOER_OPPERVLAKTE_06>1000 & (NEB_VOOR_VERW_EENH_OPP < 10 | PRIMAIR_ENERGIE_VERBRUIK_M2 < 5).
compute BRUTO_VLOER_OPPERVLAKTE_06=$sysmis.
compute NEB_VOOR_VERW_EENH_OPP=$sysmis.
compute PRIMAIR_ENERGIE_VERBRUIK_M2=$sysmis.
end if.

compute v2207_epb_dossier=1.
compute v2207_epb_peil_som=e_peil.
compute v2207_epb_doel_som=e_eis.

*wellicht is overschot als % relevanter?.
compute overschot=e_eis-e_peil.
if overschot<1 v2207_epb_norm=1.
if overschot>0 & overschot<10 v2207_epb_norm10=1.
if overschot>=10 & overschot<20 v2207_epb_norm1019=1.
if overschot>=20 & overschot<40 v2207_epb_norm2039=1.
if overschot>=40 v2207_epb_norm40=1.




if type_bebouwing=0 v2207_epb_n_ander=1.
if type_bebouwing=1 v2207_epb_n_app=1.
if type_bebouwing=2 v2207_epb_n_gesl=1.
if type_bebouwing=3 v2207_epb_n_hopen=1.
if type_bebouwing=4 v2207_epb_n_open=1.

if type_bebouwing=0 v2207_epb_sompeil_ander=E_PEIL.
if type_bebouwing=1 v2207_epb_sompeil_app=E_PEIL.
if type_bebouwing=2 v2207_epb_sompeil_gesl=E_PEIL.
if type_bebouwing=3 v2207_epb_sompeil_hopen=E_PEIL.
if type_bebouwing=4 v2207_epb_sompeil_open=E_PEIL.






* TODO: mediaan voor andere gebiedsniveaus.


DATASET DECLARE basicgem.
AGGREGATE
  /OUTFILE='basicgem'
  /BREAK=period geoitem
  /v2207_nbw_dossier=SUM(v2207_epb_dossier) 
  /v2207_nbw_peil_som=SUM(v2207_epb_peil_som) 
  /v2207_nbw_doel_som=SUM(v2207_epb_doel_som) 
  /v2207_nbw_norm=SUM(v2207_epb_norm) 
  /v2207_nbw_norm10=SUM(v2207_epb_norm10) 
  /v2207_nbw_norm1019=SUM(v2207_epb_norm1019) 
  /v2207_nbw_norm2039=SUM(v2207_epb_norm2039) 
  /v2207_nbw_norm40=SUM(v2207_epb_norm40)
  /v2207_nbw_n_ander=sum(v2207_epb_n_ander)
  /v2207_nbw_n_app=sum(v2207_epb_n_app)
  /v2207_nbw_n_gesl=sum(v2207_epb_n_gesl)
  /v2207_nbw_n_hopen=sum(v2207_epb_n_hopen)
  /v2207_nbw_n_open=sum(v2207_epb_n_open)
  /v2207_nbw_sompeil_ander=sum(v2207_epb_sompeil_ander)
  /v2207_nbw_sompeil_app=sum(v2207_epb_sompeil_app)
  /v2207_nbw_sompeil_gesl=sum(v2207_epb_sompeil_gesl)
  /v2207_nbw_sompeil_hopen=sum(v2207_epb_sompeil_hopen)
  /v2207_nbw_sompeil_open=sum(v2207_epb_sompeil_open)
  /v2207_nbw_peil_mediaan=MEDIAN(E_PEIL).
DATASET ACTIVATE basicgem.
string geolevel (a14).
compute geolevel='gemeente'.

* voor 2020: enkel dat jaar meenemen, voor oude jaren blijft statsecniveau behouden.
FILTER OFF.
USE ALL.
SELECT IF (period = 2020).
EXECUTE.

recode v2207_nbw_dossier
v2207_nbw_peil_som
v2207_nbw_doel_som
v2207_nbw_norm
v2207_nbw_norm10
v2207_nbw_norm1019
v2207_nbw_norm2039
v2207_nbw_norm40 
v2207_nbw_n_ander
v2207_nbw_n_app
v2207_nbw_n_gesl
v2207_nbw_n_hopen
v2207_nbw_n_open
v2207_nbw_sompeil_ander
v2207_nbw_sompeil_app
v2207_nbw_sompeil_gesl
v2207_nbw_sompeil_hopen
v2207_nbw_sompeil_open (missing=0).
alter type v2207_nbw_dossier
v2207_nbw_peil_som
v2207_nbw_doel_som
v2207_nbw_norm
v2207_nbw_norm10
v2207_nbw_norm1019
v2207_nbw_norm2039
v2207_nbw_norm40 v2207_nbw_n_ander
v2207_nbw_n_app
v2207_nbw_n_gesl
v2207_nbw_n_hopen
v2207_nbw_n_open
v2207_nbw_sompeil_ander
v2207_nbw_sompeil_app
v2207_nbw_sompeil_gesl
v2207_nbw_sompeil_hopen
v2207_nbw_sompeil_open
v2207_nbw_peil_mediaan (f8.0).


SAVE TRANSLATE OUTFILE=datamap +  'upload\basicgem.xlsx'
  /TYPE=XLS
  /VERSION=12
  /MAP
  /FIELDNAMES VALUE=NAMES
  /CELLS=VALUES
/replace.


SAVE TRANSLATE OUTFILE=datamap +  'upload\basicgem.csv'
  /TYPE=CSV
  /ENCODING='Locale'
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=VALUES
/replace.


dataset activate basis.

if  primair_energie_cat = 1 v2207_nbw_primair_0_15 = 1.
if  primair_energie_cat = 2 v2207_nbw_primair_15_70 = 1.
if  primair_energie_cat = 3 v2207_nbw_primair_70p = 1.
if  primair_energie_cat = 9 v2207_nbw_primair_onb = 1.

* TODO: klasse-indeling E_peil kleiner-50-60-70-80-groter.
if e_peil>-0.01 & e_peil<50 v2207_nbw_ep_0_50=1.
if e_peil>50 & e_peil<=60 v2207_nbw_ep_50_60=1.
if e_peil>60 & e_peil<=70 v2207_nbw_ep_60_70=1.
if e_peil>70 & e_peil<=80 v2207_nbw_ep_70_80=1.
if e_peil>80  v2207_nbw_ep_80p=1.
if e_peil<0 | missing(e_peil) v2207_nbw_ep_onb=1.

* voldoen.
compute v2207_nbw_vold_ventilatie=INDICATOR_VOLDOEN_VENTILATIE.
compute v2207_nbw_vold_verhit=INDICATOR_VOLDOEN_OVERVERH.
compute v2207_nbw_vold_rwaarde=INDICATOR_VOLDOEN_U_R.

* energieverbruik per type.
compute v2207_nbw_primair_energieverbruik=PRIMAIR_ENERGIE_VERBRUIK_M2*BRUTO_VLOER_OPPERVLAKTE_06.
if type_bebouwing=0 v2207_nbw_prim_ander=v2207_nbw_primair_energieverbruik.
if type_bebouwing=1 v2207_nbw_prim_app=v2207_nbw_primair_energieverbruik.
if type_bebouwing=2 v2207_nbw_prim_gesl=v2207_nbw_primair_energieverbruik.
if type_bebouwing=3 v2207_nbw_prim_hopen=v2207_nbw_primair_energieverbruik.
if type_bebouwing=4 v2207_nbw_prim_open=v2207_nbw_primair_energieverbruik.

*oppervlakte per type.
compute v2207_nbw_oppervlakte=BRUTO_VLOER_OPPERVLAKTE_06.
if type_bebouwing=0 v2207_nbw_opp_ander=v2207_nbw_oppervlakte.
if type_bebouwing=1 v2207_nbw_opp_app=v2207_nbw_oppervlakte.
if type_bebouwing=2 v2207_nbw_opp_gesl=v2207_nbw_oppervlakte.
if type_bebouwing=3 v2207_nbw_opp_hopen=v2207_nbw_oppervlakte.
if type_bebouwing=4 v2207_nbw_opp_open=v2207_nbw_oppervlakte.

*woningen met energie & opp beschikbaar.
if type_bebouwing=0 & v2207_nbw_primair_energieverbruik>-1 v2207_nbw_oppe_ander=1.
if type_bebouwing=1 & v2207_nbw_primair_energieverbruik>-1 v2207_nbw_oppe_app=1.
if type_bebouwing=2 & v2207_nbw_primair_energieverbruik>-1 v2207_nbw_oppe_gesl=1.
if type_bebouwing=3 & v2207_nbw_primair_energieverbruik>-1 v2207_nbw_oppe_hopen=1.
if type_bebouwing=4 & v2207_nbw_primair_energieverbruik>-1 v2207_nbw_oppe_open=1.

* app met gemeenschappelijke verwarming.
if (type_verwarming_first="gemeenschappelijk" | type_verwarming_last="gemeenschappelijk") & type_bebouwing=1 v2207_nbw_app_gemeensch=1.

* warmtepomp.
if type_bebouwing=1 & INDICATOR_WARMTEPOMP_max=1 v2207_nbw_wp_app=1.
if type_bebouwing=2 & INDICATOR_WARMTEPOMP_max=1  v2207_nbw_wp_gesl=1.
if type_bebouwing=3 & INDICATOR_WARMTEPOMP_max=1  v2207_nbw_wp_hopen=1.
if type_bebouwing=4 & INDICATOR_WARMTEPOMP_max=1  v2207_nbw_wp_open=1.

* heeft zonnecollector.
compute v2207_nbw_zoncol=thermische_zonne_energie.
if type_bebouwing=0 v2207_nbw_zoncol_ander=thermische_zonne_energie.
if type_bebouwing=1 v2207_nbw_zoncol_app=thermische_zonne_energie.
if type_bebouwing=2 v2207_nbw_zoncol_gesl=thermische_zonne_energie.
if type_bebouwing=3 v2207_nbw_zoncol_hopen=thermische_zonne_energie.
if type_bebouwing=4 v2207_nbw_zoncol_open=thermische_zonne_energie.

* heeft zonnepanelen.
compute v2207_nbw_pv=pv_panelen.
if type_bebouwing=0 v2207_nbw_pv_ander=pv_panelen.
if type_bebouwing=1 v2207_nbw_pv_app=pv_panelen.
if type_bebouwing=2 v2207_nbw_pv_gesl=pv_panelen.
if type_bebouwing=3 v2207_nbw_pv_hopen=pv_panelen.
if type_bebouwing=4 v2207_nbw_pv_open=pv_panelen.

* ventilatiesysteem.
if VENTILATIE_SYSTEEM_d10='natuurlijke toevoer, natuurlijke afvoer (A)' v2207_nbw_vent_a=1.
if VENTILATIE_SYSTEEM_d10='mechanische toevoer, vrije afvoer (B)' v2207_nbw_vent_b=1.
if VENTILATIE_SYSTEEM_d10='vrije toevoer, mechanische afvoer (C)' v2207_nbw_vent_c=1.
if VENTILATIE_SYSTEEM_d10='mechanische toevoer, mechanische afvoer (D)' v2207_nbw_vent_d=1.
if VENTILATIE_SYSTEEM_d10='onbe' v2207_nbw_vent_onb=1.
if VENTILATIE_SYSTEEM_d10='geen' v2207_nbw_vent_onb=1.



DATASET DECLARE basicgem.
AGGREGATE
  /OUTFILE='basicgem'
  /BREAK=period geoitem
/v2207_nbw_primair_0_15=sum(v2207_nbw_primair_0_15)
/v2207_nbw_primair_15_70=sum(v2207_nbw_primair_15_70)
/v2207_nbw_primair_70p=sum(v2207_nbw_primair_70p)
/v2207_nbw_primair_onb=sum(v2207_nbw_primair_onb)
/v2207_nbw_ep_0_50=sum(v2207_nbw_ep_0_50)
/v2207_nbw_ep_50_60=sum(v2207_nbw_ep_50_60)
/v2207_nbw_ep_60_70=sum(v2207_nbw_ep_60_70)
/v2207_nbw_ep_70_80=sum(v2207_nbw_ep_70_80)
/v2207_nbw_ep_80p=sum(v2207_nbw_ep_80p)
/v2207_nbw_ep_onb=sum(v2207_nbw_ep_onb)
/v2207_nbw_vold_ventilatie=sum(v2207_nbw_vold_ventilatie)
/v2207_nbw_vold_verhit=sum(v2207_nbw_vold_verhit)
/v2207_nbw_vold_rwaarde=sum(v2207_nbw_vold_rwaarde)
/v2207_nbw_primair_energieverbruik=sum(v2207_nbw_primair_energieverbruik)
/v2207_nbw_prim_ander=sum(v2207_nbw_prim_ander)
/v2207_nbw_prim_app=sum(v2207_nbw_prim_app)
/v2207_nbw_prim_gesl=sum(v2207_nbw_prim_gesl)
/v2207_nbw_prim_hopen=sum(v2207_nbw_prim_hopen)
/v2207_nbw_prim_open=sum(v2207_nbw_prim_open)
/v2207_nbw_oppervlakte=sum(v2207_nbw_oppervlakte)
/v2207_nbw_oppe_ander=sum(v2207_nbw_oppe_ander)
/v2207_nbw_oppe_app=sum(v2207_nbw_oppe_app)
/v2207_nbw_oppe_gesl=sum(v2207_nbw_oppe_gesl)
/v2207_nbw_oppe_hopen=sum(v2207_nbw_oppe_hopen)
/v2207_nbw_oppe_open=sum(v2207_nbw_oppe_open)
/v2207_nbw_app_gemeensch=sum(v2207_nbw_app_gemeensch)
/v2207_nbw_wp_app=sum(v2207_nbw_wp_app)
/v2207_nbw_wp_gesl=sum(v2207_nbw_wp_gesl)
/v2207_nbw_wp_hopen=sum(v2207_nbw_wp_hopen)
/v2207_nbw_wp_open=sum(v2207_nbw_wp_open)
/v2207_nbw_zoncol=sum(v2207_nbw_zoncol)
/v2207_nbw_zoncol_ander=sum(v2207_nbw_zoncol_ander)
/v2207_nbw_zoncol_app=sum(v2207_nbw_zoncol_app)
/v2207_nbw_zoncol_gesl=sum(v2207_nbw_zoncol_gesl)
/v2207_nbw_zoncol_hopen=sum(v2207_nbw_zoncol_hopen)
/v2207_nbw_zoncol_open=sum(v2207_nbw_zoncol_open)
/v2207_nbw_pv=sum(v2207_nbw_pv)
/v2207_nbw_pv_ander=sum(v2207_nbw_pv_ander)
/v2207_nbw_pv_app=sum(v2207_nbw_pv_app)
/v2207_nbw_pv_gesl=sum(v2207_nbw_pv_gesl)
/v2207_nbw_pv_hopen=sum(v2207_nbw_pv_hopen)
/v2207_nbw_pv_open=sum(v2207_nbw_pv_open)
/v2207_nbw_vent_a=sum(v2207_nbw_vent_a)
/v2207_nbw_vent_b=sum(v2207_nbw_vent_b)
/v2207_nbw_vent_c=sum(v2207_nbw_vent_c)
/v2207_nbw_vent_d=sum(v2207_nbw_vent_d)
/v2207_nbw_vent_onb=sum(v2207_nbw_vent_onb)
/v2207_nbw_opp_ander=sum(v2207_nbw_opp_ander)
/v2207_nbw_opp_app=sum(v2207_nbw_opp_app)
/v2207_nbw_opp_gesl=sum(v2207_nbw_opp_gesl)
/v2207_nbw_opp_hopen=sum(v2207_nbw_opp_hopen)
/v2207_nbw_opp_open=sum(v2207_nbw_opp_open).
DATASET ACTIVATE basicgem.
string geolevel (a14).
compute geolevel='gemeente'.
* enkel vanaf 2010 meenemen.
FILTER OFF.
USE ALL.
SELECT IF (period = 2019).
EXECUTE.


recode v2207_nbw_primair_0_15
v2207_nbw_primair_15_70
v2207_nbw_primair_70p
v2207_nbw_primair_onb
v2207_nbw_ep_0_50
v2207_nbw_ep_50_60
v2207_nbw_ep_60_70
v2207_nbw_ep_70_80
v2207_nbw_ep_80p
v2207_nbw_ep_onb
v2207_nbw_vold_ventilatie
v2207_nbw_vold_verhit
v2207_nbw_vold_rwaarde
v2207_nbw_primair_energieverbruik
v2207_nbw_prim_ander
v2207_nbw_prim_app
v2207_nbw_prim_gesl
v2207_nbw_prim_hopen
v2207_nbw_prim_open
v2207_nbw_oppervlakte
v2207_nbw_oppe_ander
v2207_nbw_oppe_app
v2207_nbw_oppe_gesl
v2207_nbw_oppe_hopen
v2207_nbw_oppe_open
v2207_nbw_app_gemeensch
v2207_nbw_wp_app
v2207_nbw_wp_gesl
v2207_nbw_wp_hopen
v2207_nbw_wp_open
v2207_nbw_zoncol
v2207_nbw_zoncol_ander
v2207_nbw_zoncol_app
v2207_nbw_zoncol_gesl
v2207_nbw_zoncol_hopen
v2207_nbw_zoncol_open
v2207_nbw_pv
v2207_nbw_pv_ander
v2207_nbw_pv_app
v2207_nbw_pv_gesl
v2207_nbw_pv_hopen
v2207_nbw_pv_open
v2207_nbw_vent_a
v2207_nbw_vent_b
v2207_nbw_vent_c
v2207_nbw_vent_d
v2207_nbw_vent_onb v2207_nbw_opp_ander
v2207_nbw_opp_app
v2207_nbw_opp_gesl
v2207_nbw_opp_hopen
v2207_nbw_opp_open
 (missing=0).
alter type v2207_nbw_primair_0_15
v2207_nbw_primair_15_70
v2207_nbw_primair_70p
v2207_nbw_primair_onb
v2207_nbw_ep_0_50
v2207_nbw_ep_50_60
v2207_nbw_ep_60_70
v2207_nbw_ep_70_80
v2207_nbw_ep_80p
v2207_nbw_ep_onb
v2207_nbw_vold_ventilatie
v2207_nbw_vold_verhit
v2207_nbw_vold_rwaarde
v2207_nbw_primair_energieverbruik
v2207_nbw_prim_ander
v2207_nbw_prim_app
v2207_nbw_prim_gesl
v2207_nbw_prim_hopen
v2207_nbw_prim_open
v2207_nbw_oppervlakte
v2207_nbw_oppe_ander
v2207_nbw_oppe_app
v2207_nbw_oppe_gesl
v2207_nbw_oppe_hopen
v2207_nbw_oppe_open
v2207_nbw_app_gemeensch
v2207_nbw_wp_app
v2207_nbw_wp_gesl
v2207_nbw_wp_hopen
v2207_nbw_wp_open
v2207_nbw_zoncol
v2207_nbw_zoncol_ander
v2207_nbw_zoncol_app
v2207_nbw_zoncol_gesl
v2207_nbw_zoncol_hopen
v2207_nbw_zoncol_open
v2207_nbw_pv
v2207_nbw_pv_ander
v2207_nbw_pv_app
v2207_nbw_pv_gesl
v2207_nbw_pv_hopen
v2207_nbw_pv_open
v2207_nbw_vent_a
v2207_nbw_vent_b
v2207_nbw_vent_c
v2207_nbw_vent_d
v2207_nbw_vent_onb v2207_nbw_opp_ander
v2207_nbw_opp_app
v2207_nbw_opp_gesl
v2207_nbw_opp_hopen
v2207_nbw_opp_open (f8.0).


SAVE TRANSLATE OUTFILE=datamap +  'upload\detailgem.xlsx'
  /TYPE=XLS
  /VERSION=12
  /MAP
  /FIELDNAMES VALUE=NAMES
  /CELLS=VALUES
/replace.


SAVE TRANSLATE OUTFILE=datamap +  'upload\detailgem.csv'
  /TYPE=CSV
  /ENCODING='Locale'
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=VALUES
/replace.

