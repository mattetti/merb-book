# Genereer een applicatie

* This will become a table of contents (this text will be scraped).
{:toc}

Merb komt met een generator (``merb-gen``) 
voor het aanmaken van Merb applicaties.
De generator kan verschillende types van Merb applicaties genereren; 
om de beschikbare generator opties te zien, typ je

    $ merb-gen -H
{:lang=shell html_use_syntax=true}

Laat ons het nu even houden bij de verschillende types van Merb applicaties 
die kunnen gegenereerd worden.

## Types
Merb kan gebruikt worden voor alles van zeer kleine, snelle, enkel-bestand applicaties 
tot grote, complexe web-diensten. 
Verschillende applicatie-structuren kunnen worden gegenereerd, 
afhankelijk van de noden van de developer.
De verschillende applicatie-structuren die je kan genereren 
zijn ``app``, ``core``, ``flat``, and ``very_flat``.

### App
Dit is de opinionated Merb stack.
Dit genereert een volledige applicatie directory structuur 
met een volledige set van de configuratiebestanden.
Dit voegt ook een ``config/dependencies.rb`` bestand 
die alles bevat van ``merb-more`` en ``DataMapper``.

    $ merb-gen app my-application
{:lang=shell html_use_syntax=true}

Deze applicatie heeft alles wat nodig is 
om te starten met het bouwen van een eerste klas web-applicatie, 
dit is het meest vergelijkbaar met de standaard structuur van Rails. 
Een groot deel van dit boek zal verder gaan in de veronderstelling 
dat je op deze manier bent gestart .

De applicatie kan worden opgestart door ``merb`` 
te runnen in de root directory van de applicatie.
Dit zal Merb starten op de standaard poort 4000.
Om je applicatie in actie te zien, bezoek je <http://localhost:4000/>.

### Core
Core zal de volledige applicatie directory structuur genereren 
met een volledige set van de configuratiebestanden.
In tegenstelling met de ``app`` -- de opinionated full stack -- 
worden geen dependencies toegevoegd.

    $ merb-gen core my-application
{:lang=shell html_use_syntax=true}

Start de applicatie door ``merb`` 
te starten de root directory van de applicatie.
Merk op dat, in tegenstelling met de andere drie gegenereerde apps, 
er geen default inhoud is in core.
Bezoeken van <http://localhost:4000/> zal een fout genereren 
tot de inhoud en routing zijn toegevoegd.

### Flat
Een flat applicatie bevat al zijn logica in een enkele file, 
maar heeft verschillende bestanden voor configuratie en zijn eigen view directory.

    $ merb-gen flat my-application
{:lang=shell html_use_syntax=true}

Flat applicaties worden opgestart, net als elke andere gegenereerde merb applicatie, 
door ``merb`` te starten in root directory van de applicatie.
Standard worden alle methodes in de ``my-application`` class 
behandeld als acties met ``my-application`` als de controller. 
bvb : <http://localhost:4000/my-application/foo>

Deze zal ``MyApplication#foo`` oproepen 
en rendert de output van de ``foo.html.*`` template.

### Very Flat
Een Very Flat applicatie is vergelijkbaar met andere Ruby micro frameworks, 
waarbij de volledige applicatie zich in een enkel bestand bevindt.

    $ merb-gen very_flat my-applcation
{:lang=shell html_use_syntax=true}

Om de very flat applicatie te starten, start je Merb met het volgende commando 
(in je applicatie directory):

    $ merb -I my-applcation.rb
{:lang=shell html_use_syntax=true}

Dit start Merb op de default port (4000). 
Om je applicatie in actie zien, bezoek je <http://localhost:4000/>.





