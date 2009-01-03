#Modellen

* This will become a table of contents (this text will be scraped).
{:toc}

In grote lijnen zijn modellen zijn de programmatorische vertegenwoordiging 
van de begrippen en gegevens die een applicatie gebruikt. 
In een blog applicatie, zijn dit zaken 
zoals berichten, reacties en gebruikers. 
In een winkel-front applicatie, 
zijn dit producten, klanten, shopping carts, verkoopsdata, enz. .. 
Merb werd ontworpen om ontwikkelaars zo veel mogelijk vrijheid te geven 
in de beschrijving van hun modellen. 
Modellen kunnen alles zijn wat een ontwikkelaar kan voorstellen d.m.v Ruby klassen.

Dit gezegd zijnde zullen de meerderheid van de applicaties
een vorm van [ORM][] (Object Relational Mapper) gebruiken
om data op disk te bewaren tussen de requests.
De meeste apps stockeren hun data onder een vorm van een database.
De standaard Merb Stack gebruikt [DataMapper][] om te communiceren 
met een SQLite database.
Dit is een uitstekende keuze voor een eenvoudige ontwikkeling van nieuwe projecten.

Eens in productie echter,
is het doorgaans aanbevolen dat developers de overgang maken  
naar een van de krachtiger database-engines 
zoals [PostgreSQL][] of [MySQL][].
Projecten die overkomen uit de Rails wereld
kunnen nog steeds van [ActiveRecord][] modellen gebruik maken; 
Merb supporteert ook deze.

De rest van dit hoofdstuk is gericht op het gebruik van DataMapper
om Model klassen aan te maken.

## Attributen

In een DataMapper model, worden attributen gedefinieerd met de ``property`` methode.
Deze methode neemt de naam van het attribuut, een data type,
en een hash van opties.
In tegenstelling met ActiveRecord, vereist een DataMapper model geen veschillende migratie files
(hoewel migraties wel zijn gesupporteerd).
Hier s een nogal standaard DataMapper model:

    class Article
      include DataMapper::Resource
      property :id,           Serial
      property :title,        String
      property :content,      Text
      property :published_at, DateTime
    end
{:lang=ruby html_use_syntax=true}

Zie de [properties][] sectie van de DataMapper site voor meer details.

## Validaties

Je kan model validaties doen op twee verschillende manieren.
Ofwel definieer je hem op hetzelfde ogenblik als de attribuut definitie
ofwel gebruik je een expliciete ``validates_*`` methode.
De volgende twee voorbeelden zijn equivalent:

    # Using "auto-validations", defined with the property.
    class Person
      include DataMapper::Resource
      property :id,   Serial
      property :name, String,  :nullable => false
      property :age,  Integer, :length   => 1..150
    end

    # Using the "validates_*" methods.
    class Person
      include DataMapper::Resource
      property :id,   Serial
      property :name, String
      property :age,  Integer

      validates_present :name
      validates_length  :age, :within => 1..150
    end
{:lang=ruby html_use_syntax=true}
Voor meer informatie, zie de DataMapper's [validaties][] pagina.

## Associaties

DataMapper heeft een heel flexibele manier om associaties te definieren tussen je modellen.
Alle associatie types worden ondersteund, waaronder One-To-Many, Many-To-Many, enz.
Associaties worden geconfigureerd d.m.v. de ``has`` en de  ``belongs_to`` methodes.

Laat ons zeggen dat je een blog applicatie schrijft.
Deze applicatie heeft Article en Comment modellen.
Hier is hoe we deze associatie zouden kunnen opzetten:

    class Article
      include DataMapper::Resource
      # Set up properties.
      has n, :comments
    end

    class Comment
      include DataMapper::Resource
      # Set up properties.
      belongs_to :article
    end
{:lang=ruby html_use_syntax=true}

Dit geeft je methodes om met de associaties te werken.

    article = Article.first
    article.comments  # Returns all associated comments.
    comment = Comment.first
    comment.article   # Returns the parent Article.
{:lang=ruby html_use_syntax=true}

Indien je het Article model bekijkt,
merk je de "mythiche, magische ``n``".
Deze methode is een shortcut voor ``oneindigheid``
en wordt gebruikt om de "has many" associatie te voorzien.

Het opzetten van een "has one" associatie is zo eenvoudig als het doorgeven van de integer ``1``
(een) aan de  ``has`` methode.

Bij voorbeeld:

    class Person
      include DataMapper::Resource
      # setup properties
      has 1, :coffee_cup
    end

    class CoffeeCup
      include DataMapper::Resource
      # setup properties
      belongs_to :person
    end
{:lang=ruby html_use_syntax=true}

Zoals de ``has many`` associatie in Rails,
voorzien deze associaties een aantal helper methodes:

    person = Person.first
    person.coffee_cup  # Returns the person's cup.
    cup = CoffeeCup.first
    cup.person  # Returns the cup's owner.
{:lang=ruby html_use_syntax=true}

Voor complexere voorbeelden, zoals de ``has many through``,
verwijzen we naar de DataMapper's [associaties][] pagina.

## Callbacks

Callbacks laten je toe om verschillende methodes te "hooken",
om zo bijkomende functionaliteit te voorzien
of (bij voorbeeld) te verzekeren dat een property werd geformatteerd op een bepaalde manier.
DataMapper ondersteunt callbacks gebruik makend van een [aspect-geörienteerde][] benadering
en omvat (o.a.) de ``before`` en ``after`` methodes.

Laat ons zeggen dat je een Comment model hebt.
En je wil ervoor zorgen dat de ``homepage`` property begint met "http://",
zonder van de persoon te eisen dat hij dit expliciet voorziet.
Hier is één manier om dit te bereiken:

    class Comment
      include DataMapper::Resource
      property :homepage, String

      before :save, :sanitize_homepage

      private

      def sanitize_homepage
        # If the homepage already begins with "http://", just return.
        return if homepage =~ /^http[s]?:\/\/\w/
        self.homepage = 'http://' + homepage
      end
    end
{:lang=ruby html_use_syntax=true}

Zoals je ziet, neemt de ``before`` methode (als symbolen)
de naam van de methode die je zou willen "aanroepen" (hooken) 
en de naam van de methode die het werk zal doen.
Je kan ook een block doorgeven:

    before :save do
      # ... the monkey dance.
    end
{:lang=ruby html_use_syntax=true}

Je kan callbacks definieren voor zo ongeveer elke methode, waaronder class methodes.
Voor meer details, verwijzen we naar de DataMapper's [hooks][] pagina.


<!-- Links -->
[ActiveRecord]:    http://en.wikipedia.org/wiki/ActiveRecord_%28Rails%29
[aspect-geörienteerde]: http://en.wikipedia.org/wiki/Aspect_oriented
[associaties]:     http://datamapper.org/doku.php?id=docs:associations
[DataMapper]:      http://datamapper.org/doku.php
[hooks]:           http://datamapper.org/doku.php?id=docs:hooks
[MySQL]:           http://en.wikipedia.org/wiki/MySQL
[ORM]:             http://en.wikipedia.org/wiki/Object-relational_mapping
[PostgreSQL]:      http://en.wikipedia.org/wiki/PostgreSQL
[properties]:      http://datamapper.org/doku.php?id=docs:properties
[SQLite]:          http://www.sqlite.org/
[validaties]:      http://datamapper.org/doku.php?id=docs:validations
