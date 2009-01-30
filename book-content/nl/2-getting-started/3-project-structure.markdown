# Project structuur

* This will become a table of contents (this text will be scraped).
{:toc}

De typische structuur van een nieuwe Merb app (gegenereerd met ``merb-gen app``) 
ziet er ongeveer uit als volgt:

    Application directory (Merb.root)
      - app
        - controllers
        - helpers
        - models
        - views
          - exceptions
          - layout
      - autotest
      - config
        - environments
      - doc
      - gems
      - merb
      - public
        - images
        - javascripts
        - stylesheets
      - spec
      - tasks

Hier volgt een kort beschrijving van elke directory en zijn doel.

## app
In deze directory zal je het grootste deel van je tijd doorbrengen, 
omdat het de "kern" van je Merb applicatie bevat.

### controllers
Al uw applicatie controllers zijn hier opgeslagen (geen verrassing aldaar).
Controllers zijn typisch genoemd in meervoudsvorm.
Bijvoorbeeld, indien de een "``Page``" model hebt, 
zal de controller file hoogstwaarschijnlijk ``pages.rb`` worden genoemd.
Dit is eenvoudig een conventie, maar 
je bent vrij je controllers te noemen zoals je zelf wil.
Zie de [controllers][] sectie voor meer informatie.

### models
Deze directory bevat je model klassen.
Deze klassen dienen gewoonlijk voor je [ORM][]s, 
deze geven object-georienteerde toegang tot je database tabellen.
Zie de [modellen][] sectie voor meer info.

### views
Alle templates worden hier geplaatst.
Standaard bevat deze directory ``exceptions`` 
en ``layout`` subdirectories.
De ``exceptions`` directory bevat templates 
die over het algemeen te maken hebben met HTTP errors.
Bijvoorbeeld, een nieuwe Merb app 
bevat een ``not_found.html.{erb,haml}`` bestand, 
die overeenkomt met de 404 HTTP status code.
De ``layout`` directory bevat de algemene applicatie templates, 
waarin actie templates kunnen worden gerenderd.
De standaard application layout file 
noemt ``application.html.{erb,haml}``.
Zie de [views][] sectie voor meer informatie.

## config
Yep, je raadt het al. 
De Merb configuratie-bestanden bevinden zich hier.
De ``router.rb`` file bevat je applicatie URL [routes][], 
die de structuur, volgorde en uitzicht van je URLs defineert.
Een andere belangrijke file, ``init.rb``, behandeld de basis Merb configuratie.
Hier configureerd je de ORM, de template engine, 
en het test framework.
Je kan ook custom configuraties toevoegen aan de ``Merb::BootLoader`` 
in zijn ``before_app_loads`` en ``after_app_loads`` blocken.
Een ander belangrijk bestand, ``dependencies.rb``, 
is waar je de applicatie afhankelijkheden kan definiëren: 
andere libraries of gems die je application vereist.
Elke dependency in deze file zal worden geladen bij het opstarten van je Merb app.

### environments
Hier bevinden zich alle omgevings specifieke configuratie bestanden.
Hier bevinden zich een aantal standaard (pure Ruby) configuratie bestanden; 
elk een komt overeen met een specifieke Merb omgeving 
(development, production, etc.).

## gems
Wanneer je klaar bent om je applicatie te  [deployen][], 
is het aanbevolen dat je al je afhankelijkheden [bundelt][] 
binnen de applicatie directory.
De ``gems`` directory is waar deze verpakte afhankelijkheden 
worden geplaatst.
Tijdens het opstarten van de Merb applicatie, 
zal elke gem in deze directory, voorrang hebben op de system-wide gems.

## public
Hier bevinden zich de "statische" bestanden, 
zoals de ``favicon.ico`` en ``robots.txt`` files.

### images
Alle afbeeldingen die je templates nodig hebben, gaan hierheen.

### javascripts
In een standaard "Merb stack", bevat deze directory twee bestanden: 
``application.js`` en ``jquery.js``.
Standaard bevat de Merb stack 
het mooie [jQuery][] JavaScript framework.

Indien je relatief kleine hoeveelheden applicatie-speciefieke JavaScript code hebt, 
zou je deze in de ``application.js`` file moeten zetten.
Als dit onwerkbaar blijkt, kan je hulp bestanden toevoegen waar nodig.

### stylesheets
In overeenstemming met het principe van de "separation of concerns",
moeten visuele stijlen in stylesheet worden geplaatst.
Wanneer je een Merb app genereert, 
maakt dit een stylesheet bestand aan (met de naam ``master.css``), 
dat kan worden aangepast zoals je wenst.

## spec
Gebruik je [rspec][] als je [test][] framework, 
dan bevat deze directory je testen.
Standaard, bevat deze directory twee bestanden: 
een lege ``spec.opts`` file, 
die je kan gebruiken om command-line argumenten door te geven naar rspec 
(toevoegen van kleur output, enz.) en ``spec_helper.rb``, 
waar je onder meer de actuele spec runner kan aanpassen .

## tasks
Deze directory bevat Merb [thor][] taken.



<!-- Links -->
[bundelt]:          /nl/deployment/bundle
[controllers]:      /nl/getting-started/controllers
[deployen]:         /nl/deployment
[jQuery]:           http://jquery.com/
[modellen]:         /nl/getting-started/models
[ORM]:              http://en.wikipedia.org/wiki/Object-relational_mapping
[routes]:           /nl/getting-started/router
[RSpec]:            http://rspec.info/
[test]:             /nl/testing-your-application
[thor]:             http://wiki.merbivore.com/faqs/thor
[views]:            /nl/getting-started/views
