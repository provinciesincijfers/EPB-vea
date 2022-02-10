* Encoding: windows-1252.

* map met alle EPB data.
DEFINE datamap () 'E:\data\epb\' !ENDDEFINE.
* zet de ruwe bestanden in submap "ruw".
* maak een map "verwerkt" voor de verwerkte tussenbestanden.
* maak een map "upload" voor productieklare bestanden.

* OPGELET: als je een nieuw jaar verwerkt, overweeg dan om de bestaande bestanden in deze mappen te archiveren ipv te overschrijven.

* map waarbinnen je clone van repository provinciesincijfers/gebiedsniveaus staat.
DEFINE gebiedsniveaus () 'C:\github\gebiedsniveaus\' !ENDDEFINE.


* nieuw jaartal waarvoor we werken.
DEFINE datajaar () '2021' !ENDDEFINE.
