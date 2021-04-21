* Encoding: windows-1252.

* todo:
- check mediaan statsec; check ontbreken totaal warmtepomp
- lange termijn: statsec onbekend voor de nieuwe fusies

GET
  FILE=datamap +  'verwerkt\verzamelbestand.sav'.
DATASET NAME basis WINDOW=FRONT.

* corrigeer enkele foutjes in de dump.
recode nis_code (24302	=24104) (22002=23099).




* verwijder grotendeels lege records.

FILTER OFF.
USE ALL.
SELECT IF (NIS_CODE > 0).
EXECUTE.

* TODO OP BASIS VAN GITHUB TABEL. zie DEFINE gebiedsniveaus () 'C:\github\gebiedsniveaus\' !ENDDEFINE.
* verwijder foute niscodes.
* dit is op basis van de kerntabel:
https://share.vlaamsbrabant.be/share/page/site/socialeplanning/document-details?nodeRef=workspace://SpacesStore/afc23173-84e1-4f47-a0f5-61e17e350a09
* hier is het nog op basis van gemeente2018 gebeurd. In de nieuwe datadump uitkijken: wordt systematisch de nieuwe niscode gebruikt? Of een combinatie van oud en nieuw?.
GET 
  FILE='C:\Users\plu3532\Documents\gebiedsindelingen\verwerking\gislagen\uitgebreide_tabel.sav'. 
DATASET NAME gem WINDOW=FRONT. 
DATASET DECLARE gemeenten. 
AGGREGATE 
  /OUTFILE='gemeenten' 
  /BREAK=gemeente gemeente_naam provincie 
  /N_BREAK=N.
dataset activate gemeenten.
alter type gemeente (f8.0).
rename variables gemeente=nis_code.
sort cases nis_code (a).
delete variables n_break.

dataset activate basis.
sort cases nis_code (a).

MATCH FILES /FILE=*
  /TABLE='gemeenten'
  /BY nis_code.
EXECUTE.

* dit verwijdert zeer zeldzame volledige foute records.
FILTER OFF.
USE ALL.
SELECT IF (gemeente_naam ~= "").
EXECUTE.
dataset close gem.
dataset close gemeenten.

* dit is de tabel die ontstaat nadat we de adressen+statsec hebben bezorgd aan VEA.
* toevoegen statsec.
* TODO: aanpassen naar nieuwe tabel.
GET DATA  /TYPE=TXT
  /FILE="C:\Users\plu3532\Documents\VEA\EPB\koppeling_statsec\output\statsec_20190704_2018.csv"
  /ENCODING='UTF8'
  /DELCASE=LINE
  /DELIMITERS="|"
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
  AANGIFTE_ID A20
  statsec A9
  /MAP.
CACHE.
EXECUTE.
DATASET NAME statsec WINDOW=FRONT.

* enkele dubbels moeten verwijderd worden; check of ze steeds aan dezelfde statsec worden toegekend.
SORT CASES BY AANGIFTE_ID(A).
MATCH FILES
  /FILE=*
  /BY AANGIFTE_ID
  /LAST=PrimaryLast.
VARIABLE LABELS  PrimaryLast 'Indicator of each last matching case as Primary'.
VALUE LABELS  PrimaryLast 0 'Duplicate Case' 1 'Primary Case'.
VARIABLE LEVEL  PrimaryLast (ORDINAL).
EXECUTE.
FILTER OFF.
USE ALL.
SELECT IF (PrimaryLast=1).
EXECUTE.
delete variables PrimaryLast.


sort cases AANGIFTE_ID (a).

dataset activate basis.
sort cases AANGIFTE_ID (a).
MATCH FILES /FILE=*
  /TABLE='statsec'
  /BY AANGIFTE_ID.
EXECUTE.

dataset close statsec.

* nakijken statsec en niscode.

* dit hele stuk werkt maar zolang nis_code meestal de oude gemeente omvat. Eigenlijk hebben we in PinC een gebied onbekend nodig op niveau van de nieuwe gemeenten.
if statsec="" statsec=concat(string(nis_code,f5.0),"ZZZZ").
if statsec="" statsec="99991ZZZZ".
compute statsec_nis=number(char.substr(statsec,1,5),f5.0).
alter type statsec_nis (f5.0).
recode nis_code statsec_nis (12030=12041)
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
(72029=72043) (else=copy) into niscode19 statsecnis19.

* er zijn slechts enkele dossiers toegekend aan een statsec buiten de gemeente.
* net als de gevallen die niet gevonden werden, mogen deze in het onbekend gebied van de gemeente terecht komen.
if niscode19 ~= statsecnis19 statsec=concat(string(nis_code,f5.0),"ZZZZ").
EXECUTE.

recode statsec
('12041ZZZZ'='12030ZZZZ')
('44084ZZZZ'='44001ZZZZ')
('44083ZZZZ'='44011ZZZZ')
('44085ZZZZ'='44036ZZZZ')
('45068ZZZZ'='45017ZZZZ')
('72042ZZZZ'='71047ZZZZ')
('72043ZZZZ'='72025ZZZZ').




compute afgeleide_variabelen=$sysmis.


***** omdat de datum verknald is ****.
COMPUTE aanvraag_corr=DATESUM(DATE.DMY(1,1,1970),(AANVRAAG_DATUM-25569),"days").
COMPUTE indien_corr=DATESUM(DATE.DMY(1,1,1970),(INGEDIEND_DATUM-25569),"days").
EXECUTE.
* als datuimveld instellen is enkel nodig voor het visuele.
compute aanvraag_jaar=XDATE.YEAR(aanvraag_corr).
compute indien_jaar=XDATE.YEAR(indien_corr).


**** normaal gezien ****.
*compute aanvraag_jaar=number(char.substr(AANVRAAG_DATUM,1,4),f4.0).
*compute indien_jaar=number(char.substr(INGEDIEND_DATUM,1,4),f4.0).
EXECUTE.




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
rename variables statsec=geoitem.


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
string geolevel (a25).
compute geolevel='statsec'.

* enkel vanaf 2010 meenemen plus verwijder onvolledig jaar.
FILTER OFF.
USE ALL.
SELECT IF (period >2009 & period < 2019).
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


SAVE TRANSLATE OUTFILE=datamap +  'upload\basic_statsec.xlsx'
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

*  klasse-indeling E_peil kleiner-50-60-70-80-groter.
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
string geolevel (a25).
compute geolevel='statsec'.
* enkel vanaf 2010 meenemen.
FILTER OFF.
USE ALL.
SELECT IF (period >2009 & period < 2019).
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


SAVE TRANSLATE OUTFILE=datamap +  'upload\detail_statsec.xlsx'
  /TYPE=XLS
  /VERSION=12
  /MAP
  /FIELDNAMES VALUE=NAMES
  /CELLS=VALUES
/replace.



* uitbreiding voor niet aggregeerbare data.
* TODO VERWIJZEN NAAR GITHUB SOURCED FILE.
* voeg alle gebiedsniveaus toe.
GET
  FILE='C:\temp\gebiedsniveaus\kerntabellen\verwerkt_alle_gebiedsniveaus.sav'.
DATASET NAME gebiedsniveaus WINDOW=FRONT.
sort cases statsec (a).
dataset activate basis.
dataset close basicgem.
rename variables geoitem=statsec.
sort cases statsec (a).
delete variables provincie.

DATASET ACTIVATE basis.
MATCH FILES /FILE=*
  /TABLE='gebiedsniveaus'
  /BY statsec.
EXECUTE.
dataset close gebiedsniveaus.

* verzamel de data.
* start.
rename variables ggw7=geoitem.
alter type geoitem (a15).
DATASET DECLARE mediaan.
AGGREGATE
  /OUTFILE='mediaan'
  /BREAK=period geoitem
  /v2207_nbw_peil_mediaan=MEDIAN(E_PEIL).
DATASET ACTIVATE mediaan.
string geolevel (a25).
compute geolevel='ggw7'.
dataset activate basis.
delete variables geoitem.

* voeg toe.
rename variables deelgemeente=geoitem.
alter type geoitem (a15).
DATASET DECLARE mediaan1.
AGGREGATE
  /OUTFILE='mediaan1'
  /BREAK=period geoitem
  /v2207_nbw_peil_mediaan=MEDIAN(E_PEIL).
DATASET ACTIVATE mediaan1.
string geolevel (a25).
compute geolevel='deelgemeente'.
DATASET ACTIVATE mediaan.
ADD FILES /FILE=*
  /FILE='mediaan1'.
EXECUTE.
dataset activate basis.
delete variables geoitem.

rename variables gemeente2018=geoitem.
alter type geoitem (a15).
DATASET DECLARE mediaan1.
AGGREGATE
  /OUTFILE='mediaan1'
  /BREAK=period geoitem
  /v2207_nbw_peil_mediaan=MEDIAN(E_PEIL).
DATASET ACTIVATE mediaan1.
string geolevel (a25).
compute geolevel='gemeente2018'.
DATASET ACTIVATE mediaan.
ADD FILES /FILE=*
  /FILE='mediaan1'.
EXECUTE.
dataset activate basis.
delete variables geoitem.


rename variables gemeente=geoitem.
alter type geoitem (a15).
DATASET DECLARE mediaan1.
AGGREGATE
  /OUTFILE='mediaan1'
  /BREAK=period geoitem
  /v2207_nbw_peil_mediaan=MEDIAN(E_PEIL).
DATASET ACTIVATE mediaan1.
string geolevel (a25).
compute geolevel='gemeente'.
DATASET ACTIVATE mediaan.
ADD FILES /FILE=*
  /FILE='mediaan1'.
EXECUTE.
dataset activate basis.
delete variables geoitem.

rename variables provincie=geoitem.
alter type geoitem (a15).
DATASET DECLARE mediaan1.
AGGREGATE
  /OUTFILE='mediaan1'
  /BREAK=period geoitem
  /v2207_nbw_peil_mediaan=MEDIAN(E_PEIL).
DATASET ACTIVATE mediaan1.
string geolevel (a25).
compute geolevel='provincie'.
DATASET ACTIVATE mediaan.
ADD FILES /FILE=*
  /FILE='mediaan1'.
EXECUTE.
dataset activate basis.
delete variables geoitem.

rename variables arrondiss2018=geoitem.
alter type geoitem (a15).
DATASET DECLARE mediaan1.
AGGREGATE
  /OUTFILE='mediaan1'
  /BREAK=period geoitem
  /v2207_nbw_peil_mediaan=MEDIAN(E_PEIL).
DATASET ACTIVATE mediaan1.
string geolevel (a25).
compute geolevel='arrondiss2018'.
DATASET ACTIVATE mediaan.
ADD FILES /FILE=*
  /FILE='mediaan1'.
EXECUTE.
dataset activate basis.
delete variables geoitem.

rename variables arrondiss=geoitem.
alter type geoitem (a15).
DATASET DECLARE mediaan1.
AGGREGATE
  /OUTFILE='mediaan1'
  /BREAK=period geoitem
  /v2207_nbw_peil_mediaan=MEDIAN(E_PEIL).
DATASET ACTIVATE mediaan1.
string geolevel (a25).
compute geolevel='arrondiss'.
DATASET ACTIVATE mediaan.
ADD FILES /FILE=*
  /FILE='mediaan1'.
EXECUTE.
dataset activate basis.
delete variables geoitem.

rename variables fo_gem=geoitem.
alter type geoitem (a15).
DATASET DECLARE mediaan1.
AGGREGATE
  /OUTFILE='mediaan1'
  /BREAK=period geoitem
  /v2207_nbw_peil_mediaan=MEDIAN(E_PEIL).
DATASET ACTIVATE mediaan1.
string geolevel (a25).
compute geolevel='fo_gem'.
DATASET ACTIVATE mediaan.
ADD FILES /FILE=*
  /FILE='mediaan1'.
EXECUTE.
dataset activate basis.
delete variables geoitem.

rename variables politiezone=geoitem.
alter type geoitem (a15).
DATASET DECLARE mediaan1.
AGGREGATE
  /OUTFILE='mediaan1'
  /BREAK=period geoitem
  /v2207_nbw_peil_mediaan=MEDIAN(E_PEIL).
DATASET ACTIVATE mediaan1.
string geolevel (a25).
compute geolevel='politiezone'.
DATASET ACTIVATE mediaan.
ADD FILES /FILE=*
  /FILE='mediaan1'.
EXECUTE.
dataset activate basis.
delete variables geoitem.

rename variables gewest=geoitem.
alter type geoitem (a15).
DATASET DECLARE mediaan1.
AGGREGATE
  /OUTFILE='mediaan1'
  /BREAK=period geoitem
  /v2207_nbw_peil_mediaan=MEDIAN(E_PEIL).
DATASET ACTIVATE mediaan1.
string geolevel (a25).
compute geolevel='gewest'.
DATASET ACTIVATE mediaan.
ADD FILES /FILE=*
  /FILE='mediaan1'.
EXECUTE.
dataset activate basis.
delete variables geoitem.

rename variables elz=geoitem.
alter type geoitem (a15).
DATASET DECLARE mediaan1.
AGGREGATE
  /OUTFILE='mediaan1'
  /BREAK=period geoitem
  /v2207_nbw_peil_mediaan=MEDIAN(E_PEIL).
DATASET ACTIVATE mediaan1.
string geolevel (a25).
compute geolevel='elz'.
DATASET ACTIVATE mediaan.
ADD FILES /FILE=*
  /FILE='mediaan1'.
EXECUTE.
dataset activate basis.
delete variables geoitem.

rename variables uitrustingsniveau=geoitem.
alter type geoitem (a15).
DATASET DECLARE mediaan1.
AGGREGATE
  /OUTFILE='mediaan1'
  /BREAK=period geoitem
  /v2207_nbw_peil_mediaan=MEDIAN(E_PEIL).
DATASET ACTIVATE mediaan1.
string geolevel (a25).
compute geolevel='uitrustingsniveau'.
DATASET ACTIVATE mediaan.
ADD FILES /FILE=*
  /FILE='mediaan1'.
EXECUTE.
dataset activate basis.
delete variables geoitem.

rename variables logo=geoitem.
alter type geoitem (a15).
DATASET DECLARE mediaan1.
AGGREGATE
  /OUTFILE='mediaan1'
  /BREAK=period geoitem
  /v2207_nbw_peil_mediaan=MEDIAN(E_PEIL).
DATASET ACTIVATE mediaan1.
string geolevel (a25).
compute geolevel='logo'.
DATASET ACTIVATE mediaan.
ADD FILES /FILE=*
  /FILE='mediaan1'.
EXECUTE.
dataset activate basis.
delete variables geoitem.

rename variables gemeente_cluster=geoitem.
alter type geoitem (a15).
DATASET DECLARE mediaan1.
AGGREGATE
  /OUTFILE='mediaan1'
  /BREAK=period geoitem
  /v2207_nbw_peil_mediaan=MEDIAN(E_PEIL).
DATASET ACTIVATE mediaan1.
string geolevel (a25).
compute geolevel='gemeente_cluster'.
DATASET ACTIVATE mediaan.
ADD FILES /FILE=*
  /FILE='mediaan1'.
EXECUTE.
dataset activate basis.
delete variables geoitem.



rename variables vervoerregio=geoitem.
alter type geoitem (a15).
DATASET DECLARE mediaan1.
AGGREGATE
  /OUTFILE='mediaan1'
  /BREAK=period geoitem
  /v2207_nbw_peil_mediaan=MEDIAN(E_PEIL).
DATASET ACTIVATE mediaan1.
string geolevel (a25).
compute geolevel='vervoerregio'.
DATASET ACTIVATE mediaan.
ADD FILES /FILE=*
  /FILE='mediaan1'.
EXECUTE.
dataset activate basis.
delete variables geoitem.


* afwerken verzamelbestand.
dataset activate mediaan.
dataset close mediaan1.
* opkuisen code.
compute geoitem=ltrim(rtrim(geoitem)).

* verwijderen gebieden die niet toegekend worden in dit gebiedsniveau.
FILTER OFF.
USE ALL.
SELECT IF (geoitem ~= "").
EXECUTE.

* enkel vanaf 2010 meenemen.
FILTER OFF.
USE ALL.
SELECT IF (period >2009 & period < 2019).
EXECUTE.

* handig sorteren voor swing.
sort cases period (a) geolevel (a) geoitem (a).

SAVE TRANSLATE OUTFILE=datamap +  'upload\niet_aggregeerbaar.xlsx'
  /TYPE=XLS
  /VERSION=12
  /MAP
  /FIELDNAMES VALUE=NAMES
  /CELLS=VALUES
/replace.



SAVE TRANSLATE OUTFILE=datamap +  'upload\niet_aggregeerbaar.csv'
  /TYPE=CSV
  /ENCODING='Locale'
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=VALUES.
