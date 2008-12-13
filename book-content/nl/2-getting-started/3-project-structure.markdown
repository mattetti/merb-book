# Project structuur
De typische structuur van een nieuwe Merb app (gegenereerd met <tt>merb-gen app</tt>) ziet er ongeveer uit als volgt:

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
In deze directory zal je het grootste deel van je tijd doorbrengen, omdat het de "kern" van je Merb applicatie bevat.

### controllers
Al uw applicatie controllers zijn hier opgeslagen (geen verrassing aldaar).
Controllers zijn typisch genoemd in meervoudsvorm.
Bijvoorbeeld, indien de een "<tt>Page</tt>" model hebt, zal de controller file hoogstwaarschijnlijk <tt>pages.rb</tt> worden genoemd.
Dit is eenvoudig een conventie, maar je bent vrij je controllers te noemen zoals je zelf wil.
Zie de  [controllers](/getting-started/controllers) sectie voor meer informatie.

### models
Deze directory bevat je model klassen.
Deze klassen dienen gewoonlijk voor je [ORM](http://en.wikipedia.org/wiki/Object-relational_mapping)s en geven object-georienteerde toegang tot je database tabellen.
Zie de [modellen](/getting-started/models) sectie voor meer info.

### views
Alle templates worden hier geplaatst.
Standaard bevat deze directory <tt>exceptions</tt> en <tt>layout</tt> subdirectories.
De <tt>exceptions</tt> directory bevat templates die over het algemeen te maken hebben met HTTP errors.
Bijvoorbeeld, een nieuwe Merb app bevat een <tt>not_found.html.{erb,haml}</tt> bestand, die overeenkomt met de 404 HTTP status code.
De <tt>layout</tt> directory bevat de algemene applicatie templates, waarin actie templates kunnen worden gerenderd.
De standaard application layout file noemt <tt>application.html.{erb,haml}</tt>.
Zie de [views](/getting-started/views) sectie voor meer informatie.

## config
Yep, je raadt het al. 
De Merb configuratie-bestanden bevinden zich hier.
De <tt>router.rb</tt> file bevat je applicatie URL [routes](/getting-started/router), die de structuur, volgorde en verschijning van je URLs defineert.
Een andere belangrijke file, <tt>init.rb</tt>, behandeld de basis Merb configuratie.
Hier configureerd je de ORM, de template engine, en het test framework.
Je kan ook custom configuraties toevoegen aan de <tt>Merb::BootLoader</tt> in zijn <tt>before_app_loads</tt> en <tt>after_app_loads</tt> blocken.
Een ander belangrijk bestand, <tt>dependencies.rb</tt>, is waar je de applicatie afhankelijkheden kan definiëren: andere libraries of gems die je application vereist.
Elke dependency in deze file zal worden geladen bij het opstarten van je Merb app.

### environments
Hier bevinden zich alle omgevings specifieke configuratie bestanden.
Hier bevinden zich een aantal standaard (pure Ruby) configuratie bestanden; elk een komt overeen met een specifieke Merb omgeving (development, production, etc.).

## gems
Wanneer je klaar bent om je applicatie te  [deployen](/deployment), is het aanbevolen dat je al je afhankelijkheden [bundelt](/deployment/bundle) binnen de applicatie directory.
De <tt>gems</tt> directory is waar deze verpakte afhankelijkheden worden geplaatst.
Tijdens het opstarten van de Merb applicatie, zal elke gem in deze directory, voorrang hebben op de system-wide gem.

## public
Hier bevinden zich de "statische" bestanden, zoals de <tt>favicon.ico</tt> en <tt>robots.txt</tt> files.

### images
Alle afbeeldingen die je templates nodig hebben, bevinden zich hier.

### javascripts
In een standaard "Merb stack", bevat deze directory twee bestanden: <tt>application.js</tt> en <tt>jquery.js</tt>.
Standaard bevat de Merb stack het mooie [jQuery](http://jquery.com/) JavaScript framework.

Indien je relatief kleine hoeveelheden applicatie-speciefieke JavaScript code hebt, zou je deze in de <tt>application.js</tt> file moeten zetten.
Als dit onwerkbaar blijkt, kan je hulp bestanden toevoegen waar nodig.

### stylesheets
In overeenstemming met het principe van de "separation of concerns", moeten visuele stijlen in stylesheet worden geplaatst.
Wanneer je een Merb app genereert, wordt een stylesheet bestand aangemaakt (met de naam <tt>master.css</tt>), dat kan worden aangepast zoals je wenst.

## spec
Gebruik je [rspec](http://rspec.info/) als je [test](/testing-your-application) framework, dan bevat deze directory je testen.
Standaard, bevat deze directory twee bestanden: een lege <tt>spec.opts</tt> file, die je kan gebruiken om command-line argumenten door te geven naar rspec (toevoegen van kleur output, enz.) en <tt>spec_helper.rb</tt>, waar je onder meer de actuele spec runner kan aanpassen .

## tasks
Deze directory bevat Merb [thor](http://wiki.merbivore.com/faqs/thor) taken.