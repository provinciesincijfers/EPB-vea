* Encoding: windows-1252.

GET
  FILE=datamap +  'verwerkt\verzamelbestand.sav'.
DATASET NAME basis WINDOW=FRONT.

* corrigeer enkele oude foutjes in de dump.
recode nis_code (24302=24104) (22002=23099).

compute afgeleide_variabelen=$sysmis.

* verwijder grotendeels lege records (N=0 in 2021).
FILTER OFF.
USE ALL.
SELECT IF (NIS_CODE > 0).
EXECUTE.


* nakijken niscodes.
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

frequencies provinciecode.

* TODO: wat doen we uiteindelijk met de dossiers op "vlaams" of "provincieniveau"?.


* einde verwijder foute niscodes.

*** begin.

* DATASET EERSTE RUN in 2019.

GET DATA  /TYPE=TXT
  /FILE=datamap + 'statsec\ontvangen_van_veka\resultaten\2019_mapping_aangifte_id_statistische_sector_voor_pic.csv'
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
DATASET NAME statsec0 WINDOW=FRONT.
sort cases aangifte_id (a).

* Identify Duplicate Cases.
SORT CASES BY AANGIFTE_ID(A) statsec(A).
MATCH FILES
  /FILE=*
  /BY AANGIFTE_ID
  /FIRST=PrimaryFirst
  /LAST=PrimaryLast.
DO IF (PrimaryFirst).
COMPUTE  MatchSequence=1-PrimaryLast.
ELSE.
COMPUTE  MatchSequence=MatchSequence+1.
END IF.
LEAVE  MatchSequence.
FORMATS  MatchSequence (f7).
COMPUTE  InDupGrp=MatchSequence>0.
SORT CASES InDupGrp(D).
MATCH FILES
  /FILE=*
  /DROP=PrimaryFirst InDupGrp MatchSequence.
VARIABLE LABELS  PrimaryLast 'Indicator of each last matching case as Primary'.
VALUE LABELS  PrimaryLast 0 'Duplicate Case' 1 'Primary Case'.
VARIABLE LEVEL  PrimaryLast (ORDINAL).
FREQUENCIES VARIABLES=PrimaryLast.
EXECUTE.

FILTER OFF.
USE ALL.
SELECT IF (PrimaryLast = 1).
EXECUTE.
delete variables PrimaryLast.


* DATASET TWEEDE RUN BEGIN 2021.
GET DATA  /TYPE=TXT
  /FILE=datamap + 'statsec\ontvangen_van_veka\resultaten\2021_mapping_aangifte_id_statistische_sector_voor_pic.csv'
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
DATASET NAME statsec1 WINDOW=FRONT.
sort cases aangifte_id (a).


* Identify Duplicate Cases.
SORT CASES BY AANGIFTE_ID(A) statsec(A).
MATCH FILES
  /FILE=*
  /BY AANGIFTE_ID
  /FIRST=PrimaryFirst
  /LAST=PrimaryLast.
DO IF (PrimaryFirst).
COMPUTE  MatchSequence=1-PrimaryLast.
ELSE.
COMPUTE  MatchSequence=MatchSequence+1.
END IF.
LEAVE  MatchSequence.
FORMATS  MatchSequence (f7).
COMPUTE  InDupGrp=MatchSequence>0.
SORT CASES InDupGrp(D).
MATCH FILES
  /FILE=*
  /DROP=PrimaryFirst InDupGrp MatchSequence.
VARIABLE LABELS  PrimaryLast 'Indicator of each last matching case as Primary'.
VALUE LABELS  PrimaryLast 0 'Duplicate Case' 1 'Primary Case'.
VARIABLE LEVEL  PrimaryLast (ORDINAL).
FREQUENCIES VARIABLES=PrimaryLast.
EXECUTE.

FILTER OFF.
USE ALL.
SELECT IF (PrimaryLast = 1).
EXECUTE.
delete variables PrimaryLast.



* DATASET DERDE RUN BEGIN 2022.
GET DATA  /TYPE=TXT
  /FILE=datamap + 'statsec\ontvangen_van_veka\resultaten\2022_mapping_aangifte_id_statistische_sector_voor_pic.csv'
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
DATASET NAME statsec2 WINDOW=FRONT.
sort cases aangifte_id (a).


* Identify Duplicate Cases.
SORT CASES BY AANGIFTE_ID(A) statsec(A).
MATCH FILES
  /FILE=*
  /BY AANGIFTE_ID
  /FIRST=PrimaryFirst
  /LAST=PrimaryLast.
DO IF (PrimaryFirst).
COMPUTE  MatchSequence=1-PrimaryLast.
ELSE.
COMPUTE  MatchSequence=MatchSequence+1.
END IF.
LEAVE  MatchSequence.
FORMATS  MatchSequence (f7).
COMPUTE  InDupGrp=MatchSequence>0.
SORT CASES InDupGrp(D).
MATCH FILES
  /FILE=*
  /DROP=PrimaryFirst InDupGrp MatchSequence.
VARIABLE LABELS  PrimaryLast 'Indicator of each last matching case as Primary'.
VALUE LABELS  PrimaryLast 0 'Duplicate Case' 1 'Primary Case'.
VARIABLE LEVEL  PrimaryLast (ORDINAL).
FREQUENCIES VARIABLES=PrimaryLast.
EXECUTE.

FILTER OFF.
USE ALL.
SELECT IF (PrimaryLast = 1).
EXECUTE.
delete variables PrimaryLast.

* VOEG HIER EEN NIEUW JAAR TOE WANNEER ER EEN NIEUW BESTAND IS.


* voeg hier een file  toe wanneer er eentje bijkomt.
DATASET ACTIVATE statsec0.
ADD FILES /FILE=*
  /FILE='statsec1'
  /FILE='statsec2'.
EXECUTE.
dataset close statsec1.
dataset close statsec2.


* Identify Duplicate Cases.
SORT CASES BY AANGIFTE_ID(A) statsec(A).
MATCH FILES
  /FILE=*
  /BY AANGIFTE_ID
  /FIRST=PrimaryFirst
  /LAST=PrimaryLast.
DO IF (PrimaryFirst).
COMPUTE  MatchSequence=1-PrimaryLast.
ELSE.
COMPUTE  MatchSequence=MatchSequence+1.
END IF.
LEAVE  MatchSequence.
FORMATS  MatchSequence (f7).
COMPUTE  InDupGrp=MatchSequence>0.
SORT CASES InDupGrp(D).
MATCH FILES
  /FILE=*
  /DROP=PrimaryFirst InDupGrp MatchSequence.
VARIABLE LABELS  PrimaryLast 'Indicator of each last matching case as Primary'.
VALUE LABELS  PrimaryLast 0 'Duplicate Case' 1 'Primary Case'.
VARIABLE LEVEL  PrimaryLast (ORDINAL).
FREQUENCIES VARIABLES=PrimaryLast.
EXECUTE.

FILTER OFF.
USE ALL.
SELECT IF (PrimaryLast = 1).
EXECUTE.
delete variables PrimaryLast.

sort cases AANGIFTE_ID (a).


dataset activate basis.
sort cases AANGIFTE_ID (a).
MATCH FILES /FILE=*
  /TABLE='statsec0'
  /BY AANGIFTE_ID.
EXECUTE.

dataset close statsec0.


* we zetten alles volgens de logica van de statsec 2020.
recode statsec
('11002J81-'='11002J8AN')
('11002K174'='11002K1NP')
('11002K1MN'='11002K1WN')
('11002P291'='11002P2AN')
('11002P21-'='11002P2AP')
('11002J94-'='11002P6AK')
('11002J923'='11002P6BK')
('11002J901'='11002P6CK')
('11002J912'='11002P6DK')
('11002J932'='11002P6EK')
('11002J881'='11002P6FK')
('11002Q2PA'='11002Q2PP').


* nakijken statsec en niscode.

* huidige statsec kan nog gebied onbekend van gemeente2018 bevatten, even leegmaken om ze direct weer mee te pakken.
if char.index(statsec,"ZZZZ")=6 statsec="".
EXECUTE.

* als er geen statsec is maar wel een niscode, ken toe aan gebied onbekend van de juiste gemeente.
if statsec="" & provinciecode>0 statsec=concat(string(niscode_nieuwegemeenten,f5.0),"ZZZZ").
* als er dan nog geen statsec is, ken toe aan "Vlaanderen gemeente onbekend".
if statsec="" statsec="99991ZZZZ".

* controleren of de dossiers geprikt zijn in een statsec van waar het dossier ligt.
compute statsec_nis=number(char.substr(statsec,1,5),f5.0).
alter type statsec_nis (f5.0).
recode statsec_nis (12030=12041)
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
(72029=72043).

* er zijn slechts enkele dossiers toegekend aan een statsec buiten de gemeente.
* net als de gevallen die niet gevonden werden, mogen deze in het onbekend gebied van de gemeente terecht komen.
if niscode_nieuwegemeenten ~= statsec_nis & provinciecode> 0 error=1.
frequencies error.

if provinciecode>0 & niscode_nieuwegemeenten ~= statsec_nis statsec=concat(string(nis_code,f5.0),"ZZZZ").
EXECUTE.

delete variables error.


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

frequencies aanvraag_jaar indien_jaar.





frequencies aard_werken.
recode aard_werken ("Nieuwbouw"=1) (else=0) into nieuwbouw.
value labels nieuwbouw
0 "renovatie/wijziging"
1 "nieuwbouw".
frequencies nieuwbouw.

frequencies bestemming.
recode bestemming ('ANDERE'=8)
('ANDERE MET KANTOOR'=8)
('GD NIET RESIDENTIEEL'=8)
('NIET RESIDENTIEEL EPN'=8)
('INDUSTRIE'=5)
('INDUSTRIE MET KANTOOR'=3)
('KANTOOR'=4)
('LANDBOUW'=7)
('NULL'=9)
(''=9)
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
frequencies bestemming_cat.

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
frequencies type_woning.

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
frequencies type_bebouwing.



recode e_peil (lowest thru -0.01 = -1) (0 thru highest =1) (missing=9) into e_peil_test.
freq e_peil_test.

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

compute m2_check=NEB_VOOR_VERWARMING/
NEB_VOOR_VERW_EENH_OPP.







* INDICATOREN SWING.
* enkel vanaf 2010 meenemen.
frequencies indien_jaar.
FILTER OFF.
USE ALL.
SELECT IF (indien_jaar >2009 & indien_jaar <= number(datajaar,f4.0)).
EXECUTE.
frequencies indien_jaar.
* enkel residentiele nieuwbouw for now.

FILTER OFF.
USE ALL.
SELECT IF (nieuwbouw = 1 & bestemming_cat = 1).
EXECUTE.



* er zijn enkele extreem grote panden. Deze wissen we als ze ook een onrealistisch laag energieverbruik hebben.
do if BRUTO_VLOER_OPPERVLAKTE_06>1000 & (NEB_VOOR_VERW_EENH_OPP < 10 | PRIMAIR_ENERGIE_VERBRUIK_M2 < 5).
compute BRUTO_VLOER_OPPERVLAKTE_06=$sysmis.
compute NEB_VOOR_VERW_EENH_OPP=$sysmis.
compute PRIMAIR_ENERGIE_VERBRUIK_M2=$sysmis.
end if.


* enkele missings corrigeren.
if missing(TOTAAL_PRIMAIR_ENERGIEVERBRUIK) TOTAAL_PRIMAIR_ENERGIEVERBRUIK=BRUTO_VLOER_OPPERVLAKTE_06*PRIMAIR_ENERGIE_VERBRUIK_M2*3.6.

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

* verrijken met ALLE gebieden.

* we willen een record voor elk gebied voor elk jaar.
* voor de bestaande data willen we verrijken met "bovenliggende gebiedsindelingen".

* we vertrekken van de lijst van alle nieuwe statsec.
GET DATA
  /TYPE=XLSX
  /FILE= gebiedsniveaus + 'verzamelbestanden\statsec_als_basis.xlsx'
  /SHEET=name 'statsec_als_basis'
  /CELLRANGE=FULL
  /READNAMES=ON
  /DATATYPEMIN PERCENTAGE=95.0
  /HIDDEN IGNORE=YES.
EXECUTE.
DATASET NAME verrijken WINDOW=FRONT.
sort cases statsec (a).

* we plakken die lijst voor elk jaar dat we nodig hebben onder elkaar.
compute indien_jaar=2010.
dataset copy kopie.
dataset activate kopie.
compute indien_jaar=indien_jaar+1.
dataset activate verrijken.
ADD FILES /FILE=*
  /FILE='kopie'.
EXECUTE.
dataset activate kopie.
compute indien_jaar=indien_jaar+1.
dataset activate verrijken.
ADD FILES /FILE=*
  /FILE='kopie'.
EXECUTE.
dataset activate kopie.
compute indien_jaar=indien_jaar+1.
dataset activate verrijken.
ADD FILES /FILE=*
  /FILE='kopie'.
EXECUTE.
dataset activate kopie.
compute indien_jaar=indien_jaar+1.
dataset activate verrijken.
ADD FILES /FILE=*
  /FILE='kopie'.
EXECUTE.
dataset activate kopie.
compute indien_jaar=indien_jaar+1.
dataset activate verrijken.
ADD FILES /FILE=*
  /FILE='kopie'.
EXECUTE.
dataset activate kopie.
compute indien_jaar=indien_jaar+1.
dataset activate verrijken.
ADD FILES /FILE=*
  /FILE='kopie'.
EXECUTE.
dataset activate kopie.
compute indien_jaar=indien_jaar+1.
dataset activate verrijken.
ADD FILES /FILE=*
  /FILE='kopie'.
EXECUTE.
dataset activate kopie.
compute indien_jaar=indien_jaar+1.
dataset activate verrijken.
ADD FILES /FILE=*
  /FILE='kopie'.
EXECUTE.
dataset activate kopie.
compute indien_jaar=indien_jaar+1.
dataset activate verrijken.
ADD FILES /FILE=*
  /FILE='kopie'.
EXECUTE.
dataset activate kopie.
dataset activate kopie.
compute indien_jaar=indien_jaar+1.
dataset activate verrijken.
ADD FILES /FILE=*
  /FILE='kopie'.
EXECUTE.
dataset activate kopie.
compute indien_jaar=indien_jaar+1.
dataset activate verrijken.
ADD FILES /FILE=*
  /FILE='kopie'.
EXECUTE.
dataset activate kopie.
compute indien_jaar=indien_jaar+1.
dataset activate verrijken.
ADD FILES /FILE=*
  /FILE='kopie'.
EXECUTE.
dataset activate kopie.
compute indien_jaar=indien_jaar+1.
dataset activate verrijken.
ADD FILES /FILE=*
  /FILE='kopie'.
EXECUTE.
dataset activate kopie.
compute indien_jaar=indien_jaar+1.
dataset activate verrijken.
ADD FILES /FILE=*
  /FILE='kopie'.
EXECUTE.
dataset activate kopie.
compute indien_jaar=indien_jaar+1.
dataset activate verrijken.
ADD FILES /FILE=*
  /FILE='kopie'.
EXECUTE.
dataset activate kopie.
compute indien_jaar=indien_jaar+1.
dataset activate verrijken.
ADD FILES /FILE=*
  /FILE='kopie'.
EXECUTE.
dataset activate kopie.
compute indien_jaar=indien_jaar+1.
dataset activate verrijken.
ADD FILES /FILE=*
  /FILE='kopie'.
EXECUTE.
dataset activate kopie.
compute indien_jaar=indien_jaar+1.
dataset activate verrijken.
ADD FILES /FILE=*
  /FILE='kopie'.
EXECUTE.

dataset activate verrijken.
frequencies indien_jaar.
dataset close kopie.
FILTER OFF.
USE ALL.
SELECT IF (indien_jaar <= number(datajaar,f4.0)).
EXECUTE.
frequencies indien_jaar.

sort cases statsec (a) indien_jaar (a).

* eerst voegen we de info toe aan de bestaande records.
DATASET ACTIVATE basis.
sort cases statsec (a) indien_jaar (a).
MATCH FILES /FILE=*
  /TABLE='verrijken'
  /BY  statsec indien_jaar.
EXECUTE.



* vervolgens voegen we de hele file onderaan toe. op die manier ontstaan er missings die we op nul kunnen zetten voor elke statsec waar géén dossiers zijn.
ADD FILES /FILE=*
  /FILE='verrijken'.
EXECUTE.
dataset close verrijken.

if gewest=4000 brussel=1.

* nieuwbouwwoningen afgewerkt in jaar X, dus norm afhankelijk van hoe lang geleden vergund.
rename variables indien_jaar=period.
rename variables statsec=geoitem.



sort cases period (a) geoitem (a).






DATASET DECLARE basicgem.
AGGREGATE
  /OUTFILE='basicgem'
  /BREAK=period geoitem
/brussel=max(brussel)
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
  /v2207_nbw_sompeil_open=sum(v2207_epb_sompeil_open).
DATASET ACTIVATE basicgem.
string geolevel (a25).
compute geolevel='statsec'.

if brussel=1 v2207_nbw_dossier=-99999.
if char.substr(geoitem,6,4)="ZZZZ" & missing(v2207_nbw_dossier) v2207_nbw_dossier=-99996.
if missing(v2207_nbw_dossier) v2207_nbw_dossier=0.


do if v2207_nbw_dossier=-99999.
recode
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
v2207_nbw_sompeil_open (ELSE=-99999).
end if.
do if v2207_nbw_dossier>=0.
recode
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
end if.
do if v2207_nbw_dossier=-99996.
recode
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
v2207_nbw_sompeil_open (missing=-99996).
end if.


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
v2207_nbw_sompeil_open (f8.0).



DELETE VARIABLES brussel.

SAVE TRANSLATE OUTFILE=datamap +  'upload\basic_statsec.xlsx'
  /TYPE=XLS
  /VERSION=12
  /MAP
  /FIELDNAMES VALUE=NAMES
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


compute v2207_nbw_primair_energieverbruik=TOTAAL_PRIMAIR_ENERGIEVERBRUIK/3.6.
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
/brussel=max(brussel)
 /v2207_nbw_dossier=SUM(v2207_epb_dossier) 
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


if brussel=1 v2207_nbw_dossier=-99999.
if char.substr(geoitem,6,4)="ZZZZ" & missing(v2207_nbw_dossier) v2207_nbw_dossier=-99996.
if missing(v2207_nbw_dossier) v2207_nbw_dossier=0.


do if brussel=1.
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
 (missing=-99999).
end if.

do if v2207_nbw_dossier>=0.
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
end if.

do if v2207_nbw_dossier=-99996.
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
 (missing=-99996).
end if.


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

DELETE VARIABLES brussel.

SAVE TRANSLATE OUTFILE=datamap +  'upload\detail_statsec.xlsx'
  /TYPE=XLS
  /VERSION=12
  /MAP
  /FIELDNAMES VALUE=NAMES
  /CELLS=VALUES
/replace.


* verzamel de mediaan data.
* start.
dataset activate basis.
delete variables geoitem.
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
SELECT IF (geoitem ~= "" & v2207_nbw_peil_mediaan>0).
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
