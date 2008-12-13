# Genereer een applicatie
Merb komt met een generator (<tt>merb-gen</tt>) voor het aanmaken van Merb applicaties.
De generator kan verschillende types van Merb applicaties genereren; om de beschikbare generator opties te zien, typ je

    $ merb-gen -h

Laat ons het nu even houden op de verschillende types van Merb applicaties die kunnen gegenereerd worden.

## Types
Merb kan gebruikt worden voor alles varierend van zeer kleine, snelle, enkel-bestand applicaties tot grote, complexe web-diensten. 
Verschillende applicatie-structuren kunnen worden gegenereerd, afhankelijk van de noden van de developer.

De verschillende applicatie-structuren die je kan genereren zijn <tt>app</tt>, <tt>core</tt>, <tt>flat</tt>, en <tt>very_flat</tt>.

### App
Dit is de opinionated Merb stack.
Dit genereert een volledige applicatie directory structuur met een volledige set van de configuratiebestanden.
Dit voegt ook een <tt>config/dependancies.rb</tt> bestand die alles bevat van <tt>merb-more</tt> en <tt>DataMapper</tt>.

    $ merb-gen app my-application

Deze applicatie heeft alles wat nodig is om te starten met het bouwen van een eerste klas web-applicatie, dit is het meest vergelijkbaar met de standaard structuur van Rails. 
Een groot deel van dit boek zal verder gaan in de veronderstelling dat u bent gestart op deze manier.

De applicatie kan worden opgestart door <tt>merb</tt> te runnen in de root directory van de applicatie.
Dit commando start Merb op de default poort 4000.
Om je applicatie in actie te zien, open je [http://localhost:4000/](http://localhost:4000/).

### Core
Core zal de volledige applicatie directory structuur genereren met een volledige set van de configuratiebestanden.
In tegenstelling met <tt>app</tt> -- de opinionated full stack -- worden geen dependencies toegevoegd.

    $ merb-gen core my-application

Start de applicatie door <tt>merb</tt> te starten de root directory van de applicatie.
Merk op dat, in tegenstelling met de andere drie  gegenereerde apps, er geen default inhoud is in core.
Het bezoeken van  [http://localhost:4000/](http://localhost:4000/) zal een fout tonen tot de inhoud en routing zijn toegevoegd.

### Flat
Een flat applicatie bevat alle logica in een enkele file, maar heeft verschillende bestanden voor configuratie en een eigen view directory.

    $ merb-gen flat my-application

Flat applicatiess worden opgestart, net als de andere gegenereerde merb applicaties, door <tt>merb</tt> te starten in root directory van de applicatie.
Per default, worden alle methodes in de <tt>my-application</tt> class behandeld als acties met <tt>my-application</tt> als de controller. bvb : [http://localhost:4000/my-application/foo](http://localhost:4000/my-application/foo)

Deze zal <tt>MyApplication#foo</tt> oproepen en rendert de output van de <tt>foo.html.*</tt> template.

### Very Flat
Een Very Flat applicatie is vergelijkbaar met andere Ruby micro frameworks, waarbij de volledige applicatie zich in een enkel bestand bevindt.

    $ merb-gen very_flat my-applcation

Om de very flat applicatie te starten, start je Merb met het volgende commando (in je applicatie directory):

    $ merb -I my-applcation.rb

Dit start Merb op de default port (4000). Om je applicatie in actie zien, bezoek je [http://localhost:4000/](http://localhost:4000/).





