* Encoding: windows-1252.

* todo:
- check mediaan statsec; check ontbreken totaal warmtepomp
- lange termijn: statsec onbekend voor de nieuwe fusies



* filtering statsec.
GET DATA  /TYPE=TXT
  /FILE=datamap + 'statsec\statsec_20190704_2018.csv'
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
sort cases aangifte_id (a).


GET
  FILE=datamap +  'verwerkt\verzamelbestand.sav'.
DATASET NAME basis WINDOW=FRONT.
sort cases aangifte_id (a).


DATASET ACTIVATE statsec.
* Identify Duplicate Cases.
SORT CASES BY AANGIFTE_ID(A).
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

sort cases aangifte_id (a).
dataset activate basis.
MATCH FILES /FILE=*
  /TABLE='statsec'
  /BY AANGIFTE_ID.
EXECUTE.
dataset close statsec.




DATASET ACTIVATE basis.
RECODE statsec (''=0) (else=1) INTO has_statsec.
EXECUTE.

compute aanvraag_jaar=number(char.substr(AANVRAAG_DATUM,1,4),f4.0).
compute indien_jaar=number(char.substr(INGEDIEND_DATUM,1,4),f4.0).
EXECUTE.

FILTER OFF.
USE ALL.
SELECT IF (has_statsec = 0 & indien_jaar>=2019).
EXECUTE.

match files
/file=*
/keep=aangifte_id nis_code.
EXECUTE.


SAVE TRANSLATE OUTFILE=datamap + 'statsec\statsec_aangifte_id_nodig_voor_pinc.csv'
  /TYPE=CSV
  /ENCODING='Locale'
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=VALUES.
